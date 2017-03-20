@echo off

set ORACLE_HOME=c:\app\11.2.0\grid
set PATH=%ORACLE_HOME%\perl\bin;%PATH% 

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
call :HL
set /p OK=[ENTER]で、[%USERNAME%@%COMPUTERNAME%]のpatch後処理を開始:

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

sc config Winmgmt start= auto

echo.
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

%ORACLE_HOME%\perl\bin\perl -I%ORACLE_HOME%\perl\lib -I%ORACLE_HOME%\crs\install %ORACLE_HOME%\crs\install\rootcrs.pl -patch     

echo.
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

net start msdtc

echo.
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

net start winmgmt  

echo.
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

call %ORACLE_HOME%\bin\crssetup deinstallfence

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