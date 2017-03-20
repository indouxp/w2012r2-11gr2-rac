@echo off

set ORACLE_HOME=c:\app\11.2.0\grid
set PATH=%ORACLE_HOME%\perl\bin;%PATH% 

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
call :HL
set /p OK=[ENTER]で、[%USERNAME%@%COMPUTERNAME%]のpatch準備確認を開始:

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

net stop msdtc

echo.
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

%ORACLE_HOME%\perl\bin\perl -I%ORACLE_HOME%\perl\lib -I%ORACLE_HOME%\crs\install %ORACLE_HOME%\crs\install\rootcrs.pl -unlock

echo.
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

crsctl status resource -t

echo.
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

net start | findstr /i ora 

echo.
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

net stop OracleRemExecService

echo.
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

net stop OraFenceService

echo.
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

sc config Winmgmt start= disabled

echo.
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

net stop winmgmt 

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo 終了
exit /b 0
goto :EOF
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:HL
echo ◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆
goto :EOF
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:NEXT
echo.
call :HL
set /p OK=[ENTER]で、次へ:
goto :EOF