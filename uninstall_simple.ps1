# Open Claude Code 中文汉化版 完全卸载命令
# 复制并以管理员身份运行以下命令

Write-Host "========================================" -ForegroundColor Yellow
Write-Host "Open Claude Code 中文汉化版 完全卸载" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""

$claudeDir = "$env:USERPROFILE\.claude"

if (Test-Path $claudeDir) {
    Write-Host "正在删除: $claudeDir" -ForegroundColor Yellow
    Remove-Item -Path $claudeDir -Recurse -Force
    Write-Host "✓ Open Claude Code 中文汉化版 已成功卸载！" -ForegroundColor Green
} else {
    Write-Host "未找到 Open Claude Code 中文汉化版 目录" -ForegroundColor Yellow
}
