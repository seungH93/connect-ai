# Shared Codex Instructions

Use these instructions whenever working in this workspace. They are intended to travel with the repository so school and home Codex sessions behave consistently.

## Default Collaboration Style

- Reply in Korean by default unless the user asks for another language.
- Keep explanations practical and concise, but preserve enough context for future sessions to resume work.
- Treat this workspace as a long-running personal knowledge and project hub, not as a single-purpose app repository.
- Before changing files, inspect nearby conventions and preserve the user's existing organization.
- Never delete, rename, or mass-move personal notes, research files, PDFs, spreadsheets, or generated assets unless the user explicitly asks.

## Workspace Map

- `0.Seungs/`: personal operating context and high-level notes.
- `00_Raw/`: raw captures and unsorted source material.
- `1.ALKBH5_translation_coupled/`: research/project area for ALKBH5 translation-related work.
- `2.bookcahapter/`: book chapter work, references, and manuscript-related material.
- `3.trading/`: trading-related notes, experiments, and tools.
- `assets/`: reusable prompts, UI assets, agent assets, and local resources.
- `scripts/`: automation scripts.
- `src/`: source code for this workspace's extension/app code.
- `_company/`: local agent/company-style operating system, sessions, shared state, and specialized agents.
- `Codex_storage/`: Codex-related storage and handoff material.
- `.codex/`: project-local Codex configuration and shared skill source.

## Working Rules

- Prefer Git for code synchronization and this repository's `.codex/` files for Codex behavior synchronization.
- Keep secrets, API keys, access tokens, and account-specific auth outside the repository.
- Do not copy `auth.json`, local sqlite state, logs, or machine-specific Codex session files between computers.
- When adding durable instructions, prefer `AGENTS.md` for always-on project rules and `.codex/skills/` for reusable task workflows.
- If a task touches a specific project folder, add any lasting project-specific guidance close to that folder only when it is clearly useful.
- Use `rg` or `rg --files` for search when available.
- Use `apply_patch` for manual edits.

## Verification

- For code changes, run the narrowest relevant build/test/check command available.
- If tooling is unavailable on this machine, state that clearly and explain what was verified instead.
- For document, data, or research edits, verify by re-reading the changed files and checking names/paths.

## Handoff Between Computers

- Commit and push shared source files, prompts, docs, `AGENTS.md`, and `.codex/` project files.
- On another computer, pull the repository and run `scripts/install-codex-shared.ps1` if local Codex should auto-discover the shared skill.
- Keep machine-local Codex sessions as local history only; use commit messages, notes, or docs for durable cross-device memory.
