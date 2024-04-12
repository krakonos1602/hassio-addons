# Home Assistant Add-on: Mealie

Add-on is still under development!

Uses custom built docker image. Supports Home Assistant Ingress.

Config options:
- BASE_URL (required) - Base url for generating links etc. See Mealie documentation for further information. Usable especially, when remote access is configured. Nothing bad happens if you put some placeholder there when you only use Home Assistant's Ingress access.
- ALLOW_SIGNUP - Allow new users to create their profiles. Defaults to false.
- SMTP_* - E-mail sending options. See the Mealie docs. Please note, that my Home Assistant setup ends up crashing, when I try to send a testing e-mail. This needs to be further looked into and solved.
- Port Forwarding - Expose Mealie on a specific port of the Home Assistant host. Defaults to 9091.

The base docker image is derived from the official @mealie-recipes/mealie Dockerfile. The add-on saves data into /homeassistant/addons_config/mealie_data. This is inspired by @alexbelgium/hassio-addons. Ingress is enabled in a similar way as @tux2000/home-assistant-addons/ingress-proxy has done.

![Supports aarch64 Architecture][aarch64-shield]
<!---![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]-->

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
<!---[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg-->

Further system architectures are to be added.
