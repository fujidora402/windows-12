# Customize Windows 11 install.wim with Noah branding
# Run as Administrator

param(
    [string]$WimPath = "C:\Win11_Extract\sources\install.wim",
    [string]$MountPath = "C:\WinMount"
)

Write-Host "Mounting install.wim..."

# Mount WIM
dism /Mount-Wim /WimFile:$WimPath /Index:1 /MountDir:$MountPath

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to mount WIM"
    exit 1
}

Write-Host "install.wim mounted at: $MountPath"

# Add Noah branding customizations here
Write-Host "Adding Noah branding..."

# Example: Replace wallpaper
if (Test-Path ".\BRANDING\wallpaper.png") {
    Copy-Item ".\BRANDING\wallpaper.png" "$MountPath\Windows\Web\Wallpaper\Windows\img0.jpg" -Force
    Write-Host "Wallpaper updated"
}

Write-Host "Committing changes..."

# Commit changes
dism /Unmount-Wim /MountDir:$MountPath /Commit

if ($LASTEXITCODE -eq 0) {
    Write-Host "Customization complete!"
} else {
    Write-Error "Failed to commit changes"
    exit 1
}
