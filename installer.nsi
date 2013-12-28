!define PRODUCT_NAME "Balloon Logging and Tracking"

Name "${PRODUCT_NAME}"

RequestExecutionLevel admin
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"

outFile "${PRODUCT_NAME}.exe"

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
    CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\BalloonLogger.lnk" "$INSTDIR\BalloonLogger\BalloonLogger.exe"
SectionEnd

Section -any
    WriteUninstaller $INSTDIR\uninstall.exe
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
SectionEnd

Section "Uninstall"    
    Delete "$SMPROGRAMS\${PRODUCT_NAME}\*.lnk"
    RMDir /r "$SMPROGRAMS\${PRODUCT_NAME}"
    Delete $INSTDIR\uninstall.exe  
    RMDir /r "$INSTDIR"
SectionEnd  