@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

title Cache Cleaner

echo.
echo ==========================================
echo              CACHE CLEANER
echo ==========================================
echo.

set "COUNT=0"
set "FAILED=0"

:: =========================================================
:: NVIDIA - Local
:: =========================================================

echo [1/4] Очистка:
echo       %LOCALAPPDATA%\NVIDIA
echo.

if exist "%LOCALAPPDATA%\NVIDIA" (
    for /f "delims=" %%F in ('dir /b /a-d "%LOCALAPPDATA%\NVIDIA" 2^>nul') do (
        del /f /q "%LOCALAPPDATA%\NVIDIA\%%F" >nul 2>&1
        if not exist "%LOCALAPPDATA%\NVIDIA\%%F" (
            set /a COUNT+=1
            echo       [OK] %%F
        ) else (
            set /a FAILED+=1
            echo       [SKIP] %%F
        )
    )

    for /d %%D in ("%LOCALAPPDATA%\NVIDIA\*") do (
        rd /s /q "%%D" >nul 2>&1
        if not exist "%%D" (
            echo       [OK] папка %%~nxD
        ) else (
            echo       [SKIP] папка %%~nxD
        )
    )
) else (
    echo       [INFO] Папка не найдена
)

echo.

:: =========================================================
:: NVIDIA - LocalLow
:: =========================================================

echo [2/4] Очистка:
echo       %USERPROFILE%\AppData\LocalLow\NVIDIA
echo.

if exist "%USERPROFILE%\AppData\LocalLow\NVIDIA" (
    for /f "delims=" %%F in ('dir /b /a-d "%USERPROFILE%\AppData\LocalLow\NVIDIA" 2^>nul') do (
        del /f /q "%USERPROFILE%\AppData\LocalLow\NVIDIA\%%F" >nul 2>&1
        if not exist "%USERPROFILE%\AppData\LocalLow\NVIDIA\%%F" (
            set /a COUNT+=1
            echo       [OK] %%F
        ) else (
            set /a FAILED+=1
            echo       [SKIP] %%F
        )
    )

    for /d %%D in ("%USERPROFILE%\AppData\LocalLow\NVIDIA\*") do (
        rd /s /q "%%D" >nul 2>&1
        if not exist "%%D" (
            echo       [OK] папка %%~nxD
        ) else (
            echo       [SKIP] папка %%~nxD
        )
    )
) else (
    echo       [INFO] Папка не найдена
)

echo.

:: =========================================================
:: TEMP
:: =========================================================

echo [3/4] Очистка:
echo       %TEMP%
echo.

if exist "%TEMP%" (
    for /f "delims=" %%F in ('dir /b /a-d "%TEMP%" 2^>nul') do (
        del /f /q "%TEMP%\%%F" >nul 2>&1
        if not exist "%TEMP%\%%F" (
            set /a COUNT+=1
            echo       [OK] %%F
        ) else (
            set /a FAILED+=1
            echo       [SKIP] %%F
        )
    )

    for /d %%D in ("%TEMP%\*") do (
        rd /s /q "%%D" >nul 2>&1
        if not exist "%%D" (
            echo       [OK] папка %%~nxD
        ) else (
            echo       [SKIP] папка %%~nxD
        )
    )
)

echo.

:: =========================================================
:: CS2 SHADERS
:: =========================================================

echo [4/4] Удаление shader-файлов CS2:
echo.

set "CS2CORE=C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\core"

if not exist "%CS2CORE%" (
    echo       [ERROR] Папка CS2 не найдена!
    set /a FAILED+=1
) else (

    call :DeleteCS2File "shaders_pc_000.vpk"
    call :DeleteCS2File "shaders_pc_dir.vpk"
    call :DeleteCS2File "shaders_vulkan_000.vpk"
    call :DeleteCS2File "shaders_vulkan_dir.vpk"

)

echo.
echo ==========================================
echo                 РЕЗУЛЬТАТ
echo ==========================================
echo.
echo       Удалено:       !COUNT!
echo       Не удалено:   !FAILED!
echo.
echo ==========================================
echo.
echo Очистка завершена.
echo.

pause
exit /b


:DeleteCS2File

if exist "%CS2CORE%\%~1" (
    del /f /q "%CS2CORE%\%~1" >nul 2>&1

    if not exist "%CS2CORE%\%~1" (
        set /a COUNT+=1
        echo       [OK] %~1
    ) else (
        set /a FAILED+=1
        echo       [SKIP] %~1 ^(файл занят^)
    )
) else (
    echo       [INFO] %~1 отсутствует
)

exit /b