MAKENSIS = "D:\Program Files (x86)\NSIS\makensis.exe"

all: installer

bins/mysql-5.5.35-win32.msi: 
	wget --progress dot:mega -O $@ http://cdn.mysql.com/Downloads/MySQL-5.5/mysql-5.5.35-win32.msi
    
installer: bins/mysql-5.5.35-win32.msi
	$(MAKENSIS) installer.nsi