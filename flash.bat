@Echo  =======================================================================
@Echo  * Replace BIOS.bin file in BIOS_FILE_NAME.txt and Run as Adminstrator *
@Echo. *                                                                     *
@Echo  *                                    Li.hh@hhzncn.com  2019-10-31 * 
@Echo. *                                                                     *
@Echo  =======================================================================

@cd   /d %~dp0
@set /p BIOS_FileName=<BIOS_FILE_NAME.txt

@ECHO.
@echo =========================CMD HELP=========================================
@echo /x : Don't Check ROM ID
@echo /S : Display current system's ROMID

@echo /P :(Program) Main BIOS
@echo /B :(Program) BootBlock 
@echo /N :(Program) NVRAM 
@echo /K :(Program) all non-critical blocks (PSP changed please add /K for AMD)
@echo /L :(Program) RomHole

@echo /R : Preserve ALL SMBIOS structure during programming  
@echo /ME : Program ME Entire Firmware Block.
@echo ==================================================================


@Echo.

@if "%PROCESSOR_ARCHITECTURE%"=="x86" goto x86
@if "%PROCESSOR_ARCHITECTURE%"=="AMD64" goto x64

:x86
@echo x32 OS
@set AFU_EXE_NAME=afuwin.exe
@goto Retry

:x64
@echo x64 OS
@set AFU_EXE_NAME=AFUWINx64.exe
@goto Retry

:Retry
@echo %BIOS_FileName%

REM ===Raven+Picasso+Rn2==
%AFU_EXE_NAME%    %BIOS_FileName%  /p  /b /n  /k /L  /x /REBOOT

REM  Rn1
REM  
REM  %AFU_EXE_NAME%    %BIOS_FileName%  /p  /b /n  /k   /x /REBOOT


@if  %errorlevel% == 0 goto pass
timeout -t 30
goto Retry

:pass
@REM cls
@color 0A
@ECHO.
@ECHO.
@ECHO =======PASS=======
@ECHO.
@ECHO.
@goto end

:fail
@echo fail
@goto end

:end

@timeout  /t 10
@REM c:\windows\system32\shutdown.exe -r -t 0

pause