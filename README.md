# SIEM Configuration & Alerting

A home-lab SIEM project built with Splunk Enterprise: log ingestion from a monitored Windows endpoint, a use-case dashboard, real-time alerts, and a Discord webhook integration for notifications.

## Overview

This project simulates a small monitored environment and shows the full SIEM workflow: collect logs, detect suspicious activity, visualize it, and alert on it.

**Lab setup (VMware, NAT network):**

| Role | OS | IP |
|---|---|---|
| SIEM server | Ubuntu 64-bit | 192.168.110.130 |
| Monitored endpoint | Windows 11 x64 (win11-target) | 192.168.110.129 |
| Attacker | Kali Linux 2026.2 | (NAT, no static IP noted) |

Splunk Enterprise runs on the Ubuntu VM. A Splunk Universal Forwarder on the Windows VM ships Security/System/Application event logs to the Splunk server on port 9997.

## What's in this repo

- `docs/setup.md` — full setup walkthrough: Splunk install, forwarder config, troubleshooting, use case generation
- `alerts/` — the three alert rules (search, trigger logic, what each one detects) plus the Discord webhook script
- `demo/` — link to the demo video walking through the whole setup and a live alert firing

## Use cases covered

1. **Brute-force RDP login**  EventCode 4625 (failed logon) followed by 4624 (successful logon), generated with Hydra against an exposed RDP service
2. **New user account created**  EventCode 4720, generated with `net user /add`
3. **New service installed**  EventCode 7045, generated via Metasploit's `psexec` module

Each use case has a dashboard panel and a corresponding real-time alert. See `alerts/` for details.

## Alerting

All three alerts are real-time, trigger when results > 0 within a 1-minute window, and are throttled for 60 seconds to avoid re-trigger spam. The brute-force alert also posts to a Discord channel via a custom webhook script (see `alerts/discord_alert.sh`) - Splunk's built-in webhook action doesn't format the JSON the way Discord expects, so a "Run a script" action handles the POST manually.

## Demo

[![Watch the demo](https://img.youtube.com/vi/U5rvZKiQOuI/maxresdefault.jpg)](https://youtu.be/U5rvZKiQOuI)

Click the thumbnail to watch the full walkthrough: the setup, all three use cases being triggered, and the alerts firing (including the Discord notification).
