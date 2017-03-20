@echo off

set NODE1_PUBLIC_NAME=w2012r2-1
set NODE2_PUBLIC_NAME=w2012r2-2
set CMD=grid\runcluvfy.bat

call %CMD% comp sys -n %NODE1_PUBLIC_NAME%,%NODE2_PUBLIC_NAME% -p crs

call %CMD% comp sys -n %NODE1_PUBLIC_NAME%,%NODE2_PUBLIC_NAME% -p ha

call %CMD% comp sys -n %NODE1_PUBLIC_NAME%,%NODE2_PUBLIC_NAME% -p database

call %CMD% comp space -n %NODE1_PUBLIC_NAME%,%NODE2_PUBLIC_NAME% -l C:\ -z 10G

call %CMD% stage -post hwos -n %NODE1_PUBLIC_NAME%,%NODE2_PUBLIC_NAME% -verbose



