!define PRODUCT_NAME "Balloon Logging and Tracking"

InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"

SetCompressor zlib

Page components
Page directory
Page instfiles
UninstPage uninstConfirm
UninstPage instfiles

Section "MySQL"
    SetOutPath "$TEMP"
    File "bins\mysql-5.5.35-win32.msi"
    ExecWait "msiexec /i $TEMP\mysql-5.5.35-win32.msi /passive"
SectionEnd

Section "Database Configuration"
SectionEnd

Section "BalloonLogger"
  SetOutPath $INSTDIR\BalloonLogger
  File "bins\BalloonLogger\*"
  WriteUninstaller $INSTDIR\uninstaller.exe
SectionEnd

Section "Uninstall"    
  SetShellVarContext all  
  Delete "$DESKTOP\Your Application.lnk"  
  RMDir /r "$SMPROGRAMS\${PRODUCT_NAME}"  
  RMDir /r "$INSTDIR"  
  Delete $INSTDIR\uninstall.exe  
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\YourApp"  
SectionEnd  