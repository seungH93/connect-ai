# Codex Skill Share

Share this folder between computers with Git, OneDrive, Dropbox, or a zip.

What this includes:
- `skills/`: personal Codex skills from this computer
- `config/codex-plugins.toml`: safe plugin config snippet for ponytail
- `install.ps1`: copies the skills and adds ponytail plugin config

What this intentionally excludes:
- `auth.json`
- sessions, logs, memories, sqlite state
- runtime paths and machine-specific MCP settings
- plugin cache folders

Install on another Windows computer:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

Then restart Codex.

Skipped full `.codex` sync; add it only if you want to debug broken machines for sport.
