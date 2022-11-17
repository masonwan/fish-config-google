function upload-to-placer -d 'Upload one file to Placer'
  if test (count $argv) -lt 2;
    log error 'Not enough arguments: upload-to-placer [/source/file] [/placer/to/path]'
    return 1
  end

  set -l source $argv[1]
  set -l target $argv[2]
  set -l params $argv[3..-1]
  log info "Moving '$source' to '$target'..."

  # Create the scratch path by adding `scratch` on the 3rd level.
  set -l dir (echo $target | awk -F '/' '{
    for(i=2; i<=NF; i++) {
      printf("/%s", $i);
      if(i==3) printf("/scratch")
    }
  }')

  log "Preparing the scracth path '$dir'..."
  placer prepare $dir
  fileutil $params mkdir $dir

  log "Uploading the file..."
  fileutil $params cp $source $dir

  log "Publishing..."
  placer publish $dir

  log info "Completed. http://placer/?path=$target"
  fileutil $params ls -a -lh $target
end
