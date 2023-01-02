# hassio-temper-humidity-sensor
Query a TEMPer sensor to fetch its current humidity

### This Hass.io Addon

This add-on allows you to query a TEMPer sensor to fetch its current humidity.

## Installation

To use this repository with your own Home Assistant installation follow [the official guide to installing third party addons](https://www.home-assistant.io/hassio/installing_third_party_addons/) or click the button below:

[![Add Repository to HA](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Frmtsrc%2Fhassio-addons)

1. Add this repo to the Home Assistant Add-on Store and install
2. Create a new sensor in your configuration.yaml (see below)
3. Set the webhook IDs to match up
4. Disable this plugins "Protection mode" to allow sensor access
5. Click start then check if the sensor has been updated in the entities list

### Configuration

Add the following to your `configuration.yaml` and update the webhook_ids to match up.

```yaml
template:
  - trigger:
      - platform: webhook
        webhook_id: living-room-humidity-webhook-id-CHANGE-ME
    sensor:
      - name: "Living room humidity"
        state: "{{ trigger.json.humidity }}"
        unit_of_measurement: "%"
```

The available configuration options are as follows:

```yaml
webHookId: living-room-humidity-webhook-id-CHANGE-ME
```

### Optional Automation

Optionally create a new automation to fetch and set the humidity every 15 minutes:

1. Navigate to Settings > Automations > Create new (blank)
2. Trigger: Time Pattern: `/15` minutes
3. Action: Call service: Home Assistant Supervisor: Start add-on and select: TEMPer Humidity Sensor

## License

ISC License

Copyright 2023 rmt/src

Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
