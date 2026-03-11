# ghs - Alternador de Contas GitHub/GitLab

Uma ferramenta CLI simples para alternar entre contas GitHub e GitLab usando `gh auth switch` para GitHub e gerenciamento de estado para GitLab.

## Funcionalidades

- Alternar entre todas as suas contas GitHub e GitLab
- Descobre automaticamente contas das configurações do `gh` e `glab`
- Funciona com múltiplas contas GitHub e múltiplas instâncias GitLab
- Comando único para alternar: `ghs`

## Requisitos

- **zsh** - Shell (testado com zsh)
- **gh** - GitHub CLI (https://github.com/cli/cli)
- **glab** - GitLab CLI (https://gitlab.com/gitlab-org/cli) - opcional, para suporte ao GitLab

## Instalação

### Instalação Rápida

```bash
curl -sL https://raw.githubusercontent.com/archvarius/ghs/main/install.sh | zsh
```

### Instalação Manual

```bash
git clone https://github.com/archvarius/ghs.git ~/ghs
echo 'export PATH="$HOME/ghs:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## Configuração

### GitHub

Certifique-se de estar logado com múltiplas contas:

```bash
gh auth login
gh auth login --hostname github.com
gh auth switch -u seu-usuario
```

### GitLab

Logue com glab (opcional):

```bash
glab auth login --hostname git.inteli.edu.br
```

Ou configure apenas as chaves SSH para sua instância GitLab.

## Uso

```bash
# Alternar para próxima conta (flip-flop)
ghs

# Listar todas as contas
ghs -l
# ou
ghs --list

# Alternar para conta GitHub específica
ghs ianpsa
ghs iansimao-rivio

# Alternar para instância GitLab
ghs git.inteli.edu.br

# Mostrar ajuda
ghs -h
```

## Como Funciona

1. Lê contas `~/.config/gh/hosts.yml`
2. Lê hosts GitLab de `~/.config/glab-cli/config.yml`
3. Armazena a conta atual em `~/.ghs_state`
4. Para contas GitHub: usa `gh auth switch -u <conta>`
5. Para contas GitLab: apenas atualiza o estado (chaves SSH fazem a autenticação)

## Licença

MIT
