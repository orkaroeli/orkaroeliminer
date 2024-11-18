# Download the file
Invoke-WebRequest -Uri "https://example.com/file.zip" -OutFile "file.zip"

# Unzip the file
Expand-Archive -Path "file.zip" -DestinationPath "./unzipped" -Force

# Change directory
Set-Location -Path "./unzipped"

# Execute the file
Start-Process -FilePath ".\yourfile.exe"
