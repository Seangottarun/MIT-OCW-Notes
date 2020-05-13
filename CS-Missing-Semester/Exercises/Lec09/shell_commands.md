# Shell Commands used for Exercise 9


## Entropy
1. Suppose a password is chosen as a concatenation of five lower-case dictionary words, where each word is selected uniformly at random from a dictionary of size 100,000. An example of such a password is `correcthorsebatterystaple`. How many bits of entropy does this have?

```
# possiblities = 100000^5 (assuming repetition allowed)
Entropy = log_2(# possibilities) = 66 bits
```

```bash
$ bc -l
l(10000^5)/l(2) = 66.43856189774724695808
```

2. Consider an alternative scheme where a password is chosen as a sequence of 8 random alphanumeric characters (including both lower-case and upper-case letters). An example is `rg8Ql34g`. How many bits of entropy does this have?

```
26 upper + 26 lower + 10 numbers = 62 characters
# possibilities= 62^8 (assuming repetition)
Entropy = log_2(# possibilities) = 47 bits
```

```bash
$ bc -l
l(62^8)/l(2) = 47.63357048309500167094
```

3. Which is the stronger password?

```bash
# The 5 lower case words is a stronger password because it has 66 bits of entropy compared to 47 bits
```

4. Suppose an attacker can try guessing 10,000 passwords per second. On average, how long will it take to break each of the passwords?

```
time = possibilities/rate = 100 000^5 / 10 000= 10^21 seconds
```

```bash
$ bc -l
100000^5 / 10000 = 1000000000000000000000.00000000000000000000
```

```
time = possibilities/rate = 62^8 / 10 000= 2.1 * 10^10 seconds
```
```bash
$ bc -l
62^8 / 10000 = 21834010558.4896
```

## Cryptographic hash functions
1. Download a Debian image from a mirror (e.g. this file from an Argentinean mirror). Cross-check the hash (e.g. using the `sha256sum` command) with the hash retrieved from the official Debian site (e.g. this file hosted at `debian.org`, if you’ve downloaded the linked file from the Argentinean mirror).

```bash
sha256sum file.iso
```

## Symmetric cryptography
1. Encrypt a file with AES encryption, using OpenSSL: `openssl aes-256-cbc -salt -in {input filename} -out {output filename}`. Look at the contents using `cat` or `hexdump`. Decrypt it with `openssl aes-256-cbc -d -in {input filename} -out {output filename}` and confirm that the contents match the original using `cmp`.

```bash
openssl aes-256-cbc -salt -in shell_commands.md -out shell_commands.enc.md
cat shell_commands.enc.md

openssl aes-256-cbc -d -in shell_commands.enc.md -out shell_commands.dec.md
cmp shell_commands.dec.md shell_commands.md
```

## Asymmetric cryptography.
1. Set up SSH keys on a computer you have access to (not Athena, because Kerberos interacts weirdly with SSH keys). Rather than using RSA keys as in the linked tutorial, use more secure ED25519 keys. Make sure your private key is encrypted with a passphrase, so it is protected at rest.
2. Set up GPG
3. Send Anish an encrypted email (public key).
4. Sign a Git commit with `git commit -C` or create a signed Git tag with `git tag -s`. Verify the signature on the commit with `git show --show-signature` or on the tag with `git tag -v`.
