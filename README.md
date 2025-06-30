# DNS Switcher

This repository contains a small script for switching the DNS servers used by `systemd-resolved`.

## Modes

- **cloudflare** – sets DNS servers to `1.1.1.1` and `1.0.0.1`.
- **google** – sets DNS servers to `8.8.8.8` and `8.8.4.4`.
- **default** – removes custom DNS entries and reverts to the system default.

## Usage

```bash
sudo ./dns-switcher.sh cloudflare
sudo ./dns-switcher.sh google
sudo ./dns-switcher.sh default
```

The script edits `/etc/systemd/resolved.conf` and restarts `systemd-resolved`,
so it must be run with root privileges.
