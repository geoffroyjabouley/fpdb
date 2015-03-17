wget http://download.qt.io/archive/qt/5.3/5.3.2/single/qt-everywhere-opensource-src-5.3.2.zip
unzip -o -q qt-everywhere-opensource-src-5.3.2.zip -d .
cd qt-everywhere-opensource-src-5.3.2
call "c:\program files\microsoft visual studio 9.0\vc\vcvarsall.bat"
call configure -prefix %CD%\qtbase -opensource -nomake tests -nomake examples -confirm-license -release -skip WebKit -no-opengl
sed -i s/\(Interlocked.*crement(\)/\1(LONG\*)/g qtmultimedia\src\plugins\directshow\camera\dscamerasession.cpp
nmake