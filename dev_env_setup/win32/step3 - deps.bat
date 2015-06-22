@echo OFF

set DEPS="%CD%\downloaded_dependencies"
mkdir %DEPS%

REM DOWNLOAD QT AND BUILD FROM SOURCE BECAUSE YOU NEED TO BUILD WITH THE SAME COMPILER AS PYTHON: VS2008
@echo.
@echo.
@echo INSTALLING QT 5.3.2
@echo.
@echo It takes ages! Take a nap...
@echo.
pause
wget -nc -c -P %DEPS% "http://www.7-zip.org/a/7za920.zip"
pushd %DEPS%
unzip -o -q 7za920.zip -d .
popd

set QT5_FOLDER=qt5
set QT5_HOME=C:\%QT5_FOLDER%
mkdir %QT5_HOME%
wget -nc -c -P %QT5_HOME% http://download.qt.io/archive/qt/5.3/5.3.2/single/qt-everywhere-opensource-src-5.3.2.zip
pushd %QT5_HOME%
%DEPS%\7za.exe x qt-everywhere-opensource-src-5.3.2.zip
mv qt-everywhere-opensource-src-5.3.2/* .
del /S /S qt-everywhere-opensource-src-5.3.2
REM unzip -o -q qt-everywhere-opensource-src-5.3.2.zip -d .
REM cd qt-everywhere-opensource-src-5.3.2
call "c:\program files\microsoft visual studio 9.0\vc\vcvarsall.bat"
call configure -prefix %CD%\qtbase -opensource -nomake tests -nomake examples -confirm-license -release -skip WebKit -no-opengl 2>&1 | tee -a build_qt.log
sed -i.orig s/\(Interlocked.*crement(\)/\1(LONG\*)/g qtmultimedia\src\plugins\directshow\camera\dscamerasession.cpp
nmake 2>&1 | tee -a build_qt.log
setx QT5_HOME "%QT5_HOME%"
setx QMAKESPEC "win32-msvc2008"
set QMAKESPEC=win32-msvc2008
setx PATH "%GNUWIN32_HOME%\bin;%PYTHON_HOME%;%PYTHON_HOME%\Scripts;%QT5_HOME%\qtbase\bin"
set PATH=%PATH%;%QT5_HOME%\qtbase\bin

xcopy %QT5_HOME%\gnuwin32 "%GNUWIN32_HOME%" /S /Y
popd

REM INSTALLING MICROSOFT VISUAL C++ 2008 REDISTRIBUABLE PACKAGE
@echo.
@echo.
@echo INSTALLING Microsoft Visual C++ 2008 Redistribuable package
@echo.
pause
wget -nc -c -P %DEPS% http://download.microsoft.com/download/1/1/1/1116b75a-9ec3-481a-a3c8-1777b5381140/vcredist_x86.exe
%DEPS%\vcredist_x86.exe

REM INSTALLING SEVERAL PYTHON LIBRARIES
@echo.
@echo.
@echo INSTALLING Several Python Libraries
echo Follow setup processes and ***DON'T CHANGE ANY OPTIONS***
@echo.
pause
wget -nc -c -P %DEPS% http://sourceforge.net/projects/numpy/files/NumPy/1.9.2/numpy-1.9.2-win32-superpack-python2.7.exe
%DEPS%\numpy-1.9.2-win32-superpack-python2.7.exe /arch nosse
wget -nc -c -P %DEPS% "http://sourceforge.net/projects/pywin32/files/pywin32/Build%20219/pywin32-219.win32-py2.7.exe"
%DEPS%\pywin32-219.win32-py2.7.exe
wget -nc -c -P %DEPS% http://www.stickpeople.com/projects/python/win-psycopg/2.6.0/psycopg2-2.6.0.win32-py2.7-pg9.4.1-release.exe
%DEPS%\psycopg2-2.6.0.win32-py2.7-pg9.4.1-release.exe
wget -nc -c -P %DEPS% http://downloads.sourceforge.net/project/fpdb/fpdb/pypoker-eval-win32/pokereval-138.win32-py2.7.exe
%DEPS%\pokereval-138.win32-py2.7.exe
wget -nc -c -P %DEPS% http://sourceforge.net/projects/mysql-python/files/mysql-python/1.2.3/MySQL-python-1.2.3.win32-py2.7.msi
%DEPS%\MySQL-python-1.2.3.win32-py2.7.msi

wget -nc -c -P %DEPS% http://sourceforge.net/projects/pyqt/files/sip/sip-4.16.6/sip-4.16.6.zip
pushd %DEPS%
unzip -o -q sip-4.16.6.zip -d .
cd sip-4.16.6
call "C:\Program Files\Microsoft Visual Studio 9.0\VC\vcvarsall.bat"
python configure.py 2>&1 | tee -a build_python_deps.log
nmake 2>&1 | tee -a build_python_deps.log
nmake install 2>&1 | tee -a build_python_deps.log
popd

wget -nc -c -P %DEPS% http://sourceforge.net/projects/pyqt/files/PyQt5/PyQt-5.3.2/PyQt-gpl-5.3.2.zip
pushd %DEPS%
unzip -o -q PyQt-gpl-5.3.2.zip -d .
cd PyQt-gpl-5.3.2
sed -i.orig s/\(\['webkitwidgets'\)\(\]\)/\1,'printsupport'\2/g configure.py
call "C:\Program Files\Microsoft Visual Studio 9.0\VC\vcvarsall.bat"
python configure.py --confirm-license 2>&1 | tee -a build_python_deps.log
nmake 2>&1 | tee -a build_python_deps.log
nmake install 2>&1 | tee -a build_python_deps.log
popd

pip install --upgrade pip 2>&1 | tee -a build_python_deps.log
pip install matplotlib winpaths pytz six python-dateutil pyparsing beautifulsoup xlrd pyinstaller 2>&1 | tee -a build_python_deps.log

pause
@echo.
@echo This window will close, you can now compile and package fpdb by running script build_fpdb.bat in git root folder
@echo.
pause
@echo ON