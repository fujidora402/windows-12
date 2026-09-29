# Rebuild customized ISO into Noah.iso
# Run as Administrator

param(
    [string]$SourcePath = "C:\Win11_Extract",
    [string]$OutputISO = "C:\Noah.iso"
)

# Verify oscdimg is available
$oscdimg = "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg.exe"

if (!(Test-Path $oscdimg)) {
    Write-Error "oscdimg not found. Install Windows Assessment and Deployment Kit (ADK)."
    exit 1
}

Write-Host "Building ISO from: $SourcePath"
Write-Host "Output: $OutputISO"

# Build ISO
& $oscdimg -m -o -u2 -udfver102 $SourcePath $OutputISO

if ($LASTEXITCODE -eq 0) {
    Write-Host "ISO built successfully: $OutputISO"
} else {
    Write-Error "ISO build failed with exit code: $LASTEXITCODE"
}
