# 🎉 Open Claude Code 中文汉化版 - 安装完成！

## ✅ 安装状态

- [x] Bun 运行时已安装 (v1.3.11)
- [x] 项目依赖已安装 (365 个包)
- [x] 环境变量文件已创建 (.env)
- [x] 启动脚本已创建

## 📝 下一步操作

### 1️⃣ 配置 API Token（必填）

编辑 `.env` 文件，将 `ANTHROPIC_AUTH_TOKEN` 替换为你的实际 Token：

```bash
# Windows: 用记事本打开
notepad .env

# 或使用 VS Code
code .env
```

**当前配置说明：**
- **API 端点**: MiniMax (https://api.minimaxi.com/anthropic)
- **默认模型**: MiniMax-M2.7-highspeed
- 如果你使用其他 Anthropic 兼容 API，请修改对应配置

### 2️⃣ 启动方式

#### 方式一：完整 TUI 界面（推荐）

```powershell
# 使用启动脚本
.\start.ps1

# 或直接运行
C:\Users\Administrator\.bun\bin\bun.exe --env-file=.env ./src/entrypoints/cli.tsx
```

#### 方式二：无头模式（单次问答）

```powershell
# 使用测试脚本
.\test.ps1 "你的问题"

# 或直接运行
C:\Users\Administrator\.bun\bin\bun.exe --env-file=.env ./src/entrypoints/cli.tsx -p "你的问题"
```

#### 方式三：使用 npm script

```powershell
bun run claude-haha
```

### 3️⃣ 查看帮助

```powershell
C:\Users\Administrator\.bun\bin\bun.exe --env-file=.env ./src/entrypoints/cli.tsx --help
```

## 🛠️ 常用命令

### 降级模式（如果 TUI 出现问题）
```powershell
$env:CLAUDE_CODE_FORCE_RECOVERY_CLI=1
C:\Users\Administrator\.bun\bin\bun.exe --env-file=.env ./src/entrypoints/cli.tsx
```

### 更新 Bun
```powershell
bun upgrade
```

### 重新安装依赖
```powershell
bun install
```

## 📚 项目结构

```
e:\Program Files\claude-code-haha\
├── bin/claude-haha          # Unix/Linux/Mac 启动脚本
├── start.ps1                # Windows PowerShell 启动脚本
├── test.ps1                 # Windows 测试脚本
├── .env                     # 环境变量配置（需要填入 Token）
├── .env.example             # 配置模板
└── src/
    ├── entrypoints/cli.tsx  # 主入口
    ├── main.tsx             # TUI 主逻辑
    ├── components/          # UI 组件
    ├── tools/               # Agent 工具
    └── services/            # 服务层
```

## 🔧 故障排除

### 问题 1：找不到 bun 命令
**解决方案**：使用完整路径
```powershell
C:\Users\Administrator\.bun\bin\bun.exe
```

### 问题 2：API 认证失败
**解决方案**：
1. 检查 `.env` 文件中的 `ANTHROPIC_AUTH_TOKEN` 是否正确
2. 确认 API 端点 URL 正确
3. 检查网络连接

### 问题 3：TUI 显示异常
**解决方案**：
1. 尝试降级模式：`$env:CLAUDE_CODE_FORCE_RECOVERY_CLI=1`
2. 检查终端是否支持 UTF-8
3. 重启终端刷新环境变量

## 📖 更多资源

- [README.md](./README.md) - 完整使用说明
- [README.en.md](./README.en.md) - English documentation
- [docs/](./docs/) - 架构文档

## ⚠️ 重要提示

1. **不要提交 `.env` 文件到 Git**（已添加到 `.gitignore`）
2. **定期更新 Bun** 以获得最佳性能
3. **Windows 用户**建议使用 PowerShell 脚本而非 bash 脚本

---

**祝你使用愉快！** 🚀

如有问题，请查看 README.md 或访问项目文档。
