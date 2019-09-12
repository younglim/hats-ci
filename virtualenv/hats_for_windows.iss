; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{AB17F62F-BE30-45C1-8E66-E232BF6939AB}
AppName=hats for Windows
AppVersion=1.2.2
VersionInfoVersion=1.2.2
AppVerName=hats for Windows
AppPublisher=GovTech
AppPublisherURL=
AppSupportURL=
AppUpdatesURL=
DefaultDirName=C:\Program Files\hats
DefaultGroupName=hats for Windows
DisableProgramGroupPage=yes
OutputBaseFilename=hats_for_Windows
Compression=lzma
SolidCompression=yes
DiskSpanning=no

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "\\?\Volume{e641b67c-0000-0000-0000-402400000000}\Program Files\hats\*"; DestDir: "\\?\{app}"; Flags: ignoreversion recursesubdirs createallsubdirs;
; Use 'mountvol' to find UNC path to volume
;Source: "C:\Program Files\hats\*"; DestDir: "{app}"; Excludes: "androidSDK\.android\avd"; Flags: ignoreversion recursesubdirs createallsubdirs;
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Run]
Filename: "{app}\utils\init.cmd"; WorkingDir: "{app}";
Filename: "{app}\hats_shell.cmd"; Parameters: ".\testpage\test.cmd -show"; WorkingDir: "{app}";

[UninstallRun]
Filename: "uninstall.cmd"; WorkingDir: "{app}\utils";
