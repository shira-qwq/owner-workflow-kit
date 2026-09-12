[CmdletBinding()]
param(
    [string]$Destination = (Join-Path $env:USERPROFILE '.agents\skills'),
    [switch]$SkipDependencies
)
$ErrorActionPreference = 'Stop'
$kitRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$skillRoot = [IO.Path]::GetFullPath($Destination)
$skillNames = @('owner-plain-language-zh', 'owner-project-control')

function Assert-Contained([string]$Path, [string]$Root) {
    $absolute = [IO.Path]::GetFullPath($Path)
    $prefix = [IO.Path]::GetFullPath($Root).TrimEnd('\','/') + [IO.Path]::DirectorySeparatorChar
    if (-not $absolute.StartsWith($prefix, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Path escapes intended directory: $absolute"
    }
}
function Assert-NoLinks([string]$Path) {
    $current = [IO.Path]::GetFullPath($Path)
    while ($current) {
        if (Test-Path -LiteralPath $current) {
            if ((Get-Item -Force -LiteralPath $current).Attributes -band [IO.FileAttributes]::ReparsePoint) {
                throw "Refusing linked installation path: $current"
            }
        }
        $parent = Split-Path -Parent $current
        if ($parent -eq $current) { break }
        $current = $parent
    }
    if (Test-Path -LiteralPath $Path) {
        if (Get-ChildItem -LiteralPath $Path -Recurse -Force | Where-Object { $_.Attributes -band [IO.FileAttributes]::ReparsePoint }) {
            throw "Refusing directory containing links: $Path"
        }
    }
}
function Fingerprint([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path)) { return '' }
    $entries = @(Get-ChildItem -LiteralPath $Path -File -Recurse -Force | ForEach-Object {
        $_.FullName.Substring($Path.TrimEnd('\','/').Length) + ':' + ([BitConverter]::ToString([Security.Cryptography.SHA256]::Create().ComputeHash([IO.File]::ReadAllBytes($_.FullName))))
    } | Sort-Object)
    return ($entries -join "`n")
}

try {
    Assert-NoLinks $skillRoot
    foreach ($name in $skillNames) {
        $source = Join-Path $kitRoot $name
        if (-not (Test-Path -LiteralPath (Join-Path $source 'SKILL.md'))) { throw "Incomplete package: $name" }
        Assert-NoLinks $source
        Assert-NoLinks (Join-Path $skillRoot $name)
        if ([IO.Path]::GetFullPath($source) -eq [IO.Path]::GetFullPath((Join-Path $skillRoot $name))) {
            throw 'Source and installation destination are the same.'
        }
    }
    New-Item -ItemType Directory -Path $skillRoot -Force | Out-Null
    $backupRoot = Join-Path (Split-Path -Parent $skillRoot) ('.owner-workflow-backup-' + [DateTime]::Now.ToString('yyyyMMdd-HHmmss') + '-' + [Guid]::NewGuid().ToString('N').Substring(0,8))
    Assert-NoLinks $backupRoot
    foreach ($name in $skillNames) {
        $source = Join-Path $kitRoot $name
        $target = Join-Path $skillRoot $name
        if ((Fingerprint $source) -eq (Fingerprint $target)) { Write-Host "Already current: $name"; continue }
        $stage = Join-Path $skillRoot ('.owner-workflow-stage-' + [Guid]::NewGuid().ToString('N'))
        Assert-Contained $stage $skillRoot
        Copy-Item -LiteralPath $source -Destination $stage -Recurse
        if ((Fingerprint $source) -ne (Fingerprint $stage)) { throw "Copy verification failed: $name" }
        $backup = Join-Path $backupRoot $name
        if (Test-Path -LiteralPath $target) {
            New-Item -ItemType Directory -Path $backupRoot -Force | Out-Null
            Assert-Contained $target $skillRoot
            Assert-Contained $backup $backupRoot
            Move-Item -LiteralPath $target -Destination $backup
            Write-Host "Previous version backed up: $backup"
        }
        try { Move-Item -LiteralPath $stage -Destination $target }
        catch {
            if ((Test-Path -LiteralPath $backup) -and -not (Test-Path -LiteralPath $target)) {
                Assert-Contained $backup $backupRoot
                Assert-Contained $target $skillRoot
                Move-Item -LiteralPath $backup -Destination $target
            }
            throw
        }
        Write-Host "Installed: $name"
    }
    if (-not $SkipDependencies) {
        $backlogCommand = Get-Command backlog -ErrorAction SilentlyContinue
        if ($backlogCommand) { & $backlogCommand --version; if ($LASTEXITCODE -ne 0) { throw 'Backlog exists but failed its version check.' } }
        else {
            $npmCommand = Get-Command npm.cmd -ErrorAction SilentlyContinue
            if (-not $npmCommand) { throw 'Skills installed. Node.js/npm is missing; ask your agent to install the official Node.js runtime, then rerun.' }
            & $npmCommand install --global backlog.md@1.51.0
            if ($LASTEXITCODE -ne 0) { throw 'Skills installed, but Backlog installation failed.' }
            $backlogCommand = Get-Command backlog -ErrorAction SilentlyContinue
            if (-not $backlogCommand) { throw 'Backlog installed but is not on PATH. Open a new terminal and verify it.' }
            & $backlogCommand --version
            if ($LASTEXITCODE -ne 0) { throw 'Backlog verification failed.' }
        }
    }
    Write-Host "Skills ready in: $skillRoot"
    Write-Host 'Start a new agent turn and confirm skill discovery. Prompts are in the prompts folder.'
    if ($SkipDependencies) { Write-Host 'Dependency checks skipped by request.' }
    exit 0
} catch { Write-Error $_; exit 1 }
