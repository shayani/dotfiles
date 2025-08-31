if status is-interactive
    # Commands to run in interactive sessions can go here
    # Alias
    alias ld='lazydocker'
    alias lg='lazygit'
    alias gemini='npx @google/gemini-cli'
    alias gemini-flash='npx @google/gemini-cli -m gemini-2.5-flash'

    # Zoxide
    zoxide init fish | source
end

set -gx PATH $HOME/.local/bin $PATH

set -x VISUAL nvim
set -x EDITOR nvim
/usr/bin/mise activate fish | source
