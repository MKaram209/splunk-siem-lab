# Script: discord_alert.sh

Custom bash script used to bridge Splunk alerts to a Discord webhook channel.

---

## Why This Script Exists

Splunk's built-in "Webhook" alert action doesn't format the JSON payload in the structure that Discord's API expects (`{"content": "..."}`), causing payloads to fail silently with error code `2`. 

Instead of relying on the native webhook action, we configure Splunk to **"Run a script"** and pass the alert title through this bash script to handle the manual `POST` request.

---

## Script Source

```bash
#!/bin/bash
#
# discord_alert.sh
#
# Posts a Splunk alert notification to a Discord channel via webhook.
#
# Why this script exists:
# Splunk's built-in "Webhook" alert action doesn't send the JSON body
# in the format Discord expects ({"content": "..."}), so it fails
# silently (error code 2). This script is called instead via Splunk's
# "Run a script" alert action, and does the POST to Discord manually.
#
# Setup in Splunk:
#   Alert action: Run a script
#   Script: discord_alert.sh (placed in $SPLUNK_HOME/bin/scripts/)
#
# Note on --cacert:
# Splunk's script execution environment doesn't resolve the system CA
# bundle the way an interactive shell does. Without --cacert pointing
# at the system bundle explicitly, curl fails with exit code 77
# (SSL certificate verification failure). Adding --cacert fixes it.

WEBHOOK_URL="[https://discord.com/api/webhooks/YOUR_WEBHOOK_ID/YOUR_WEBHOOK_TOKEN](https://discord.com/api/webhooks/YOUR_WEBHOOK_ID/YOUR_WEBHOOK_TOKEN)"

MESSAGE="**SIEM Alert Triggered**\nAlert: $1\nTime: $(date)"

curl -sS --cacert /etc/ssl/certs/ca-certificates.crt \
  -H "Content-Type: application/json" \
  -X POST \
  -d "{\"content\": \"${MESSAGE}\"}" \
  "$WEBHOOK_URL"