# SIEM Lab & Alerting Pipeline

A home-lab SIEM project built with Splunk Enterprise to practice end-to-end security monitoring—covering log ingestion from a Windows endpoint, custom dashboard panels, real-time alerting, and Discord webhook integration.

## Overview

I put this together to simulate a small, monitored environment and walk through the full SIEM workflow: collecting logs, spotting suspicious activity, visualizing it, and piping out alerts when something trips.

**Lab Setup (VMware, NAT Network):**

| Role | OS | IP |
|---|---|---|
| SIEM server | Ubuntu 64-bit | 192.168.110.130 |
| Monitored endpoint | Windows 11 x64 (`win11-target`) | 192.168.110.129 |
| Attacker | Kali Linux 2026.2 | *(NAT, dynamic)* |

Splunk Enterprise runs on the Ubuntu VM. A Splunk Universal Forwarder on the Windows side ships Security, System, and Application event logs straight to the SIEM on port 9997.

## What's in the Repo

- `docs/setup.md` — Full setup notes: installing Splunk, configuring the forwarder, troubleshooting, and generating test use cases.
- `alerts/` — The three detection alert rules (search logic, thresholds, and what they catch) plus the custom Discord webhook script.
- `demo/` — Walkthrough video showing the whole lab running and a live alert firing.

## Use Cases Covered

1. **RDP Brute-Force** - Event Code `4625` (failed logon) followed quickly by `4624` (successful logon), kicked off using Hydra against the RDP service.
2. **New User Account Creation** - Event Code `4720`, generated locally via `net user /add`.
3. **New Service Installation** - Event Code `7045`, triggered using Metasploit's `psexec` module.

Each scenario feeds a dashboard panel and triggers a real-time alert. Check the `alerts/` directory for the exact SPL queries.

## Alerting & Discord Integration

All three alerts run in real-time, trigger when results are greater than zero over a 1-minute window, and have a 60-second throttle to stop alert spam. 

For the Discord part: Splunk's native webhook action didn't format the payload quite the way Discord's API expects, so I wrote a quick custom shell script (`alerts/discord_alert.sh`) to handle the POST request manually via a "Run a script" action.

## Demo

Head over to `demo/` for a video walkthrough of the setup, the attack simulation, and the live alerts hitting Discord.
