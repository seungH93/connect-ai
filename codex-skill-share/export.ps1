param(
  [string]$CodexHome = "$env:USERPROFILE\.codex"
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillsSource = Join-Path $CodexHome "skills"
$SkillsDest = Join-Path $Root "skills"

New-Item -ItemType Directory -Force -Path $SkillsDest | Out-Null

Get-ChildItem -LiteralPath $SkillsSource -Directory |
  Where-Object { $_.Name -ne ".system" } |
  ForEach-Object {
    Copy-Item -LiteralPath $_.FullName -Destination (Join-Path $SkillsDest $_.Name) -Recurse -Force
  }

Write-Host "Exported personal Codex skills to $SkillsDest"
