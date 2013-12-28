!define PRODUCT_NAME "Balloon Logging and Tracking"
!define PRODUCT_VERSION "1.0"
!define PRODUCT_PUBLISHER "Taylor University"
 
SetCompressor zlib

Section "MySQL"
    SetOutPath "$TEMP"
    File "bins\mysql-5.5.35-win32.msi"
    ExecWait "msiexec /i $TEMP\mysql-5.5.35-win32.msi /passive"
SectionEnd

Section "BalloonLogger"
  SetOutPath $INSTDIR\BalloonLogger
  File "bins\BalloonLogger\*"
SectionEnd

Page components
Page directory
Page instfiles
UninstPage uninstConfirm
UninstPage instfiles