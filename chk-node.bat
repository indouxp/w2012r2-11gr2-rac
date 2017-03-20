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
set /p OK=[ENTER]�ŁA[%USERNAME%@%COMPUTERNAME%]�̃`�F�b�N���J�n:
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo. 
call :HL

echo TEMP=%TEMP%
echo TMP=%TMP%

echo ���ϐ�TEMP�ƁATMP�����ʒu�������Ă��邱�ƁB
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo. 
call :HL

ipconfig

echo.
echo �l�b�g���[�N�A�_�v�^�̊m�F
echo %PUBLIC_NAME%���A%NODE1_PUBLIC_IP%�A%NODE2_PUBLIC_IP%�ł��邱�ƁB
echo %PRIVATE_NAME%���A%NODE1_PRIVATE_IP%�A%NODE2_PRIVATE_IP%�ł��邱�ƁB
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

reg query HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters /v DisableDHCPMediaSense

echo.
echo Windows�̃��f�B�A���o�@�\�𖳌�
echo DisableDHCPMediaSense    REG_DWORD    0x1�ł��邱�ƁB
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL

netsh advfirewall show allprofile | more

echo.
echo firewall�̊m�F
echo �e�v���t�@�C����State���I�t�ł��邱�ƁB
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL
echo ��������(w32tm)�m�F

net start w32time
w32tm /query /peers

echo.
echo ���������̊m�F �������� step,slew���[�h�̊m�F���d�| ��������
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call :HL
echo ORACLE���[�U�[�m�F

net user %ORACLE%

echo.
echo ���[�U�[(%USERNAME%)���AAdministrators�O���[�v�ɑ����Ă��邱��
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.

reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA

echo.
echo LUA�������ł��邱��
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.

net use \\%NODE1_PUBLIC_NAME%\c$
net use \\%NODE2_PUBLIC_NAME%\c$

echo.
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.

set /p OK=[ENTER]�ŁAregedit�����s�B�u�t�@�C�� - �l�b�g���[�N ���W�X�g���ւ̐ڑ��v�ŁA�����[�g�m�[�h��ݒ�
regedit

echo.
call :next
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo �I��
exit /b 0
goto :EOF

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:HL
echo ��������������������������������������������������������������������������������
goto :EOF
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:NEXT
echo.
call :HL
set /p OK=[ENTER]�ŁA����:
cls
goto :EOF

