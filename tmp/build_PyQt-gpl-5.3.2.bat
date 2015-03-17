wget -c http://sourceforge.net/projects/pyqt/files/PyQt5/PyQt-5.3.2/PyQt-gpl-5.3.2.zip
unzip -o -q PyQt-gpl-5.3.2.zip -d .
pushd PyQt-gpl-5.3.2
sed -i.orig s/\(\['webkitwidgets'\)\(\]\)/\1,'printsupport'\2/g configure.py
call "C:\Program Files\Microsoft Visual Studio 9.0\VC\vcvarsall.bat"
python configure.py --confirm-license
nmake
nmake install
popd
pause