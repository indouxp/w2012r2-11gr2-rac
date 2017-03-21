@echo off
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set NODE1_PUBLIC_NAME=w2012r2-1
set NODE2_PUBLIC_NAME=w2012r2-2
set NODE1_PUBLIC_IP=192.168.0.90
set NODE2_PUBLIC_IP=192.168.0.91
set NODE1_PRIVATE_NAME=w2012r2-1-priv
set NODE2_PRIVATE_NAME=w2012r2-2-priv
set NODE1_PRIVATE_IP=192.168.9.90
set NODE2_PRIVATE_IP=192.168.9.91
set PUBLIC_NAME=public
set PRIVATE_NAME=private
set ORACLE=oracle
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cls
call :HL
set /p OK=[ENTER]で、[%USERNAME%@%COMPUTERNAME%]のチェックを開始:
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo. 
call :HL

echo TEMP=%TEMP%
echo TMP=%TMP%

echo 環境変数TEMPと、TMPが同位置を示していること。
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo. 
call :HL

ipconfig

echo.
echo ネットワークアダプタの確認
echo %PUBLIC_NAME%が、%NODE1_PUBLIC_IP%、%NODE2_PUBLIC_IP%であること。
echo %PRIVATE_NAME%が、%NODE1_PRIVATE_IP%、%NODE2_PRIVATE_IP%であること。
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

reg query HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters /v DisableDHCPMediaSense

echo.
echo Windowsのメディア検出機能を無効
echo DisableDHCPMediaSense    REG_DWORD    0x1であること。
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

netsh advfirewall show allprofile | more

echo.
echo firewallの確認
echo 各プロファイルのStateがオフであること。
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL
echo 時刻同期(w32tm)確認

echo slewモードの確認
reg query HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Config / MaxPosPhaseCorrection
reg query HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Config / MaxNegPhaseCorrection
reg query HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Config / MaxAllowedPhaseOffset

echo.
echo 時刻同期slewモードの確認 
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

net start w32time
w32tm /query /peers

echo.
echo 時刻同期の確認
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL
echo ORACLEユーザー確認

net user %ORACLE%

echo.
echo ユーザー(%USERNAME%)が、Administratorsグループに属していること
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.

reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA

echo.
echo LUAが無効(0)であること
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.

net use \\%NODE1_PUBLIC_NAME%\c$
net use \\%NODE2_PUBLIC_NAME%\c$

echo.
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.

set /p OK=[ENTER]で、regeditを実行。「ファイル - ネットワーク レジストリへの接続」で、リモートノードを設定
regedit

echo.
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo 終了
exit /b 0
goto :EOF

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:HL
echo --------------------------------------------------------------------------------
goto :EOF
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:NEXT
echo.
call :HL
set /p OK=[ENTER]で、次へ:
cls
goto :EOF

