param(
  [string]$RepoRoot = (Resolve-Path "$PSScriptRoot\..").Path,
  [string]$CodexHome = $(if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $env:USERPROFILE ".codex" })
)

$ErrorActionPreference = "Stop"

$sourceSkills = Join-Path $RepoRoot ".codex\skills"
$targetSkills = Join-Path $CodexHome "skills"

if (!(Test-Path $sourceSkills)) {
  throw "No shared skills found at $sourceSkills"
}

New-Item -ItemType Directory -Force -Path $targetSkills | Out-Null

Get-ChildItem -Path $sourceSkills -Directory | ForEach-Object {
  $target = Join-Path $targetSkills $_.Name
  if (Test-Path $target) {
    Remove-Item -Recurse -Force -LiteralPath $target
  }
  Copy-Item -Recurse -Force -LiteralPath $_.FullName -Destination $target
  Write-Host "Installed skill:" $_.Name "->" $target
}

Write-Host "Done. Restart Codex if it was already running."
