@echo OFF
pushd %~dp0

start powershell -Command "Start-Process powershell \"-ExecutionPolicy Bypass -NoProfile -Command `\"cd \`\"%cd%\`\"; & \`\".\install_ps.ps1\`\" `\" \" -Verb RunAs"

echo "Offline install completed."

exit