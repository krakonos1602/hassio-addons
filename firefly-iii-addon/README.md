# Home Assistant Add-on: Firefly III

Add-on is still under development!

Uses custom built docker image. Uses SQLite database. Settings may be added if requested.

Config options:
- APP_KEY (required) - Database encryption key
- SITE_OWNER - Administrator e-mail (only used when displaying some front-end error alerts).

The add-on saves data into /homeassistant/addons_config/fireflyiii. This is inspired by [@alexbelgium/hassio-addons](https://github.com/alexbelgium/hassio-addons).

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
<!---![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]-->

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
<!---[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg-->

Further system architectures may be added if requested.
