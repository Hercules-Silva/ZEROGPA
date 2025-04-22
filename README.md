
# ZEROGPA - Monitoramento Inteligente do Sistema Fedora

ZEROGPA é um script shell leve e inteligente que atua como um "guardião do caos" ao iniciar o terminal. Ele executa uma série de testes automáticos para verificar a estabilidade, performance e integridade de um sistema Fedora otimizado, exibindo um banner informativo e desaparecendo após alguns segundos.

## 🚀 Para que serve

O ZEROGPA é ideal para quem:

- Quer verificar rapidamente se o sistema está estável e otimizado
- Utiliza Fedora com drivers NVIDIA
- Utiliza PipeWire, Wayland e ZRAM
- Deseja um monitoramento silencioso, mas presente
- Busca manter um kernel aprovado com fallback automático em caso de problemas

## ⚙️ Instalação

1. Baixe a última versão do script:

   ```bash
   wget https://github.com/Hercules-Silva/ZEROGPA/blob/main/fedora-banner-inteligente.sh -O ~/.fedora-banner-inteligente.sh
   ```

2. Dê permissão de execução:

   ```bash
   chmod +x ~/.fedora-banner-inteligente.sh
   ```

3. Adicione ao seu `.bashrc` ou `.zshrc`:

   ```bash
   echo "~/.fedora-banner-inteligente.sh" >> ~/.bashrc
   # ou ~/.zshrc dependendo do seu terminal
   ```

4. Reabra o terminal para ver o banner em ação.

## 🔢 Funcionamento

O script é executado sempre que o terminal é aberto e realiza:

- Verificação de serviços essenciais
- Leitura de logs recentes
- Medida de benchmark leve
- Validação do kernel atual

Após 10 segundos (se tudo estiver OK), o banner é automaticamente limpo do terminal.

## 🔍 Itens Verificados

O ZEROGPA realiza uma checagem minuciosa de diferentes componentes e serviços do sistema, a fim de garantir estabilidade, performance e previsibilidade. Abaixo estão os itens verificados, seus estados ideais e uma explicação sobre sua importância:

| Checagem            | Status Esperado    | Justificativa |
| ------------------- | ------------------ | ------------- |
| `nvidia-powerd`     | Desativado         | Pode causar travamentos ou comportamentos instáveis em sistemas com Wayland. [Leia mais](https://download.nvidia.com/XFree86/Linux-x86_64/latest/README/powermanagement.html) |
| `i2c_nvidia_gpu`    | Não carregado      | Módulo relacionado a sensores da NVIDIA, conhecido por causar falhas em alguns boots. |
| ZRAM                | Ativo              | Melhora a gestão de memória comprimindo páginas inativas na RAM. [Documentação oficial](https://www.kernel.org/doc/html/latest/admin-guide/blockdev/zram.html) |
| NVIDIA (nvidia-smi) | Respondendo        | Confirma o funcionamento adequado do driver proprietário NVIDIA. [Documentação](https://docs.nvidia.com/deploy/nvidia-smi/index.html) |
| Sessão Gráfica      | Wayland            | Moderno protocolo gráfico padrão no Fedora, mais seguro e eficiente. [Debug Wayland](https://fedoraproject.org/wiki/How_to_debug_Wayland_problems) |
| PipeWire            | Rodando            | Gerenciador de áudio moderno, substituto do PulseAudio e JACK. [pipewire.org](https://pipewire.org) |
| Disco /             | < 90% de uso       | Evita lentidões, erros de gravação e falhas em atualizações do sistema. |
| Kernel              | Aprovado           | Garante que o sistema está usando uma versão testada e confiável. |
| Boot                | < 30s recomendado  | Tempo de inicialização é um bom indicativo da integridade geral do sistema. |
| Logs                | Sem erros críticos | Detecta falhas silenciosas, prevenindo instabilidades. |
| Benchmark           | < 0.5s (Excelente) | Mede o tempo de resposta de tarefas simples para avaliar a fluidez geral. |

## 📄 Sistema de Aprovação de Kernel

- Se o kernel não estiver aprovado, você será perguntado:
  - Se deseja aprovar
  - Se deseja voltar ao anterior (fallback via GRUB)
  - Se deseja ser lembrado em X dias

Essas informações são salvas nos arquivos ocultos:

- `~/.zerogpa-kernels-aprovados`
- `~/.zerogpa-adiamento`

## 🌐 Personalizações

- Altere o tempo de exibição (`sleep 10`)
- Adicione novas checagens
- Substitua emojis e mensagens

## 🔧 Dicas úteis

- Resetar aprovações:
  ```bash
  rm ~/.zerogpa-kernels-aprovados ~/.zerogpa-adiamento
  ```
- Rodar manualmente:
  ```bash
  ~/.fedora-banner-inteligente.sh
  ```

## ✨ Sobre o nome ZEROGPA

"ZEROGPA" simboliza um sistema em estado de gravidade computacional nula. Um estado estável, fluido e sem esforço extra: o máximo de equilíbrio alcançado por um sistema operacional.

## 📚 Licença e Créditos

- Criado por Hercules H Silva
- Licença MIT ou livre uso pessoal
- Testado em Fedora 42 com NVIDIA GPU

---

"Quando o caos tenta escapar, o ZEROGPA detecta. Quando tudo está calmo, ele desaparece."

> — Manual do Caos Contido, v5.5+
