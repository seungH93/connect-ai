param(
  [string]$CodexHome = "$env:USERPROFILE\.codex"
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillsSource = Join-Path $Root "skills"
$SkillsDest = Join-Path $CodexHome "skills"
$ConfigPath = Join-Path $CodexHome "config.toml"

New-Item -ItemType Directory -Force -Path $SkillsDest | Out-Null

if (Test-Path $SkillsSource) {
  Get-ChildItem -LiteralPath $SkillsSource -Directory | ForEach-Object {
    Copy-Item -LiteralPath $_.FullName -Destination (Join-Path $SkillsDest $_.Name) -Recurse -Force
  }
}

New-Item -ItemType Directory -Force -Path $CodexHome | Out-Null
if (!(Test-Path $ConfigPath)) {
  New-Item -ItemType File -Path $ConfigPath | Out-Null
}

$Config = Get-Content -LiteralPath $ConfigPath -Raw
$NeedsBackup = $false
$Append = @()

if ($Config -notmatch '(?m)^\[marketplaces\.ponytail\]$') {
  $Append += @'

[marketplaces.ponytail]
source_type = "git"
source = "https://github.com/DietrichGebert/ponytail.git"
'@
  $NeedsBackup = $true
}

if ($Config -notmatch '(?m)^\[plugins\."ponytail@ponytail"\]$') {
  $Append += @'

[plugins."ponytail@ponytail"]
enabled = true
'@
  $NeedsBackup = $true
}

if ($Append.Count) {
  if ($NeedsBackup) {
    Copy-Item -LiteralPath $ConfigPath -Destination "$ConfigPath.bak" -Force
  }
  Add-Content -LiteralPath $ConfigPath -Value ($Append -join "")
}

Write-Host "Installed Codex skills from $SkillsSource"
Write-Host "Ponytail plugin config is present. Restart Codex."
