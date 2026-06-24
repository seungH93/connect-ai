---
name: project-workflow
description: Shared workflow for this personal workspace. Use when Codex is working inside this repository, especially for cross-computer handoff, project organization, durable notes, research folders, coding tasks, prompt/agent assets, or deciding where to put new files and instructions.
---

# Project Workflow

## Overview

Use this skill to keep school and home Codex behavior aligned through repository-tracked instructions. Prefer durable, repo-local context over machine-local session memory.

## Quick Start

1. Read the root `AGENTS.md` first.
2. Identify which top-level folder owns the task.
3. Read nearby README, notes, prompts, or config files before editing.
4. Make the smallest durable change that helps future sessions resume.
5. Verify the result and mention any local-only state that cannot sync.

## Where To Put Things

- Put always-on Codex behavior in `AGENTS.md`.
- Put reusable Codex workflows in `.codex/skills/<skill-name>/`.
- Put project-local Codex defaults in `.codex/config.toml`.
- Put general prompt assets in `assets/prompts/`.
- Put automation in `scripts/`.
- Put temporary or unprocessed materials in `00_Raw/` unless the user names a better destination.
- Put project-specific material in the matching numbered folder.

For the current workspace map, read `references/workspace-map.md` when folder ownership is unclear.

## Cross-Computer Handoff

- Use Git commits or explicit markdown notes for durable task state.
- Do not rely on Codex local task lists, logs, sqlite files, or conversation history to sync across computers.
- Do not copy account auth files between machines.
- If a skill should be available globally on a computer, install it from this repo into `~/.codex/skills`.

## Editing Rules

- Preserve Korean filenames and user-created folder names exactly.
- Avoid broad cleanup in OneDrive-synced folders.
- Keep generated instructions concise and easy to scan.
- Prefer plain Markdown for durable notes.
- When unsure whether a file is personal, research, or generated, ask before moving or deleting it.

## Verification

- For code: run the narrowest relevant test, build, lint, or typecheck command available.
- For Codex instruction changes: validate skill structure if possible and re-read the changed files.
- For sync setup: confirm the files exist in the repository and explain what must be copied or pulled on the other computer.
