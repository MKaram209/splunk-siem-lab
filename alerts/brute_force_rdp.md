# Alert Rule: Brute-Force RDP Login Detected

Catches repeated failed RDP logon attempts against the monitored Windows endpoint, pointing to an active brute-force or password-spraying attempt.

---

## Detection Details

- **Event Source:** Windows Security Log (`win11-target`)
- **Target Event Code:** `4625` (An account failed to log on)

### SPL Search Query
```spl
index=main host=win11-target EventCode=4625
| stats count by Account_Name
| where count > 3