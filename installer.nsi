!define PRODUCT_NAME "Balloon Logging and Tracking"
!define MYSQL_PATH "$PROGRAMFILES\MySQL\MySQL Server 5.5"

Name "${PRODUCT_NAME}"

RequestExecutionLevel admin
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"

outFile "${PRODUCT_NAME}.exe"

SetCompressor /SOLID zlib

Page components
Page directory
Page instfiles
UninstPage uninstConfirm
UninstPage instfiles

Section "MySQL"
    SetOutPath "$TEMP"
    File "bins\mysql-5.5.35-win32.msi"
    ExecWait "msiexec /i $TEMP\mysql-5.5.35-win32.msi /passive"
    File "bins\mysql.ini"
    ExecWait "$\"${MYSQL_PATH}\bin\MySQLInstanceConfig.exe$\" -i -q $\"-lc:\mysql_install.log$\" $\"-nMySQL Server 5.5 (Balloon track)$\" $\"-p${MYSQL_PATH}$\" -v5.5.35 $\"-t$TEMP\mysql.ini$\" ServerType=DEVELOPMENT DatabaseType=MIXED ConnectionUsage=DSS Port=3306 ServiceName=MySQL55 RootPassword="
SectionEnd

Section "Database Configuration"
    SetOutPath "$TEMP"
    ExecWait "$\"${MYSQL_PATH}\bin\mysql.exe$\" -u root -e $\"create database balloontrack$\""
    File "bins\schema.sql"
    ExecWait "cmd /C $\"$\"${MYSQL_PATH}\bin\mysql.exe$\" -u root -D balloontrack < $\"$TEMP\schema.sql$\"$\""
SectionEnd

Section "BalloonLogger"
    SetOutPath $INSTDIR\BalloonLogger
    File "bins\BalloonLogger\*"
    CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\BalloonLogger.lnk" "$INSTDIR\BalloonLogger\BalloonLogger.exe"
SectionEnd

Section "BalloonGraph"
    SetOutPath $INSTDIR\BalloonGraph
    File "bins\BalloonGraph\*"
    CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\BalloonGraph.lnk" "$INSTDIR\BalloonGraph\BalloonGraph.exe"
SectionEnd

Section "BalloonMap"
    SetOutPath $INSTDIR\BalloonMap
    File "bins\BalloonMap\*"
    CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\BalloonMap.lnk" "$INSTDIR\BalloonMap\BalloonMap.exe"
SectionEnd

Section -any
    WriteUninstaller $INSTDIR\uninstall.exe
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayName" "${PRODUCT_NAME}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
	
SectionEnd

Section "Uninstall"    
    Delete "$SMPROGRAMS\${PRODUCT_NAME}\*.lnk"
    RMDir /r "$SMPROGRAMS\${PRODUCT_NAME}"
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
    Delete $INSTDIR\uninstall.exe  
    RMDir /r "$INSTDIR"
SectionEnd  