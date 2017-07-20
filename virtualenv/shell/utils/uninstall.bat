@echo OFF
pushd %~dp0

start powershell -Command "Start-Process powershell \"-ExecutionPolicy Bypass -NoProfile -Command `\"cd \`\"%cd%\`\"; & \`\".\uninstall ps.ps1\`\" `\" \" -Verb RunAs"
