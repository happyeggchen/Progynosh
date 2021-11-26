function push -d "auto gitpush"
if [ "$argv[1]" = "" ]
  set commit_msg (date +"%Y-%m-%d_%T" -u)
else
  set commit_msg $argv[1]
end
git add .
git commit -m $commit_msg
git push
end
