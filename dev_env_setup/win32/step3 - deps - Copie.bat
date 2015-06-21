@echo OFF

set DEPS="downloaded_dependencies"
mkdir %DEPS%

REM DOWNLOAD QT AND BUILD FROM SOURCE BECAUSE YOU NEED TO BUILD WITH THE SAME COMPILER AS PYTHON: VS2008
@echo.
@echo.
@echo INSTALLING QT 5.3.2
pause
wget -c -P %DEPS% http://download.qt.io/archive/qt/5.3/5.3.2/single/qt-everywhere-opensource-src-5.3.2.zip
pushd %DEPS%
unzip -o -q qt-everywhere-opensource-src-5.3.2.zip -d .
cd qt-everywhere-opensource-src-5.3.2
call "c:\program files\microsoft visual studio 9.0\vc\vcvarsall.bat"
call configure -prefix %CD%\qtbase -opensource -nomake tests -nomake examples -confirm-license -release -skip WebKit -no-opengl
sed -i.orig s/\(Interlocked.*crement(\)/\1(LONG\*)/g qtmultimedia\src\plugins\directshow\camera\dscamerasession.cpp
nmake
setx QT5_HOME "%CD%"
set QT5_HOME=%CD%
setx QMAKESPEC "win32-msvc2008"
set QMAKESPEC=win32-msvc2008
setx PATH "%PATH%;%QT5_HOME%\qtbase\bin"
set PATH=%PATH%;%QT5_HOME%\qtbase\bin

copy %QT5_HOME%\gnuwin32\* in %MINGW_HOME%
popd

REM INSTALLING MICROSOFT VISUAL C++ 2008 REDISTRIBUABLE PACKAGE
@echo.
@echo.
@echo INSTALLING Microsoft Visual C++ 2008 Redistribuable package
pause
wget -c -P %DEPS% http://download.microsoft.com/download/1/1/1/1116b75a-9ec3-481a-a3c8-1777b5381140/vcredist_x86.exe
%DEPS%\vcredist_x86.exe

REM INSTALLING SEVERAL PYTHON LIBRARIES
@echo.
@echo.
@echo INSTALLING Several Python Libraries
echo Follow the setup process and ***DON'T CHANGE ANY OPTIONS***
pause
wget -c -P %DEPS% http://sourceforge.net/projects/numpy/files/NumPy/1.9.2/numpy-1.9.2-win32-superpack-python2.7.exe
%DEPS%\numpy-1.9.2-win32-superpack-python2.7.exe /arch nosse
wget -c -P %DEPS% http://sourceforge.net/projects/pywin32/files/pywin32/Build%20219/pywin32-219.win32-py2.7.exe
%DEPS%\pywin32-219.win32-py2.7.exe
wget -c -P %DEPS% http://www.stickpeople.com/projects/python/win-psycopg/2.6.0/psycopg2-2.6.0.win32-py2.7-pg9.4.1-release.exe
%DEPS%\psycopg2-2.6.0.win32-py2.7-pg9.4.1-release.exe
wget -c -P %DEPS% http://downloads.sourceforge.net/project/fpdb/fpdb/pypoker-eval-win32/pokereval-138.win32-py2.7.exe
%DEPS%\pokereval-138.win32-py2.7.exe
wget -c -P %DEPS% http://sourceforge.net/projects/mysql-python/files/mysql-python/1.2.3/MySQL-python-1.2.3.win32-py2.7.msi
%DEPS%\MySQL-python-1.2.3.win32-py2.7.msi

wget -c -P %DEPS% http://sourceforge.net/projects/pyqt/files/sip/sip-4.16.6/sip-4.16.6.zip
pushd %DEPS%
unzip -o -q sip-4.16.6.zip -d .
cd sip-4.16.6
call "C:\Program Files\Microsoft Visual Studio 9.0\VC\vcvarsall.bat"
python configure.py
nmake
nmake install
popd

wget -c -P %DEPS% http://sourceforge.net/projects/pyqt/files/PyQt5/PyQt-5.3.2/PyQt-gpl-5.3.2.zip
pushd %DEPS%
unzip -o -q PyQt-gpl-5.3.2.zip -d .
cd PyQt-gpl-5.3.2
sed -i.orig s/\(\['webkitwidgets'\)\(\]\)/\1,'printsupport'\2/g configure.py
call "C:\Program Files\Microsoft Visual Studio 9.0\VC\vcvarsall.bat"
python configure.py --confirm-license
nmake
nmake install
popd

pip install matplotlib winpaths pytz six python-dateutil pyparsing beautifulsoup xlrd pyinstaller

pause
@echo This window will close, you can now compile and package fpdb by running script build_fpdb.bat in git root folder
pause
@echo ON