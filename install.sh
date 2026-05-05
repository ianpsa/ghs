#!/usr/bin/env bash
# ghs installer

set -e

GH_REPO_URL="https://github.com/ianpsa/zsh-gitauth-manager.git"
INSTALL_DIR="${HOME}/ghs"

echo "Installing ghs..."

# On Apple Silicon, Homebrew lives at /opt/homebrew
if [[ "$(uname)" == "Darwin" && -d "/opt/homebrew/bin" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

# Check for zsh
if ! command -v zsh &> /dev/null; then
    echo "Error: zsh is required but not installed."
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "  Install with: brew install zsh"
    fi
    exit 1
fi

# Check for git
if ! command -v git &> /dev/null; then
    echo "Error: git is required but not installed."
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "  Install with: brew install git"
    fi
    exit 1
fi

# Check for gh
if ! command -v gh &> /dev/null; then
    echo "Warning: gh (GitHub CLI) is not installed. GitHub support will be unavailable."
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "  Install with: brew install gh"
    else
        echo "  Install from: https://github.com/cli/cli#installation"
    fi
fi

# Check for glab (optional)
if ! command -v glab &> /dev/null; then
    echo "Info: glab (GitLab CLI) is not installed. GitLab support will be unavailable."
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "  Install with: brew install glab"
    else
        echo "  Install from: https://gitlab.com/gitlab-org/cli"
    fi
fi

# Clone or update repo
if [[ -d "$INSTALL_DIR/.git" ]]; then
    echo "Updating existing installation..."
    cd "$INSTALL_DIR" && git pull
else
    echo "Cloning repository..."
    git clone "$GH_REPO_URL" "$INSTALL_DIR"
fi

# Create state files if they don't exist
[[ ! -f "${HOME}/.ghs_state" ]]     && touch "${HOME}/.ghs_state"     && echo "Created ~/.ghs_state"
[[ ! -f "${HOME}/.ghs_email_map" ]] && touch "${HOME}/.ghs_email_map" && echo "Created ~/.ghs_email_map"
[[ ! -f "${HOME}/.ghs_log" ]]       && touch "${HOME}/.ghs_log"       && echo "Created ~/.ghs_log"

# Add to zshrc
ZSHRC="${HOME}/.zshrc"
GHS_LINE='export PATH="$HOME/ghs:$PATH"'

if ! grep -q "ghs" "$ZSHRC" 2>/dev/null; then
    echo "" >> "$ZSHRC"
    echo "# ghs - GitHub/GitLab account switcher" >> "$ZSHRC"
    echo "$GHS_LINE" >> "$ZSHRC"
    echo "Added ghs to ~/.zshrc"
else
    echo "ghs already in PATH"
fi

echo ""
echo "Installation complete!"
echo "Restart your terminal or run: source ~/.zshrc"
echo ""
echo "Usage:"
echo "  ghs          - Switch to next account"
echo "  ghs -l       - List accounts"
echo "  ghs <name>   - Switch to specific account"
