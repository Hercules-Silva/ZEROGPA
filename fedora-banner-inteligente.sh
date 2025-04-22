#!/bin/bash

ZEROGPA_VERSION="v5.4"
STATUS_OK=true
MENSAGEM=""
DATA=$(date "+%Y-%m-%d %H:%M:%S")
KERNEL_ATUAL=$(uname -r)
APROVADOS_FILE="$HOME/.zerogpa-kernels-aprovados"
ADIAMENTO_FILE="$HOME/.zerogpa-adiamento"

[ ! -f "$APROVADOS_FILE" ] && touch "$APROVADOS_FILE"

# === Checagens principais ===

if systemctl is-enabled nvidia-powerd &>/dev/null; then
  MENSAGEM+="❌ nvidia-powerd ATIVO\n"
  STATUS_OK=false
else
  MENSAGEM+="✅ nvidia-powerd desativado\n"
fi

if lsmod | grep -q i2c_nvidia_gpu; then
  MENSAGEM+="❌ Módulo i2c_nvidia_gpu CARREGADO\n"
  STATUS_OK=false
else
  MENSAGEM+="✅ Módulo i2c_nvidia_gpu ausente\n"
fi

if swapon --show | grep -q zram; then
  MENSAGEM+="✅ ZRAM ativo\n"
else
  MENSAGEM+="❌ ZRAM INATIVO\n"
  STATUS_OK=false
fi

if nvidia-smi &>/dev/null; then
  MENSAGEM+="✅ Driver NVIDIA OK (nvidia-smi)\n"
else
  MENSAGEM+="❌ NVIDIA falhando (nvidia-smi não responde)\n"
  STATUS_OK=false
fi

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
  MENSAGEM+="✅ Wayland em uso\n"
else
  MENSAGEM+="❌ X11 em uso (esperado: Wayland)\n"
  STATUS_OK=false
fi

if systemctl --user is-active pipewire &>/dev/null; then
  MENSAGEM+="✅ PipeWire rodando\n"
else
  MENSAGEM+="❌ PipeWire inativo\n"
  STATUS_OK=false
fi

USO_DISCO=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
if [[ "$USO_DISCO" -lt 90 ]]; then
  MENSAGEM+="✅ Uso de disco OK (${USO_DISCO}%)\n"
else
  MENSAGEM+="❌ Uso de disco ALTO (${USO_DISCO}%)\n"
  STATUS_OK=false
fi

# === Verificação de Kernel ===

KERNEL_APROVADO=false
if grep -q "$KERNEL_ATUAL" "$APROVADOS_FILE"; then
  MENSAGEM+="✅ Kernel aprovado ($KERNEL_ATUAL)\n"
  KERNEL_APROVADO=true
else
  MENSAGEM+="⚠️ Kernel não aprovado ($KERNEL_ATUAL)\n"
  SUGESTAO_KERNEL=true
fi

# === Tempo de Boot ===

BOOT_TEMPO=$(systemd-analyze | grep 'Startup finished' || true)
if [ -n "$BOOT_TEMPO" ]; then
  MENSAGEM+="ℹ️ Tempo de boot: $BOOT_TEMPO\n"
fi

# === Adiamento ativo? ===

ADIAR_KERNEL=false
if [ -f "$ADIAMENTO_FILE" ]; then
  ULTIMO=$(cat "$ADIAMENTO_FILE")
  HOJE=$(date +%s)
  if [ "$ULTIMO" -gt "$HOJE" ]; then
    ADIAR_KERNEL=true
  fi
fi

# === Logs recentes ===

ERROS=$(journalctl -p 3 -xb | grep -vE "gnome-keyring|vboxclient|ucsi_ccg" | head -n 5)
if [ -n "$ERROS" ]; then
  MENSAGEM+="⚠️ Erros recentes detectados no journalctl:\n$ERROS\n"
else
  MENSAGEM+="✅ Nenhum erro crítico recente detectado\n"
fi


# === Benchmark leve ===
start_time=$(date +%s.%N)
for i in {1..50000}; do :; done
end_time=$(date +%s.%N)
elapsed=$(echo "$end_time - $start_time" | bc)
rounded=$(printf "%.2f" "$elapsed")

if (( $(echo "$rounded < 0.5" | bc -l) )); then
  FLUIDEZ="🟢 Excelente"
elif (( $(echo "$rounded < 1.5" | bc -l) )); then
  FLUIDEZ="🟡 Moderada"
else
  FLUIDEZ="🔴 Lenta"
fi

MENSAGEM+="🧪 Benchmark leve: ${rounded}s para resposta do sistema\n"
MENSAGEM+="🎯 Nível de fluidez: $FLUIDEZ\n"

# === Resultado final ===
# === Resultado final ===

if [ "$STATUS_OK" = true ]; then
  echo -e "
███████╗███████╗██████╗  ██████╗  ██████╗ ██████╗  █████╗ 
╚══███╔╝██╔════╝██╔══██╗██╔═══██╗██╔════╝ ██╔══██╗██╔══██╗
  ███╔╝ █████╗  ██████╔╝██║   ██║██║  ███╗██████╔╝███████║
 ███╔╝  ██╔══╝  ██╔══██╗██║   ██║██║   ██║██╔═══╝ ██╔══██║
███████╗███████╗██║  ██║╚██████╔╝╚██████╔╝██║     ██║  ██║
╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝     ╚═╝  ╚═╝

 🧠 Sistema Estável | 🛰️ ZEROGPA $ZEROGPA_VERSION | $DATA

$MENSAGEM
🎯 Estado atual: Baixa entropia. Alta fluidez.
"

  if [ "$SUGESTAO_KERNEL" = true ] && [ "$ADIAR_KERNEL" = false ]; then
    echo -e "🧠 Tudo parece estável. Kernel ainda não aprovado."
    read -p "✅ Deseja aprovar este kernel agora? (s/N): " RESP_APROV
    if [[ "$RESP_APROV" =~ ^[sS]$ ]]; then
      echo "$KERNEL_ATUAL" >> "$APROVADOS_FILE"
      echo "✅ Kernel $KERNEL_ATUAL aprovado com sucesso."
    fi
    sleep 2
    clear
  else
    sleep 10
    clear
  fi
else
  echo -e "⚠️  [$DATA] O sistema ainda não está em pleno equilíbrio:
"
  echo -e "$MENSAGEM"
  sleep 10
  clear
fi
