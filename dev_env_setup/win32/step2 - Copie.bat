@echo OFF

REM INSTALL MINGW/MSYS UTILITIES (NEEDED FOR LATER)
setx MINGW_HOME "C:\MinGW"
set MINGW_HOME=C:\MinGW
setx MSYS_HOME "%MINGW_HOME\msys\1.0"
set MINGW_HOME=C:\MinGW
setx PATH "%PATH%;%MINGW_HOME\bin;%MSYS_HOME%\bin"
set PATH=%PATH%;%MINGW_HOME\bin;%MSYS_HOME%\bin

set DEPS="%CD%\downloaded_dependencies"
mkdir %DEPS%

REM INSTALL GIT SCM TOOL
REM wget -nc -c -P %DEPS% https://github.com/msysgit/msysgit/releases/download/Git-1.9.5-preview20141217/Git-1.9.5-preview20141217.exe
REM @echo.
REM @echo.
REM @echo INSTALLING Git
REM @echo Follow the setup process, and:
REM @echo ***INSTALL in C:\Git (important)***
REM @echo ***Choose option "Use git from the Windows Command Prompt"***
REM @echo ***Choose option "Checkout as-is, commit as-is"***
REM pause
REM %DEPS%\Git-1.9.5-preview20141217.exe
REM pause
REM set PATH=%PATH%;C:\Git\cmd

REM INSTALL PYTHON 2.7
wget -nc -c -P %DEPS% https://www.python.org/ftp/python/2.7.10/python-2.7.10.msi
@echo.
@echo.
@echo INSTALLING Python 2.7.10
@echo Follow the setup process, and ***INSTALL in C:\Python27 (important)***
@echo.
pause
%DEPS%\python-2.7.10.msi
pause
setx PYTHON_HOME "C:\Python27"
set PYTHON_HOME=C:\Python27
setx PATH "%PATH%;%PYTHON_HOME%;%PYTHON_HOME%\Scripts"
set PATH=%PATH%;%PYTHON_HOME%;%PYTHON_HOME%\Scripts

REM INSTALL VISUAL STUDIO 2008 C++ EXPRESS
wget -nc -c -P %DEPS% http://go.microsoft.com/?linkid=7729279
@echo.
@echo.
@echo INSTALLING VISUAL STUDIO 2008 C++ EXPRESS
@echo Follow the setup process, and ***UNTICK "Microsoft Silverligght Runtime" and "Microsoft SQl Server 2008 Express Edition"***
@echo.
@echo Take a coffee...
@echo.
pause
call %DEPS%\vcsetup.exe
pause
@echo This window will close, now right-click on file step3.bat and select "Run as Administrator"
pause
@echo ON