# Start an interactive rebase from the commit before the earliest one with secrets
git rebase -i eeab1930238129f112b686a7159717a7c97d566d^

# This will open an editor. Change 'pick' to 'edit' for the commits you want to modify:
# edit eeab1930238129f112b686a7159717a7c97d566d
# edit 9554ae38c67591ec2c864f08cb2f7dca62a993e4

# For each commit, Git will stop and let you amend it
# For the first commit (eeab1930):
git rm --cached standalone.xml
git commit --amend
git rebase --continue

# For the second commit (9554ae3):
git rm --cached standalone.xml
git rm --cached src/main/webapp/WEB-INF/keykloak.json
git commit --amend
git rebase --continue

# Force push the changes
git push -f origin main