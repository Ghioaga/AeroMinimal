; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "AeroMinimal"
#define MyAppVersion "1.0.0.9"
#define MyAppPublisher "u/Ghioaga"
#define MyAppURL "https://www.reddit.com/user/Ghioaga"
#define MyAppExeName "AeroCtl.UI.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{1F2B28DA-03E5-4349-A584-3AFDE6577F67}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
LicenseFile=C:\Users\ghioa\Desktop\AeroMinimal\Files\Licence.txt
OutputDir=C:\Users\ghioa\Desktop\AeroMinimal\Setup
OutputBaseFilename=AeroMinimal
Compression=lzma
SolidCompression=yes
WizardStyle=modern
AlwaysRestart=true

[Types]
Name: "CC"; Description: "ControlCenter";
Name: "SM"; Description: "SmartManager";
Name: "CSM"; Description: "Custom"; Flags: iscustom;

[Components]
Name: "aeroctl"; Description: "AeroCtl App";
Name: "aeroctl\latest"; Description: "Latest AeroCtl"; Types:CC SM; Flags: exclusive;
Name: "aeroctl\aeroctl_014"; Description: "AeroCtl version 0.1.4 best for Aero 15 Xv8"; Flags: exclusive;
Name: "Dll"; Description: "dll taken from CC or SM";
Name: "Dll\CC"; Description: "dll for Laptops Running CC"; Types: CC; Flags: exclusive;
Name: "Dll\SM"; Description: "dll for Laptops Running SM"; Types: SM; Flags: exclusive;
Name: "Fusion"; Description: "Gigabyte Fusion Standalone for KeyboardRGB";
 
[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked


[Files] 
Source: "C:\Users\ghioa\Desktop\AeroMinimal\Files\SM\acpimof.dll"; DestDir: "{win}\system32"; Flags: ignoreversion; Components: Dll\SM; 
Source: "C:\Users\ghioa\Desktop\AeroMinimal\Files\CC\acpimof.dll"; DestDir: "{win}\system32"; Flags: ignoreversion; Components: Dll\CC;
Source: "C:\Users\ghioa\Desktop\AeroMinimal\Files\SM\acpimof.dll"; DestDir: "{win}\SysWOW64"; Flags: ignoreversion; Components: Dll\SM; 
Source: "C:\Users\ghioa\Desktop\AeroMinimal\Files\CC\acpimof.dll"; DestDir: "{win}\SysWOW64"; Flags: ignoreversion; Components: Dll\CC;
Source: "C:\Users\ghioa\Desktop\AeroMinimal\Files\GigabyteFusion.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: Fusion;
Source: "C:\Users\ghioa\Desktop\AeroMinimal\Files\7za.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall;
Source: "C:\Users\ghioa\Desktop\AeroMinimal\Files\7za.dll"; DestDir: "{tmp}"; Flags: deleteafterinstall;
Source: "C:\Users\ghioa\Desktop\AeroMinimal\Files\7zxa.dll"; DestDir: "{tmp}"; Flags: deleteafterinstall;
Source: "{tmp}\AeroCtl.7z"; DestDir: "{tmp}"; Flags: external deleteafterinstall; Components: aeroctl\aeroctl_014;
Source: "{tmp}\AeroCtl.UI.exe"; DestDir: "{app}\AeroCtl"; Flags: external; Components: aeroctl\latest;

[Code]
var
  DownloadPage: TDownloadWizardPage;
function OnDownloadProgress(const Url, FileName: String; const Progress, ProgressMax: Int64): Boolean;
begin
  if Progress = ProgressMax then
    Log(Format('Successfully downloaded file to {tmp}: %s', [FileName]));
  Result := True;
end;
procedure InitializeWizard;
begin
  DownloadPage := CreateDownloadPage(SetupMessage(msgWizardPreparing), SetupMessage(msgPreparingDesc), @OnDownloadProgress);
end;
function NextButtonClick(CurPageID: Integer): Boolean;
begin
  if CurPageID = wpReady then begin
    DownloadPage.Clear;
    if WizardIsComponentSelected('aeroctl\aeroctl_014') then DownloadPage.Add('https://gitlab.com/wtwrp/aeroctl/uploads/f75ee06a82de8a0c96c951192e781bd2/AeroCtl.7z', 'AeroCtl.7z', '');
    if WizardIsComponentSelected('aeroctl\latest') then DownloadPage.Add('http://f.0x.re/aeroctl/0.3.0/AeroCtl.UI.exe', 'AeroCtl.UI.exe', '');
    DownloadPage.Show;
    try
      try
        DownloadPage.Download; // This downloads the files to {tmp}
        Result := True;
      except
        if DownloadPage.AbortedByUser then
          Log('Aborted by user.')
        else
          SuppressibleMsgBox(AddPeriod(GetExceptionMessage), mbCriticalError, MB_OK, IDOK);
        Result := False;
      end;
    finally
      DownloadPage.Hide;
    end;
  end else
    Result := True;
end;

[Registry]
Root: HKLM; Subkey: "SYSTEM\ControlSet001";
Root: HKLM; Subkey: "SYSTEM\ControlSet001\Services";
Root: HKLM; Subkey: "SYSTEM\ControlSet001\Services\WmiAcpi";
Root: HKLM; Subkey: "SYSTEM\ControlSet001\Services\WmiAcpi"; ValueType: string; ValueName: "MofImagePath"; ValueData: "%windir%\system32\acpimof.dll"
Root: HKLM; Subkey: "Software\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "AeroCtl"; ValueData: "{app}\AeroCtl\AeroCtl.UI.exe"

[Icons]
Name: "{autoprograms}\{#MyAppName}\AeroCtl"; Filename: "{app}\AeroCtl\{#MyAppExeName}"
Name: "{autodesktop}\AeroCtl"; Filename: "{app}\AeroCtl\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: {tmp}\7za.exe; Parameters: "x ""{tmp}\AeroCtl.7z"" -o""{app}\AeroCtl"" -y";
Filename: {app}\GigabyteFusion.exe; Components: Fusion;
