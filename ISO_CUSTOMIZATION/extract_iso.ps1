# Extract Windows 11 ISO for customization
# Run as Administrator

param(
    [string]$ISOPath = "C:\Win11_English_x64v1.iso",
    [string]$ExtractPath = "C:\Win11_Extract"
)

# Create extraction directory
if (!(Test-Path $ExtractPath)) {
    New-Item -ItemType Directory -Path $ExtractPath -Force
}

# Mount ISO
$MountResult = Mount-DiskImage -ImagePath $ISOPath -PassThru
$MountedDrive = ($MountResult | Get-Volume).DriveLetter

Write-Host "ISO mounted at drive: $MountedDrive`:"

# Copy files
Copy-Item -Path "$($MountedDrive):\*" -Destination $ExtractPath -Recurse -Force

Write-Host "ISO extracted to: $ExtractPath"

# Unmount ISO
Dismount-DiskImage -ImagePath $ISOPath

Write-Host "ISO extraction complete!"
