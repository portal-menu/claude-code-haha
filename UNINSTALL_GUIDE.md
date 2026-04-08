# Claude Code 完全卸载指南

## 方法一：使用卸载脚本（推荐）

### 步骤 1：以管理员身份打开 PowerShell
- 按 `Win + X`
- 选择 "Windows PowerShell (管理员)" 或 "终端 (管理员)"

### 步骤 2：运行卸载脚本
```powershell
# 切换到项目目录
cd "e:\Program Files\claude-code-haha"

# 运行卸载脚本
.\uninstall.ps1
```

## 方法二：手动执行命令

### 步骤 1：以管理员身份打开 PowerShell

### 步骤 2：执行以下命令
```powershell
# 删除整个 .claude 目录（包含所有配置、会话、插件等）
Remove-Item -Path "$env:USERPROFILE\.claude" -Recurse -Force
```

## 方法三：交互式命令

### 步骤 1：以管理员身份打开 PowerShell

### 步骤 2：逐条执行
```powershell
# 1. 删除会话记录
Remove-Item -Path "$env:USERPROFILE\.claude\sessions" -Recurse -Force

# 2. 删除历史记录
Remove-Item -Path "$env:USERPROFILE\.claude\history.jsonl" -Force

# 3. 删除备份
Remove-Item -Path "$env:USERPROFILE\.claude\backups" -Recurse -Force

# 4. 删除项目数据
Remove-Item -Path "$env:USERPROFILE\.claude\projects" -Recurse -Force

# 5. 删除插件数据
Remove-Item -Path "$env:USERPROFILE\.claude\plugins" -Recurse -Force

# 6. 删除其他配置文件
Remove-Item -Path "$env:USERPROFILE\.claude" -Recurse -Force
```

## 验证卸载

执行完上述命令后，可以验证是否已完全卸载：

```powershell
# 检查 .claude 目录是否存在
Test-Path "$env:USERPROFILE\.claude"
# 应该返回 False
```

## 注意事项

1. **此操作不可逆**：删除后无法恢复，请确保你不需要保留任何会话或配置数据

2. **需要管理员权限**：必须以管理员身份运行 PowerShell

3. **不会删除 .env 文件**：卸载脚本只删除 `~\.claude` 目录，不会影响项目目录

4. **重新安装**：如需重新安装，只需重新运行项目即可

## 卸载后

卸载完成后，你可以：
- 删除项目目录（如果不再需要）
- 或保留项目目录，需要时重新运行

---

**提示**：如果你只想清除数据但保留项目，可以只删除 `~\.claude` 目录，项目本身不受影响。
