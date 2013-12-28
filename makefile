MAKENSIS = "D:\Program Files (x86)\NSIS\makensis.exe"

all: installer

installer: 
	$(MAKENSIS) installer.nsi