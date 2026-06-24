# Workspace Map

Use this reference when deciding where new files, notes, prompts, or instructions belong.

## Top-Level Areas

- `0.Seungs/`: personal operating context, plans, and high-level notes.
- `00_Raw/`: unprocessed captures, imports, rough material, and inbox-style files.
- `1.ALKBH5_translation_coupled/`: ALKBH5 translation-coupled research work.
- `2.bookcahapter/`: book chapter work, manuscript references, and publishing material.
- `3.trading/`: trading-related notes, experiments, tools, and references.
- `assets/`: reusable assets, prompt packs, agent images, UI files, and local resources.
- `Codex_storage/`: Codex handoff/storage area when the user explicitly wants Codex-specific persistence.
- `ETC/`: miscellaneous files that do not yet deserve a project folder.
- `scripts/`: reusable local automation.
- `src/`: extension/app source code.
- `_company/`: local multi-agent/company-style operating structure, sessions, shared state, and agent definitions.
- `사적인사용/`: private-use resources and personal reference material.

## Durable Codex Context

- Root `AGENTS.md`: always-on instructions for this repository.
- `.codex/config.toml`: project-local Codex configuration.
- `.codex/skills/`: repository-tracked skill source.
- `scripts/install-codex-shared.ps1`: helper for installing repository skills into the local Codex skill directory.

## Placement Rules

- If the user names a folder, use it.
- If the file is raw or unsorted, use `00_Raw/`.
- If the file is an automation script, use `scripts/`.
- If the file is a reusable prompt, use `assets/prompts/`.
- If the file is Codex behavior, use `AGENTS.md` or `.codex/`.
- If the file is sensitive, account-specific, or a local token/session/cache, do not put it in the repository.
