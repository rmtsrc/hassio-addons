# hassio-wifi-bridge
Use your Home Assistant device as an ethernet to Wi-Fi bridge

### This Hass.io Addon

This add-on allows you to use your Home Assistant device as a Wi-Fi ethernet bridge allowing you to share your Home Assistants Wi-Fi to devices that don't have Wi-Fi built in.

## Installation

To use this repository with your own Home Assistant installation follow [the official guide to installing third party addons](https://www.home-assistant.io/hassio/installing_third_party_addons/) or click the button below:

[![Add Repository to HA](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Frmtsrc%2Fhassio-addons)

1. Enable and setup [Home Assistant Developer access](https://developers.home-assistant.io/docs/operating-system/debugging/) or use the [HassOS SSH port 22222 Configurator Add-on](https://community.home-assistant.io/t/add-on-hassos-ssh-port-22222-configurator/264109/1)
2. Add this repo to the Home Assistant Add-on Store and install
3. Add your HA Dev SSH private key to the configuration page, making sure to use `|` in the raw YAML editor to allow new lines (like the config below)
4. Click start
5. Connect the device with an ethernet cable
6. On the device which requires network access set a static IP address of `192.168.3.2` and gateway/DNS to `192.168.3.1`
7. Enable "Start on boot" to allow network access on boot

### Configuration

The available configuration options are as follows:

```yaml
sshDevPrivateKey: |
  -----BEGIN OPENSSH PRIVATE KEY-----
  Your Home Assistant
  Developer SSH private key
  Here
  -----END OPENSSH PRIVATE KEY-----
wifiAdaptor: wlan0
ethernetAdaptor: eth0
address: 192.168.3.1
netmask: 255.255.255.0
broadcast: 192.168.3.254
```

## License

ISC License

Copyright 2023 rmt/src

Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
