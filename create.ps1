Param(
    [string]$path
)

$files = @(
    "out",
    "boilerplate-local.html"
)

function Error([string]$msg) {
    Write-Error $msg
    exit 1
}

function PerformCopy([string]$file, [string]$dst) {
    $srcPath = Join-Path -Path $PSScriptRoot -ChildPath $file
    $dstPath = Join-Path -Path $dst -ChildPath $file
    if (-Not (Test-Path $dstPath)) {
        Copy-Item $srcPath $dstPath -Recurse >$null 2>&1
    } else {
        Error "Already existing: $dstPath"
    }
}

if ($MyInvocation.BoundParameters.Keys -match 'path') {
    $destPath = $path
} else {
    $destPath = Read-Host -Prompt "Give destination path"
}

if ((Test-Path $destPath) -And -Not (Test-Path $destPath -PathType Container)) {
    Error "Given path does not lead to a directory"
}

foreach ($file in $files) {
    PerformCopy $file $destPath
}
