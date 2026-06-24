param(
  [string]$CodexHome = "$env:USERPROFILE\.codex"
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillsSource = Join-Path $CodexHome "skills"

& (Join-Path $Root "merge-skills.ps1") -Source $SkillsSource -Name $env:COMPUTERNAME
