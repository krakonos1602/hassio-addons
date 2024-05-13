# Home Assistant Add-on: Valetudo Proxy

Displays your @Hypfer/Valetudo vacuum enabled web interface in Home Assistant's ingress panel.

Config options:
- LOCAL_URL (required) - The url (or ip address) of your Valetudo vacuum in your local network - e.g. "http://192.168.0.50".

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg

Please note, that this add-on only runs generic nginx proxy. You can modify it and use it for any other local http service. Since the panel name and logo are hardcoded in config.yaml file, this is initialy released as proxy for Valetudo.