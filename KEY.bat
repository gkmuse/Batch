@echo off

setlocal EnableDelayedExpansion

set char=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
set count=0
set salt=0

echo The maximum RC4 key length is 128 bits.
echo Default KEY length is 16 characters.

:Number
set /p salt=Enter a salt value(Integer): 
if !salt! gtr 32752 goto Number

set /a length=15 + !salt!

:Loop
set /a count+=1
set /a rand=%Random%%%61
set buffer=!buffer!!char:~%rand%,1!
if !count! leq !length! goto Loop

echo KEY = !buffer!
set /a length+=1
echo The length of KEY is !length! characters.
echo !buffer! | clip
echo KEY had been saved in clipboard^^!

set /p question=Do you want to save KEY into KEY.txt? [Y/n] 
if /i "!question!" == "n" goto EOF
if /i "!question!" == "N" goto EOF
if /i "!question!" == "no" goto EOF
if /i "!question!" == "No" goto EOF
if /i "!question!" == "NO" goto EOF
echo The length of KEY is !length! > KEY.txt
echo KEY=!buffer! >> KEY.txt
:EOF

endlocal