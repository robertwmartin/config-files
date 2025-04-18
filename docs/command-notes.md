Frequently Forgotten Commands

GitHub Authentication

git config --global credential.helper store

💡 After running this, your token will be saved after the first successful login.

How to generate a GitHub personal access token:

Go to https://github.com/settings/tokens

Click "Generate new token"

Choose:

Expiration date (90 days recommended)

Permissions (repo, read:org)

Copy and paste the token when prompted by Git

Useful Git Commands

git status
git add <file>
git commit -m "Your message"
git push origin main


