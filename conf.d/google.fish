# The following is standard for Google. However, it causes the Terminal to run unbearably slow.                                                                                                                                                        [0/0]
# source /google/data/ro/teams/fish/google.fish

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
abbr --add rbt rabbit --verifiable test
abbr --add rbc rabbit --verifiable coverage
abbr --add rbm rabbit --verifiable mpm --mpm_build_arg="--label=$USER"
abbr --add irbb iblaze build -iblaze_blaze_binary rabbit
abbr --add irbc iblaze coverage -iblaze_blaze_binary rabbit
abbr --add :af /google/bin/releases/depserver-contrib-tools/affected_targets/affected_targets --test # List affected Blaze test targets. Remove `--test` for non-test targets.

# Borg

abbr --add bu borgcfg /path/to/borg up --skip_confirmation
abbr --add buc borgcfg /path/to/borg up
abbr --add bp borgcfg /path/to/borg print

# Fileutils

abbr --add flsl fileutil --gfs_user=user ls -a -lh
abbr --add fls fileutil ls -a -lh

# Piper

abbr --add gocloud /google/src/cloud/$USER && s
abbr --add gohead /google/src/head/depot/google3/

# Plx

alias plxutil /google/data/ro/teams/plx/plxutil

# Add additional execution to the path.

set -gx PATH $PATH $HOME/.bin

# # Auto re-new prodaccess
# # http://go/fish-shell#enable-proper-stty-settings-at-startup
# if status --is-interactive
#   echo 'Checking certification status (+8h before expiration)...'
#   if not gcertstatus -check_remaining=8h -quiet
#     gcert -prodssh=true
#   end
# end

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

# HG

function hg-empty-commit -d 'Creat an empty commit with hg'
  touch tmp
  hg add tmp
  hg commit -m 'tmp'
  hg rm tmp
  hg commit --amend -m $argv[1]
end
