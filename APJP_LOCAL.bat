@echo off
cd %~dp0
setlocal=EnableDelayedExpansion
set a=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
set count=0
:loop
set /a count+=1
set /a rand=%Random%%%61
set buffer=!buffer!!a:~%rand%,1!
:: The maximum length of APJP_KEY is 16
if !count! leq 15 goto loop
echo APJP_KEY=!buffer!
rename APJP_LOCAL.properties APJP_LOCAL.tmp
for /f "tokens=*" %%i in (APJP_LOCAL.tmp) do (
set foo=%%i
if "!foo!"=="APJP_KEY=" set foo=APJP_KEY=!buffer!
if "!foo!"=="APJP_REMOTE_HTTP_SERVER_1_REQUEST_URL=" set foo=APJP_REMOTE_HTTP_SERVER_1_REQUEST_URL=https://www.google.be/HTTP
if "!foo!"=="APJP_REMOTE_HTTPS_SERVER_1_REQUEST_URL=" set foo=APJP_REMOTE_HTTPS_SERVER_1_REQUEST_URL=https://www.google.be/HTTPS
<nul set /p ".=!foo!" >> APJP_LOCAL.properties
echo.>> APJP_LOCAL.properties
)
del APJP_LOCAL.tmp
::java -classpath APJP_LOCAL_JAVA-1.0.0.jar APJP.Main