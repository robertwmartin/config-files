Install OS through normal process. Current version is Ubuntu 26.04.4.

Run curl to download and run the bootstrapper
`curl -fO https://raw.githubusercontent.com/robertwmartin/config-files/main/bootstrap.sh`

---

## Changes to make
- Remove install for Vim as I don't use that
- Change references to Ubuntu 24.04 in bootstrap.sh
- Clean up the Brave section. Do I really need the keys?
    - curl -fsS https://dl.brave.com/install.sh | sh
- kitty install doesn't set the color scheme or prompt



