@echo OFF

REM git clean -fd
set FPDB_RELEASE_FILE=fpdb_release.zip.exe
pyi-build --distpath=windist -y fpdb.spec
del %FPDB_RELEASE_FILE%
pushd windist
copy /Y HUD_main\* fpdb
zip -A -r -9 ..\%FPDB_RELEASE_FILE% fpdb
popd

@echo.
@echo.
@echo FPDB shall have build correctly and is available:
@echo - as an installer in file %CD%\%FPDB_RELEASE_FILE%
@echo - in folder %CD%\windist\fpdb\fpdb.exe
@echo.
pause
@echo This window will close
pause
@echo ON