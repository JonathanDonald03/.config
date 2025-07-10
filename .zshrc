# Check if tmux is installed and we are not already inside a tmux session
if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
  # Try to attach to the session named "default", or create one if it doesn't exist
  tmux attach -t default || tmux new -s default
fi


fastfetch --logo macos_small

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
alias python='python3'
alias vim='nvim'
alias ls='colorls --light'
alias Darkmode='~/.ColorChange/ColorMyPencils.sh mocha'
alias Lightmode='~/.ColorChange/ColorMyPencils.sh latte'
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(starship init zsh)"

jdk() {
  if [ -z "$1" ]; then
    export JAVA_HOME=$(brew --prefix openjdk)/libexec/openjdk.jdk/Contents/Home
  else
    if [ -d "$(brew --prefix openjdk@$1 2>/dev/null)" ]; then
      export JAVA_HOME=$(brew --prefix openjdk@$1)/libexec/openjdk.jdk/Contents/Home
    else
      echo "JDK version $1 not found. Install it with: brew install openjdk@$1"
      return 1
    fi
  fi
  echo "Switched to Java $(java -version 2>&1 | awk -F '\"' '/version/ {print $2}')"
  java -version
}

jdk 21
