function load_env --description 'Load environment variables from ~/.config/env.sh'
    set -l env_file ~/.config/env.sh
    if test -f $env_file
        for line in (grep -E '^export ' $env_file)
            # Remove 'export ' prefix and split by '='
            set -l var (string replace 'export ' '' $line)
            set -l key (string split -m1 '=' $var)[1]
            set -l value (string split -m1 '=' $var)[2]
            # Remove surrounding quotes if present
            set value (string trim --chars='"' $value)
            set value (string trim --chars="'" $value)
            # Set the environment variable
            set -gx $key $value
        end
    end
end
