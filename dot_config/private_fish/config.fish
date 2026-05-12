if status is-interactive
    # Commands to run in interactive sessions can go here
    # Alias
    alias ld='lazydocker'
    alias lg='lazygit'
    alias gemini='npx @google/gemini-cli'
    alias gemini-flash='npx @google/gemini-cli -m gemini-2.5-flash'

end

set -gx PATH $HOME/.local/bin $PATH

# Load shared environment variables
load_env

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
