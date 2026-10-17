# Alert Rule: New User Account Created

Monitors for local user account creations on the target system—critical for spotting unauthorized persistence mechanisms after an initial compromise.

---

## Detection Details

- **Event Source:** Windows Security Log (`win11-target`)
- **Target Event Code:** `4720` (A user account was created)

### SPL Search Query
```spl
index=main host=win11-target EventCode=4720