if status is-interactive
    # Commands to run in interactive sessions can go here
end

# pnpm
set -gx PNPM_HOME "/home/matteo/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
fish_ssh_agent
# pnpm end
