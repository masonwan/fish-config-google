function upload-to-placer -d 'Upload one file to Placer'
  if test (count $argv) -gt 1;
    log info "Extra args: $argv[2..-1]"
  end

  set -l original_dir $argv[1]
  log info "The target dir is $original_dir"

  # Create the scratch path by adding `scratch` on the 3rd level.
  set -l dir (echo $original_dir | awk -F '/' '{
    for(i=2; i<=NF; i++) {
      printf("/%s", $i);
      if(i==3) printf("/scratch")
    }
  }')

  log info "Preparing the scracth path '$dir'..."
  placer prepare $dir
  fileutil $argv[2..-1] mkdir $dir

  log info "Uploading the file..."
  fileutil $argv[2..-1] cp answers.csv $dir

  log info "Publishing..."
  placer publish $dir

  fileutil $argv[2..-1] ls -a -lh $original_dir
end
