# Open Claude Code 中文汉化版 完全卸载脚本
# 以管理员身份运行此脚本以完全卸载 Open Claude Code 中文汉化版

Write-Host "========================================" -ForegroundColor Yellow
Write-Host "Open Claude Code 中文汉化版 完全卸载脚本" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""

# 获取用户主目录
$claudeDir = "$env:USERPROFILE\.claude"

Write-Host "正在检查 Open Claude Code 中文汉化版 安装..." -ForegroundColor Cyan

# 检查目录是否存在
if (Test-Path $claudeDir) {
    Write-Host "找到 Open Claude Code 中文汉化版 目录: $claudeDir" -ForegroundColor Green
    
    # 显示将要删除的内容
    Write-Host "`n将要删除的内容:" -ForegroundColor Yellow
    Write-Host "  - 会话记录 (sessions/)" -ForegroundColor White
    Write-Host "  - 历史记录 (history.jsonl)" -ForegroundColor White
    Write-Host "  - 备份文件 (backups/)" -ForegroundColor White
    Write-Host "  - 项目数据 (projects/)" -ForegroundColor White
    Write-Host "  - 插件数据 (plugins/)" -ForegroundColor White
    Write-Host "  - 配置文件 (settings.json, config.json 等)" -ForegroundColor White
    Write-Host ""
    
    # 确认删除
    $confirm = Read-Host "确定要完全卸载 Open Claude Code 中文汉化版 吗？(是/否)"
    
    if ($confirm -eq "是" -or $confirm -eq "y" -or $confirm -eq "yes") {
        Write-Host "`n正在删除 Open Claude Code 中文汉化版 数据..." -ForegroundColor Yellow
        
        try {
            # 删除整个 .claude 目录
            Remove-Item -Path $claudeDir -Recurse -Force
            Write-Host "✓ Open Claude Code 中文汉化版 已成功卸载！" -ForegroundColor Green
            Write-Host "  所有配置、会话和数据已删除。" -ForegroundColor White
        }
        catch {
            Write-Host "✗ 卸载失败: $($_.Exception.Message)" -ForegroundColor Red
            Write-Host "`n如果遇到权限问题，请以管理员身份运行 PowerShell，然后再次执行此脚本。" -ForegroundColor Yellow
        }
    }
    else {
        Write-Host "`n卸载已取消。" -ForegroundColor Cyan
    }
}
else {
    Write-Host "未找到 Open Claude Code 中文汉化版 目录 ($claudeDir)" -ForegroundColor Yellow
    Write-Host "可能 Open Claude Code 中文汉化版 尚未安装或已卸载。" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "卸载完成" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
