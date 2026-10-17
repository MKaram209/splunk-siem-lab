# Setup & Implementation Guide

Step-by-step walkthrough for building this home-lab SIEM environment—covering VM provisioning, Splunk Enterprise installation, universal forwarder configuration, attack simulation, and dashboard/alert setup.

---

## Lab Layout

Three virtual machines running in VMware, all bridged to the same NAT network (`VMnet8`, gateway `.2`):

| Role | OS / Platform | IP Address |
|---|---|---|
| **SIEM Server** | Ubuntu 64-bit | `192.168.110.130` |
| **Monitored Endpoint** | Windows 11 x64 (`win11-target`) | `192.168.110.129` |
| **Attacker Box** | Kali Linux 2026.2 | *NAT (dynamic)* |

---

## 1. Installing Splunk Enterprise

Splunk Enterprise was installed on the Ubuntu VM under a dedicated service account rather than root to keep permissions clean.

### Account Structure
- `splunk-siem` - My personal login shell user (`UID 1000`).
- `splunk` - Dedicated service account that Splunk runs under (`UID 1001`, home directory `/opt/splunk`).

Splunk's web UI runs on port `8000`.

### Important Gotchas & Fixes
- **Service Not Starting on Boot:** The first time I rebooted the Ubuntu VM, Splunk didn't come back up automatically. You have to start it explicitly under the service account:
  ```bash
  sudo -u splunk /opt/splunk/bin/splunk start
