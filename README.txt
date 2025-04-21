ZEROGPA - Monitor de Estabilidade Computacional

Este pacote contém:
- Script de verificação de estabilidade do sistema (fedora-banner-inteligente.sh)
- Wallpaper em alta resolução com tema ZEROGPA
- Instruções de uso

🛠 Como usar o script:

1. Copie o arquivo 'fedora-banner-inteligente.sh' para sua home:
   mv fedora-banner-inteligente.sh ~/.fedora-banner-inteligente.sh

2. Torne-o executável:
   chmod +x ~/.fedora-banner-inteligente.sh

3. Adicione ao seu .bashrc ou .zshrc:
   if [ "$PS1" ]; then
     ~/.fedora-banner-inteligente.sh
   fi

4. Agora toda vez que abrir o terminal, ele verificará:
   - GPU (nvidia-smi)
   - PipeWire
   - Wayland
   - ZRAM
   - Kernel
   - Uso de disco
   - Módulos problemáticos
   - E exibe o banner ZEROGPA se tudo estiver perfeito!

🎯 Mantenha o Caos contido. ZEROGPA ativo.

🔧 Requisitos:

- Fedora com driver proprietário da NVIDIA instalado (para nvidia-smi funcionar)
- PipeWire ativo (padrão no GNOME)
- ZRAM configurado (opcional, mas recomendado)
- Sessão Wayland (XDG_SESSION_TYPE=wayland)
- bash e comandos comuns: systemctl, swapon, lsmod, df, uname, awk, tr
