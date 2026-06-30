# Frequently Used (Forgotten) Commands

## Clone a repo to a computer
Assuming that SSH authentication is set up:
`git clone git@github.com:username/repo-name.git`.

## Generate SSH authentication to Github (preferred method)
SSH keys are typically at `~/.ssh/id_rsa` (or `id_ed25519).
Either copy private and public keys from key repository, or create new one specifically for that computer.
If copied, ensure that permissions are set properly. `chmod 600 id_ed25519` and `chmod 644 id_ed25519.pub`.

Test the connection `ssh -T git@github.com`. 

## Generate a GitHub personal access token (not preferred method)
Go to https://github.com/settings/tokens
Click "Generate new token"
Choose:
Expiration date (90 days recommended)
Permissions (repo, read:org)
Copy and paste the token when prompted by Git

## Useful Git Commands

### Standard process to upload changes
git status
git add <file>
git commit -m "Your message"
git push origin main

### Update a repo that has newer changes than what it on local copy
git pull
or
git pull origin main (swap `main` for whichever branch was updated)

### Check to see if there are going to be issues due to changes also made on the local copy
git fetch
get status

That will show how far behind the local copy is without changing anything at this point. 

### If you have uncommitted local changes that need to be kept, stash them
git stash
git pull
git stash pop

## If you want to discard any local changes and just match the remote exactly (DESTRUCTIVE)
git fetch
get reset --hard origin/main

### GitHub Authentication
git config --global credential.helper store
After running this, your token will be saved after the first successful login.
