# PowerShell script to install prerequisites for JBoss EAP Azure B2C App using Chocolatey

# Function to check if Chocolatey is installed
function Test-Chocolatey {
    return Get-Command choco -ErrorAction SilentlyContinue
}

# Install Chocolatey if not already installed
if (-not (Test-Chocolatey)) {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} else {
    Write-Host "Chocolatey is already installed."
}

# Refresh environment variables
refreshenv

# Install OpenJDK 11
Write-Host "Installing OpenJDK 11..."
choco install openjdk11 -y

# Install Maven
Write-Host "Installing Maven..."
choco install maven -y

# Note about JBoss EAP
Write-Host "JBoss EAP 7.4 needs to be downloaded manually due to licensing requirements."
Write-Host "Please follow these steps:"
Write-Host "1. Go to https://developers.redhat.com/products/eap/download"
Write-Host "2. Log in or create a Red Hat account"
Write-Host "3. Download JBoss EAP 7.4 (ZIP file)"
Write-Host "4. Extract the ZIP file to a location of your choice"

# Prompt user for JBoss EAP installation path
$jbossPath = Read-Host "Enter the full path where you extracted JBoss EAP 7.4"

# Verify JBoss EAP installation
if (Test-Path "$jbossPath\bin\standalone.bat") {
    Write-Host "JBoss EAP 7.4 found at $jbossPath"
} else {
    Write-Host "JBoss EAP 7.4 not found at the specified path. Please make sure you've downloaded and extracted it correctly."
}

Write-Host "Installation of prerequisites completed."
Write-Host "Please restart your PowerShell session for the changes to take effect."