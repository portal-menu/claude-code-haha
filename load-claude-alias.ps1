# Open Claude Code 中文汉化版 快速启动命令
# 使用方法：在任何目录输入 claude-haha 即可启动

function Start-ClaudeHaha {
    $PROJECT_DIR = "E:\Program Files\claude-code-haha"
    $BUN_PATH = "C:\Users\Administrator\.bun\bin\bun.exe"
    
    Write-Host "🚀 启动 Open Claude Code 中文汉化版..." -ForegroundColor Green
    Set-Location $PROJECT_DIR
    & $BUN_PATH --env-file="$PROJECT_DIR\.env" "$PROJECT_DIR\src\entrypoints\cli.tsx" @args
}

# 设置别名
Set-Alias -Name claude-haha -Value Start-ClaudeHaha -Force
Set-Alias -Name claude -Value Start-ClaudeHaha -Force

Write-Host "✅ Open Claude Code 中文汉化版 快捷命令已加载！" -ForegroundColor Cyan
Write-Host "   使用方法：" -NoNewline
Write-Host "claude-haha" -ForegroundColor Yellow -NoNewline
Write-Host " 或 " -NoNewline
Write-Host "claude" -ForegroundColor Yellow
Write-Host "   在项目目录中也可使用：" -NoNewline
Write-Host ".\start.ps1" -ForegroundColor Yellow
