HEAD
# ZEROGPA

# 🛰️ ZEROGPA – Monitor de Estabilidade Computacional

```text
>>>>>>> 9209a0a (Atualiza README com painel ZEROGPA e instruções completas)
┌───────────────────────────────────────────┐
│           FEDORA ESTÁVEL v2.0            │
│       ZEROGPA :: Caos contido 🔒         │
├───────────────────────────────────────────┤
│ 🔧 Monitoramento ativo                   │
│ ⚙️  GPU estabilizada                     │
│ 🧠 Swaps gerenciados via zram            │
│ 🔍 Banner inteligente como alarme        │
│ 🚀 Performance sob controle manual       │
└───────────────────────────────────────────┘
<<<<<<< HEAD


```

> Um script inteligente para manter seu Fedora (ou qualquer Linux com NVIDIA) em estado de **baixa entropia computacional**.
> Quando tudo está perfeito... o ZEROGPA MODE é ativado. 😎

---

## ✅ O que ele faz?

Este script verifica automaticamente, toda vez que você abre o terminal:

- 🔧 Se o serviço `nvidia-powerd` está desativado
- 🧯 Se o módulo problemático `i2c_nvidia_gpu` está descarregado
- 🧠 Se o `zram` está funcionando como swap
- 🎮 Se o driver da NVIDIA está respondendo via `nvidia-smi`
- 🛰️ Se o Wayland está em uso
- 🔊 Se o PipeWire está ativo
- ⚙️ Se o kernel corresponde à versão estável testada
- 💽 Se o uso de disco está saudável (< 90%)

---

## 🛠 Como instalar

```bash
# Baixe o repositório
git clone https://github.com/Hercules-Silva/ZEROGPA.git
cd ZEROGPA

# Mova o script para a home
mv fedora-banner-inteligente.sh ~/.fedora-banner-inteligente.sh
chmod +x ~/.fedora-banner-inteligente.sh
```

Adicione ao final do seu `.bashrc` (ou `.zshrc`):

```bash
if [ "$PS1" ]; then
  ~/.fedora-banner-inteligente.sh
fi
```

---

## 📦 Também incluso

- `ZEROGPA_wallpaper.png`: Um wallpaper cósmico para celebrar a ordem
- `README.txt`: Instruções offline incluídas no pacote
- [`ZEROGPA_Pacote_Completo.zip`](https://github.com/Hercules-Silva/ZEROGPA/releases) *(recomendado)*

---

## 🧬 Requisitos

- Fedora (ou outra distro com bash + systemd)
- Driver proprietário da NVIDIA instalado
- PipeWire como sistema de áudio
- ZRAM configurado (opcional, mas recomendado)
- Sessão Wayland (para máxima compatibilidade)
- Comandos básicos: `lsmod`, `swapon`, `df`, `systemctl`, `nvidia-smi`

---

## 🎯 Quando tudo está OK...

Você verá isso ao abrir seu terminal:

```
🧠 Sistema Estável | 🛰️ ZEROGPA MODE
🎯 Estado atual: Baixa entropia. Alta fluidez.
```

Se algo estiver fora do esperado, o script exibe os detalhes calmamente.

---

## ✨ Licença

MIT — porque conhecimento merece liberdade.  
Criado por [Hercules H Silva](https://github.com/Hercules-Silva) com caos controlado, paixão por sistemas e um toque cósmico.
 9209a0a (Atualiza README com painel ZEROGPA e instruções completas)
