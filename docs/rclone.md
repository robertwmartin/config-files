# rclone 

## Installation
sudo apt update
sudo apt install rclone
(Optional: the apt version can lag behind. If you want the latest, curl https://rclone.org/install.sh | sudo bash — but apt's version is fine for this use case.)


## Set up the WebDAV remote
rclone config
Then:
Type n (new remote)
Name it something like mywebdav
From the storage type list, type webdav (or the number next to it)
Enter the URL of your WebDAV server (e.g. https://cloud.example.com/remote.php/webdav/)
For vendor, pick the matching option if your server is Nextcloud/ownCloud, otherwise choose other
Enter your username
For the password, choose y to type it in (rclone will obscure/encrypt it in the config file)
Leave bearer token blank unless you use one
Confirm and save (y at the end), then q to quit the config menu

## Test the connection
rclone lsd mywebdav:
This should list top-level folders on the remote. If it errors, double-check the URL (trailing slash matters for some servers) and credentials.

## Dry-run
clone copy mywebdav: /path/to/local/backup --dry-run --progress
This shows what would be copied without touching anything — good sanity check before moving 30GB.

## Run the real backup
mkdir -p ~/webdav-backup
rclone copy mywebdav: ~/webdav-backup --progress --transfers=8 --checkers=16 --log-file=~/rclone-backup.log --log-level=INFO

--progress — live transfer stats
--transfers=8 — 8 files at once (drop to 4 if the server seems overwhelmed, or push higher if it handles it fine)
--log-file — keeps a record you can check afterward for errors/skipped files
If it gets interrupted (network drop, laptop sleep, etc.), just re-run the exact same command — rclone will skip anything already copied correctly and pick up where it left off

## Verify afterward
rclone check mywebdav: ~/webdav-backup

This compares source and destination and reports any mismatches or missing files — good peace of mind after a big transfer.
A couple of practical notes: if you have a lot of very small files, transfer speed will be bottlenecked more by request overhead than bandwidth — bumping --transfers and --checkers helps there. And if you want this to run automatically on a schedule later, it's a straightforward cron job once you've confirmed the command works manually.

## Other options
By default, rclone will retry three times. That can be changed with `--retries x` where x is something other than 3.

## Don't use `rclone sync` without understanding what will happen
`rclone sync` — the destructive one

Makes the destination an exact mirror of the source. Anything on the destination that isn't on the source gets deleted. This is the one to be careful with — if you ran sync with Sqyre as source and your local folder as destination, any local files not present on Sqyre would be wiped out.


