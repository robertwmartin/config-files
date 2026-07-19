# Setting up age encryption

## Generating an age key
```
sudo apt install age  # or grab the binary from the FiloSottile/age releases
age-keygen -o ~/.age/card-identity.txt
```

That file contains both the private key (AGE-SECRET-KEY-1...) and a comment line with the public key (age1...). Keep the private key file itself off any synced folder in plaintext — since it's a dedicated low-stakes key, encrypting it with a passphrase-protected symmetric wrapper is enough:

```
age -p -o card-identity.txt.age ~/.age/card-identity.txt
shred -u ~/.age/card-identity.txt   # remove the plaintext copy
```

## Backup and recovery
Since this key's whole purpose is public verification, losing the private key is annoying but not catastrophic (you'd just rotate and reissue cards eventually). Still, back up the encrypted file in two places — a password manager attachment and one offline copy (USB drive in a drawer) — so a single failed disk doesn't force an unplanned key rotation.

Last updated: 09Jul2026

