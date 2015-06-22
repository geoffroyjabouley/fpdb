@echo OFF

REM INSTALL WGET & UNZIP UTILITIES (NEEDED FOR LATER)
setx GNUWIN32_HOME "C:\GnuWin32"
set GNUWIN32_HOME=C:\GnuWin32
setx PATH "%GNUWIN32_HOME%\bin"
set PATH=%PATH%;%GNUWIN32_HOME%\bin

set DEPS=%CD%\downloaded_dependencies
mkdir "%DEPS%"
wget -nc -c -P "%DEPS%" http://downloads.sourceforge.net/project/gnuwin32/unzip/5.51-1/unzip-5.51-1.exe
@echo.
@echo.
@echo INSTALLING Gnuwin32 Utils
echo Follow setup processes and ***DON'T CHANGE ANY OPTIONS***
@echo.
pause
"%DEPS%\unzip-5.51-1.exe"

REM INSTALL OTHERS GUNWIN32 TOOLS (NEEDED FOR LATER)
wget -nc -c -P "%DEPS%" http://downloads.sourceforge.net/project/gnuwin32/sed/4.2.1/sed-4.2.1-dep.zip
unzip -o "%DEPS%\sed-4.2.1-dep.zip" -d "%GNUWIN32_HOME%"
wget -nc -c -P "%DEPS%" http://downloads.sourceforge.net/project/gnuwin32/sed/4.2.1/sed-4.2.1-bin.zip
unzip -o "%DEPS%\sed-4.2.1-bin.zip" -d "%GNUWIN32_HOME%"
wget -nc -c -P "%DEPS%" http://downloads.sourceforge.net/project/gnuwin32/grep/2.5.4/grep-2.5.4-dep.zip
unzip -o "%DEPS%\grep-2.5.4-dep.zip" -d "%GNUWIN32_HOME%"
wget -nc -c -P "%DEPS%" http://downloads.sourceforge.net/project/gnuwin32/grep/2.5.4/grep-2.5.4-bin.zip
unzip -o "%DEPS%\grep-2.5.4-bin.zip" -d "%GNUWIN32_HOME%"
wget -nc -c -P "%DEPS%" http://downloads.sourceforge.net/project/gnuwin32/zip/3.0/zip-3.0-bin.zip
unzip -o "%DEPS%\zip-3.0-bin.zip" -d "%GNUWIN32_HOME%"
wget -nc -c -P "%DEPS%" http://downloads.sourceforge.net/project/gnuwin32/zip/3.0/zip-3.0-dep.zip
unzip -o "%DEPS%\zip-3.0-dep.zip" -d "%GNUWIN32_HOME%"
wget -nc -c -P "%DEPS%" http://downloads.sourceforge.net/project/gnuwin32/coreutils/5.3.0/coreutils-5.3.0-bin.zip
unzip -o "%DEPS%\coreutils-5.3.0-bin.zip" -d "%GNUWIN32_HOME%"
wget -nc -c -P "%DEPS%" http://downloads.sourceforge.net/project/gnuwin32/coreutils/5.3.0/coreutils-5.3.0-dep.zip
unzip -o "%DEPS%\coreutils-5.3.0-dep.zip" -d "%GNUWIN32_HOME%"

REM INSTALL GIT SCM TOOL
REM wget -nc -c -P %DEPS% https://github.com/msysgit/msysgit/releases/download/Git-1.9.5-preview20141217/Git-1.9.5-preview20141217.exe
REM @echo.
REM @echo.
REM @echo INSTALLING Git
REM @echo Follow the setup process, and:
REM @echo ***INSTALL in C:\Git (important)***
REM @echo ***Choose option "Use git from the Windows Command Prompt"***
REM @echo ***Choose option "Checkout as-is, commit as-is"***
REM @echo.
REM pause
REM %DEPS%\Git-1.9.5-preview20141217.exe
REM pause

REM INSTALL PYTHON 2.7
wget -nc --no-check-certificate -c -P "%DEPS%" https://www.python.org/ftp/python/2.7.10/python-2.7.10.msi
@echo.
@echo.
@echo INSTALLING Python 2.7.10
@echo Follow the setup process, and ***INSTALL in C:\Python27 (important)***
@echo.
pause
"%DEPS%\python-2.7.10.msi"
pause
setx PYTHON_HOME "C:\Python27"
set PYTHON_HOME=C:\Python27
setx PATH "%GNUWIN32_HOME%\bin;%PYTHON_HOME%;%PYTHON_HOME%\Scripts"
set PATH=%PATH%;%PYTHON_HOME%;%PYTHON_HOME%\Scripts

REM INSTALL VISUAL STUDIO 2008 C++ EXPRESS
wget -nc -c -P "%DEPS%" http://go.microsoft.com/?linkid=7729279
@echo.
@echo.
@echo INSTALLING VISUAL STUDIO 2008 C++ EXPRESS
@echo Follow the setup process, and ***UNTICK "Microsoft Silverligght Runtime" and "Microsoft SQl Server 2008 Express Edition"***
@echo.
@echo Take a coffee...
@echo.
pause
call "%DEPS%\vcsetup.exe"
pause

@echo.
@echo This window will close, now right-click on file step3.bat and select "Run as Administrator"
@echo.
pause
@echo ON