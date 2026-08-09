@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
cd /d "%~dp0"

rem ============================================================
rem  Magister Modmod 改造仓库 —— 初始化 / 提交
rem  用法：
rem    双击                     -> 交互式，列出改动后问你要不要提交
rem    git-init.bat "改造 23：xxx"  -> 直接用这条信息提交，不再询问
rem  跟踪范围见同目录 .gitignore（XML / Python / ini / 主 DLL）
rem ============================================================

where git >nul 2>nul
if errorlevel 1 (
    echo [x] 找不到 git，请先安装 Git for Windows。
    pause
    exit /b 1
)

if not exist ".git" (
    echo [init] 新建仓库
    git init -q
    git config core.autocrlf false
    git config core.quotepath false
    set "MSG=baseline: Magister Modmod 游戏目录配置"
) else (
    set "MSG="
)

git add -A

git diff --cached --quiet
if not errorlevel 1 (
    echo 没有任何改动，无需提交。
    if "%~1"=="" pause
    exit /b 0
)

echo.
echo ---------------- 本次改动 ----------------
git diff --cached --stat
echo ------------------------------------------
echo.

if not "%~1"=="" set "MSG=%~1"

if "!MSG!"=="" (
    set /p MSG=提交信息（直接回车用默认）： 
)
if "!MSG!"=="" (
    for /f "tokens=1-3 delims=/- " %%a in ("%date%") do set "D=%%a%%b%%c"
    set "MSG=chore: 游戏目录配置同步 !D!"
)

if "%~1"=="" (
    set /p YN=确认提交？(Y/N) 
    if /i not "!YN!"=="Y" (
        echo 已取消，改动仍留在暂存区。
        pause
        exit /b 0
    )
)

git commit -q -m "!MSG!"
echo.
echo 已提交：!MSG!
git log --oneline -1
if "%~1"=="" pause
exit /b 0
