# Alert Rule: New Service Installed

Monitors for new Windows service installations on the endpoint—a classic technique used by attackers for lateral movement, privilege escalation, or establishing persistence (e.g., PsExec execution).

---

## Detection Details

- **Event Source:** Windows System Log (`win11-target`)
- **Target Event Code:** `7045` (A service was installed in the system)

### SPL Search Query
```spl
index=main host=win11-target EventCode=7045