function push -d "auto gitpush"
git add .
git commit -m (date +"%Y-%m-%d_%T" -u)
git push
end
