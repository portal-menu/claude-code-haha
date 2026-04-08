# Open Claude Code 中文汉化版 启动脚本 (Windows PowerShell)
# 使用方法：.\start.ps1 或 bun --env-file=.env ./src/entrypoints/cli.tsx

$BUN_PATH = "C:\Users\Administrator\.bun\bin\bun.exe"
$ENV_FILE = ".env"

# 检查 .env 文件是否存在
if (-not (Test-Path $ENV_FILE)) {
    Write-Host "错误：找不到 .env 文件" -ForegroundColor Red
    Write-Host "请先运行：cp .env.example .env 并配置你的 API Key" -ForegroundColor Yellow
    exit 1
}

# 检查是否包含有效的 API Token
$envContent = Get-Content $ENV_FILE -Raw
if ($envContent -match "ANTHROPIC_AUTH_TOKEN=your_token_here") {
    Write-Host "警告：你还没有配置 API Token" -ForegroundColor Yellow
    Write-Host "请编辑 .env 文件，将 ANTHROPIC_AUTH_TOKEN 替换为你的实际 Token" -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "启动 Open Claude Code 中文汉化版..." -ForegroundColor Green
Write-Host ""

# 启动完整 TUI
& $BUN_PATH --env-file=$ENV_FILE ./src/entrypoints/cli.tsx @args
