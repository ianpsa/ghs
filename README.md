# ghs - GitHub/GitLab Account Switcher

A simple CLI tool to switch between GitHub and GitLab accounts using `gh auth switch` for GitHub and state management for GitLab.

## Features

- Flip-flop between all your GitHub and GitLab accounts
- Auto-discovers accounts from `gh` and `glab` configurations
- Works with multiple GitHub accounts and multiple GitLab instances
- Single command to switch: `ghs`

## Requirements

- **zsh** - Shell (tested with zsh)
- **gh** - GitHub CLI (https://github.com/cli/cli)
- **glab** - GitLab CLI (https://gitlab.com/gitlab-org/cli) - optional, for GitLab support

## Installation

### Quick Install

```bash
curl -sL https://raw.githubusercontent.com/archvarius/ghs/main/install.sh | zsh
```

### Manual Install

```bash
git clone https://github.com/archvarius/ghs.git ~/ghs
echo 'export PATH="$HOME/ghs:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## Configuration

### GitHub

Make sure you're logged in with multiple accounts:

```bash
gh auth login
gh auth login --hostname github.com
gh auth switch -u your-username
```

### GitLab

Login with glab (optional):

```bash
glab auth login --hostname git.inteli.edu.br
```

Or just configure SSH keys for your GitLab instance.

## Usage

```bash
# Switch to next account (flip-flop)
ghs

# List all accounts
ghs -l
# or
ghs --list

# Switch to specific GitHub account
ghs ianpsa
ghs iansimao-rivio

# Switch to GitLab instance
ghs git.inteli.edu.br

# Show help
ghs -h
```

## How It Works

1. Reads GitHub accounts from `~/.config/gh/hosts.yml`
2. Reads GitLab hosts from `~/.config/glab-cli/config.yml`
3. Stores current account in `~/.ghs_state`
4. For GitHub accounts: uses `gh auth switch -u <account>`
5. For GitLab accounts: just updates the state (SSH keys handle authentication)

## License

MIT
