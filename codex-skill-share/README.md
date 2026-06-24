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

Install from this already-cloned folder:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

Install on another Windows computer without cloning the whole repo:

```powershell
git clone --filter=blob:none --sparse https://github.com/seungH93/connect-ai.git codex-shared
cd codex-shared
git sparse-checkout set codex-skill-share
powershell -ExecutionPolicy Bypass -File .\codex-skill-share\install.ps1
```

Then restart Codex.

Skipped full `.codex` sync; add it only if you want to debug broken machines for sport.
