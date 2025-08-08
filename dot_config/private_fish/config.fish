if status is-interactive
    # Commands to run in interactive sessions can go here
    # Alias
    alias ld='lazydocker'
    alias lg='lazygit'
    alias gemini='npx @google/gemini-cli'

    # Zoxide
    zoxide init fish | source
end

set -gx PATH $HOME/.local/bin $PATH
