# 🚀 Open Claude Code 中文汉化版 - 快速启动指南

## 📍 项目位置
```
E:\Program Files\claude-code-haha
```

---

## ⚡ 30 秒快速启动

### **步骤 1：配置 API Token（1 分钟）**

当前 `.env` 文件已打开，找到这一行：
```
ANTHROPIC_AUTH_TOKEN=your_token_here
```

**替换为你的实际 Token**，例如：
```
ANTHROPIC_AUTH_TOKEN=sk-abc123456789xyz
```

保存文件（Ctrl+S）

### **步骤 2：启动项目（直接运行）**

在 PowerShell 中输入以下任一命令：

#### **方式 1：完整 TUI 界面（推荐）**
```powershell
C:\Users\Administrator\.bun\bin\bun.exe --env-file=.env ./src/entrypoints/cli.tsx
```

#### **方式 2：使用启动脚本**
```powershell
.\start.ps1
```

#### **方式 3：无头模式（单次问答）**
```powershell
C:\Users\Administrator\.bun\bin\bun.exe --env-file=.env ./src/entrypoints/cli.tsx -p "你好"
```

或：
```powershell
.\test.ps1 "你好"
```

---

## 💡 常用场景

### **场景 1：第一次使用（测试连接）**
```powershell
# 用简单问题测试 API 是否正常工作
C:\Users\Administrator\.bun\bin\bun.exe --env-file=.env ./src/entrypoints/cli.tsx -p "1+1 等于几？"
```

### **场景 2：开始正式工作**
```powershell
# 启动完整交互界面
C:\Users\Administrator\.bun\bin\bun.exe --env-file=.env ./src/entrypoints/cli.tsx
```

然后在界面中：
- 直接输入问题，按 Enter 发送
- 按 `Ctrl+C` 退出

### **场景 3：查看帮助**
```powershell
C:\Users\Administrator\.bun\bin\bun.exe --env-file=.env ./src/entrypoints/cli.tsx --help
```

### **场景 4：降级模式（如果 TUI 显示异常）**
```powershell
$env:CLAUDE_CODE_FORCE_RECOVERY_CLI=1
C:\Users\Administrator\.bun\bin\bun.exe --env-file=.env ./src/entrypoints/cli.tsx
```

---

## 🔑 键盘快捷键（TUI 模式中）

| 按键 | 功能 |
|------|------|
| `Enter` | 发送消息 |
| `Ctrl+C` | 退出程序 |
| `Ctrl+L` | 清屏 |
| `↑/↓` | 浏览历史消息 |
| `/` | 搜索命令 |
| `?` | 查看帮助 |

---

## ⚠️ 常见问题

### **Q1: 提示 "找不到 bun 命令"**
**A:** 使用绝对路径：
```powershell
C:\Users\Administrator\.bun\bin\bun.exe
```

### **Q2: API 认证失败**
**A:** 
1. 检查 `.env` 中的 `ANTHROPIC_AUTH_TOKEN` 是否正确
2. 确认没有多余的空格或引号
3. 重新获取你的 API Token

### **Q3: 网络连接超时**
**A:**
1. 检查网络连接
2. 确认 API 端点 URL 正确（当前是 MiniMax）
3. 如果使用代理，设置环境变量：
   ```powershell
   $env:HTTPS_PROXY="http://proxy:port"
   ```

### **Q4: TUI 显示乱码**
**A:**
1. 尝试降级模式：`$env:CLAUDE_CODE_FORCE_RECOVERY_CLI=1`
2. 确保终端支持 UTF-8
3. 使用 Windows Terminal 代替传统 cmd

---

## 📚 更多资源

- **详细文档**: [`INSTALL_GUIDE.md`](./INSTALL_GUIDE.md)
- **使用说明**: [`README.md`](./README.md)
- **架构说明**: [`docs/`](./docs/)

---

## 🎯 现在就试试！

1. ✅ 保存 `.env` 文件（填入 Token）
2. ✅ 运行启动命令
3. ✅ 开始和 Claude 对话！

**示例对话：**
```
> 你好，请帮我写一个 Python 的 Hello World 程序

好的！这是一个简单的 Python Hello World 程序：

```python
print("Hello, World!")
```

要运行这个程序，你可以：
1. 保存为 hello.py
2. 运行 python hello.py
```

祝你使用愉快！🎉
