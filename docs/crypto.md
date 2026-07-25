# Crypto setup

There are two aspects for the crypto setup. First, SSH which is used for authentication. Second, NSS which is used for document signing.

## NSS and Document Signing

LibreOffice reads from the NSS database and not `~/.ssh`. NSS is contained in the `libnss3-tools` package.
```bash
sudo apt install libnss3-tools
```

Make sure the LibreOffice cert folder exists, and then create an empty database there. Enter and record the password when prompted.
```bash
mkdir -p ~/snap/libreoffice/374/.config/libreoffice/4/user/certs
# 374 might be incorrect depending on version of LibreOffice installed
certutil -N -d sql:$HOME/snap/libreoffice/374/.config/libreoffice/4/user/certs
```

Generate a self-signed certificate
```bash
certutil -S -k rsa -n "RWM" -s "CN=Robert Martin,O=Energam Inc.,C=CA" -c "RWM" -t "Cu,Cu,Cu" -v 60 -x -d sql:$HOME/snap/libreoffice/374/.config/libreoffice/4/user/certs
```

List the certs in the database
```bash
certutil -L -d sql:$HOME/snap/libreoffice/374/.config/libreoffice/4/user/certs
```

Remember to use the standard crypto password when prompted. 
