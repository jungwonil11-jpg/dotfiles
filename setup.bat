@echo off
chcp 65001 > nul
set TARGET=%USERPROFILE%\.claude\skills
if not exist "%TARGET%" mkdir "%TARGET%"
xcopy /E /Y /I "%~dp0.claude\skills\*" "%TARGET%\" > nul
echo.
echo 완료: %TARGET% 에 skill 복사됨
echo.
pause
