param(
  [string]$Source = "$env:USERPROFILE\.codex\skills",
  [string]$Name = $env:COMPUTERNAME
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Dest = Join-Path $Root "skills"
$ConflictRoot = Join-Path $Root "conflicts"

if (Test-Path -LiteralPath (Join-Path $Source "skills")) {
  $Source = Join-Path $Source "skills"
}

if (!(Test-Path -LiteralPath $Source)) {
  throw "Missing source skills folder: $Source"
}

New-Item -ItemType Directory -Force -Path $Dest | Out-Null

$copied = 0
$skipped = 0
$conflicted = 0

Get-ChildItem -LiteralPath $Source -Recurse -File |
  Where-Object { $_.FullName -notmatch '\\\.system(\\|$)' } |
  ForEach-Object {
    $relative = $_.FullName.Substring($Source.TrimEnd('\').Length + 1)
    $target = Join-Path $Dest $relative

    if (!(Test-Path -LiteralPath $target)) {
      New-Item -ItemType Directory -Force -Path (Split-Path -Parent $target) | Out-Null
      Copy-Item -LiteralPath $_.FullName -Destination $target
      $script:copied++
      return
    }

    $sourceHash = (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash
    $targetHash = (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash

    if ($sourceHash -eq $targetHash) {
      $script:skipped++
      return
    }

    $conflict = Join-Path (Join-Path $ConflictRoot $Name) $relative
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $conflict) | Out-Null
    Copy-Item -LiteralPath $_.FullName -Destination $conflict -Force
    $script:conflicted++
  }

Write-Host "Merged skills from $Source"
Write-Host "Copied: $copied; identical skipped: $skipped; conflicts saved: $conflicted"
