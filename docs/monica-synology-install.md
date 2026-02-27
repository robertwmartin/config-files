# Monica CRM — Synology DSM Installation Guide

## Overview

Monica is a self-hosted personal CRM for managing your relationship network. This guide covers installation on a Synology NAS running DSM using Container Manager (Docker).

**Prerequisites:**
- Synology NAS running DSM 7.x
- Synology model that supports Container Manager (verify in Package Center)
- Administrator access to DSM

---

## Step 1: Install Container Manager

1. Open **Package Center** in DSM
2. Search for **Container Manager**
3. Install it
4. Once installed, a `docker` folder will appear in File Station at the root of your main volume

During installation, Container Manager will ask you to configure a dedicated subnet for container-to-container communication. Accept the default `172.17.0.1/16` unless your home network uses `172.17.x.x` addressing (uncommon).

---

## Step 2: Create the Folder Structure

In **File Station**, navigate to the `docker` folder and create the following structure:

```
docker/
└── monica/
    ├── data/
    └── db/
```

The `data` folder holds Monica's application files. The `db` folder holds the MySQL database.

**Set folder permissions:** Right-click each folder (`data` and `db`), select **Properties → Permission**. If the permission rows are greyed out, click **Advanced options → Make inherited permissions explicit**. Then change **Everyone** from **Read** to **Read & Write**. Check **Apply to this folder, sub-folders and files** before saving.

---

## Step 3: Create the Docker Compose File

Create a file named `compose.yaml` on your local machine with the following content. Replace the placeholder passwords before saving.

```yaml
version: "3"
services:
  app:
    image: monica:latest
    depends_on:
      - db
    ports:
      - "8080:80"
    environment:
      - APP_KEY=
      - DB_HOST=db
      - DB_DATABASE=monica
      - DB_USERNAME=monica
      - DB_PASSWORD=YOUR_STRONG_PASSWORD
    volumes:
      - /volume1/docker/monica/data:/var/www/monica/storage
    restart: unless-stopped

  db:
    image: mysql:8.0
    environment:
      - MYSQL_ROOT_PASSWORD=YOUR_DIFFERENT_ROOT_PASSWORD
      - MYSQL_DATABASE=monica
      - MYSQL_USER=monica
      - MYSQL_PASSWORD=YOUR_STRONG_PASSWORD
    volumes:
      - /volume1/docker/monica/db:/var/lib/mysql
    restart: unless-stopped
```

**Password rules:**
- `YOUR_STRONG_PASSWORD` must be identical in both the `app` and `db` sections
- `YOUR_DIFFERENT_ROOT_PASSWORD` should be a different password from the above
- Leave `APP_KEY=` blank for now — you will add this after first launch

**Volume path note:** This guide assumes your main volume is `/volume1`. Verify this in DSM **Storage Manager** if you are unsure. If your volume is `/volume2`, update the paths accordingly.

Upload the completed `compose.yaml` to `/volume1/docker/monica/` using File Station.

---

## Step 4: Create the Monica Project in Container Manager

1. Open **Container Manager** from the DSM main menu
2. Click **Project** in the left panel
3. Click **Create**
4. Name the project `monica`
5. Set the path to `/docker/monica`
6. Select **Use existing docker-compose.yml** when prompted
7. Skip the **Web Portal** configuration — click Next without enabling it
8. Review the summary and confirm

Container Manager will pull the Monica and MySQL images and start both containers. **The first launch takes 10–20 minutes** while the database initialises. Do not restart the containers during this time even if they appear to be hanging.

---

## Step 5: Generate the APP_KEY

Monica requires an application encryption key. Generate one and add it to your compose file.

**Generate the key** using Python on any machine:

```bash
python3 -c "import base64, os; print('base64:' + base64.b64encode(os.urandom(32)).decode())"
```

This outputs a string like: `base64:abc123...`

**Add the key to your compose file:**

1. In Container Manager, go to your `monica` project
2. Edit the compose file
3. Find `APP_KEY=` and update it to `APP_KEY=base64:your-generated-key`
4. Save and restart the project

---

## Step 6: Create Your Account

Once both containers show green/running status in Container Manager, open a browser and go to:

```
http://[your-NAS-IP]:8080
```

You will see Monica's welcome screen. Create your account — name, email (does not need to be real for a private instance), and password.

---

## Accessing Monica

| Location | How to Access |
|----------|---------------|
| Desktop or laptop on home network | `http://[NAS-IP]:8080` directly in browser |
| Laptop away from home | Connect WireGuard VPN first, then use same address |

---

## Backup

Monica's data lives in two folders on your NAS:

- `/volume1/docker/monica/db` — MySQL database (contacts, interactions, reminders, notes)
- `/volume1/docker/monica/data` — uploaded files and application storage

**Back up both folders using Synology Hyper Backup.** Configure a daily backup job with at least 30 days retention. Back up while the containers are running — Hyper Backup handles live folder backups correctly.

Test your restore process before you have significant data in Monica.

---

## Troubleshooting

**`Bind mount failed` error on first launch**
The folder path in your compose file does not match the actual folder on your NAS. Verify your volume number in Storage Manager and check for typos in folder names.

**MySQL container stops unexpectedly with `unusable data directory` error**
MySQL failed partway through initialisation and left partial files. Stop the project, delete all files inside `docker/monica/db` (not the folder itself), and restart. Also verify that the `db` folder has Read & Write permissions for Everyone (see Step 2).

**`No application encryption key has been specified` error**
The `APP_KEY` was not added to the compose file. Follow Step 5 to generate and add it, then restart the project.

**Container Manager terminal opens but does not accept input**
This is a known Synology quirk. Use the Python command in Step 5 on your local machine to generate the APP_KEY instead.

**`Permission denied (publickey)` when trying to SSH**
SSH on this NAS is configured for public key authentication only. Either enable password authentication in **Control Panel → Terminal & SNMP → Advanced Settings**, or work around SSH using File Station and Container Manager's GUI as described in this guide. Note that SSH on this NAS runs on port 2222, not the default port 22.

---

## Notes

- Monica does not support employment history as a structured field. Record former organisations in the contact's Notes field using the format `Former: Organisation Name (YYYY–YYYY)`.
- All contacts are tied to your account. Use Monica's relationship linking feature to connect contacts to each other.
- WebDAV sync for cross-device access is not configured in this installation. This can be added later without disrupting the existing setup.

---

*Last updated: February 2026*
