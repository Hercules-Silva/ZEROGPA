#!/bin/bash

STATUS_OK=true
MENSAGEM=""
DATA=$(date "+%Y-%m-%d %H:%M:%S")

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

KERNEL=$(uname -r)
if [[ "$KERNEL" == *6.14* ]]; then
  MENSAGEM+="✅ Kernel estável ($KERNEL)\n"
else
  MENSAGEM+="⚠️ Kernel fora do esperado: $KERNEL\n"
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

if [ "$STATUS_OK" = true ]; then
  echo -e "
███████╗███████╗██████╗  ██████╗  ██████╗ ██████╗  █████╗ 
╚══███╔╝██╔════╝██╔══██╗██╔═══██╗██╔════╝ ██╔══██╗██╔══██╗
  ███╔╝ █████╗  ██████╔╝██║   ██║██║  ███╗██████╔╝███████║
 ███╔╝  ██╔══╝  ██╔══██╗██║   ██║██║   ██║██╔═══╝ ██╔══██║
███████╗███████╗██║  ██║╚██████╔╝╚██████╔╝██║     ██║  ██║
╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝     ╚═╝  ╚═╝

 🧠 Sistema Estável | 🛰️ ZEROGPA MODE | $DATA

$MENSAGEM
🎯 Estado atual: Baixa entropia. Alta fluidez.
"
else
  echo -e "⚠️  [$DATA] O sistema ainda não está em pleno equilíbrio:\n"
  echo -e "$MENSAGEM"
fi
