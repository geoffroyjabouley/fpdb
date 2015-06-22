@echo OFF
REM ADD "OPEN COMMAND AS AN ADMINISTRATOR" TO MOUSE RIGHT-CLICK MENU FOR NEXT STEPS
start http://www.sevenforums.com/attachments/tutorials/214347d1338396625-open-command-window-here-administrator-add_open_command_window_here_as_administrator.reg*
@echo.
@echo.
@echo Right click on the downloaded file and select "Merge"
@echo Now you can open a command line editor with administrator rights in a folder using the mouse right-click button menu
@echo.
pause

REM INSTALL WGET & UNZIP UTILITIES (NEEDED FOR LATER)
start http://downloads.sourceforge.net/gnuwin32/wget-1.11.4-1-setup.exe
@echo.
@echo.
@echo double-click on the downloaded file, follow the setup process and ***DON'T CHANGE ANY OPTIONS***
@echo.
pause
@echo This window will close, now right-click on file step2.bat and select "Run as Administrator"
pause
@echo ON