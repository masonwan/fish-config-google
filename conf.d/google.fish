# The following is standard for Google. However, it causes the Terminal to run unbearably slow.                                                                                                                                                        [0/0]
# source /google/data/ro/teams/fish/google.fish

function proxy_call
  set -l cmd $argv
  log info $cmd
  eval $cmd
end

## Copy the last command to clipboard
alias copy-last "history | head -1 | tr -d '\n' | xclip -in -selection clipboard"

# Blaze/Rabbit

abbr --add bq blaze query
abbr --add bb blaze build
abbr --add ibb iblaze build
abbr --add br blaze run
abbr --add ibr iblaze run
abbr --add bt blaze test
abbr --add ibt iblaze test
abbr --add bm blaze mpm --stamp --mpm_build_arg="--label=$USER"
abbr --add rbb rabbit --verifiable build
abbr --add rbm rabbit --verifiable mpm --mpm_build_arg="--label=$USER"
abbr --add irbb iblaze build -iblaze_blaze_binary rabbit

# Borg

function bu -d 'borgcfg up'
  buc $argv --skip_confirmation
end

function buc -d 'borgcfg up'
  proxy_call "borgcfg $argv[1] up $argv[2..-1]"
end

function bp -d 'Borg config print'
  proxy_call "borgcfg $argv[1] print $argv[2..-1]"
end

# Fileutils

abbr --add flsl fileutil --gfs_user=commerce-sameday-delivery-logs ls -a -lh
abbr --add fls fileutil ls -a -lh
abbr --add frm fileutil rm -R

# Piper

abbr --add pg p4 g4d
abbr --add gocloud /google/src/cloud/$USER
abbr --add gohead /google/src/head/depot/google3/

# Plx

alias plxutil /google/data/ro/teams/plx/plxutil

# Add additional execution to the path.

set -gx PATH $PATH $HOME/.bin

# Auto re-new prodaccess

# http://go/fish-shell#enable-proper-stty-settings-at-startup
if status --is-interactive
  echo 'Checking certification status (+8h before expiration)...'
  if not gcertstatus -check_remaining=8h -quiet
    gcert -prodssh=true
  end
end

function try-until-succeed -d "Try a command until it exits with code 0"
  while true
    eval $argv
    if test $status = 0
      log info 'The run succeeded'
      break
    end
    log info 'The run failed. Waiting for 1 sec...'
    sleep 1
  end
end
