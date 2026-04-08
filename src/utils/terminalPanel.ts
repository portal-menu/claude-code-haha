/**
 * Built-in terminal panel toggled with Meta+J.
 *
 * Uses tmux for shell persistence: a separate tmux server with a per-instance
 * socket (e.g., "claude-panel-a1b2c3d4") holds the shell session. Each Claude
 * Code instance gets its own isolated terminal panel that persists within the
 * session but is destroyed when the instance exits.
 *
 * Meta+J 在 tmux 中绑定为 detach-client，因此按它会返回到
 * Open Claude Code 中文汉化版，而 shell 继续运行。下次切换会重新附加到同一会话。
 *
 * 当 tmux 不可用时，通过 spawnSync 回退到非持久性 shell。
 *
 * 使用与外部编辑器（promptEditor.ts）相同的 suspend-Ink 模式。
 */

import { spawn, spawnSync } from 'child_process'
import { getSessionId } from '../bootstrap/state.js'
import instances from '../ink/instances.js'
import { registerCleanup } from './cleanupRegistry.js'
import { pwd } from './cwd.js'
import { logForDebugging } from './debug.js'

const TMUX_SESSION = 'panel'

/**
 * 获取终端面板的 tmux 套接字名称。
 * 每个 Open Claude Code 中文汉化版 实例使用唯一的套接字（基于会话 ID），
 * 以便每个实例都有其自己的隔离终端面板。
 */
export function getTerminalPanelSocket(): string {
  // Use first 8 chars of session UUID for uniqueness while keeping name short
  const sessionId = getSessionId()
  return `claude-panel-${sessionId.slice(0, 8)}`
}

let instance: TerminalPanel | undefined

/**
 * Return the singleton TerminalPanel, creating it lazily on first use.
 */
export function getTerminalPanel(): TerminalPanel {
  if (!instance) {
    instance = new TerminalPanel()
  }
  return instance
}

class TerminalPanel {
  private hasTmux: boolean | undefined
  private cleanupRegistered = false

  // ── public API ────────────────────────────────────────────────────

  toggle(): void {
    this.showShell()
  }

  // ── tmux helpers ──────────────────────────────────────────────────

  private checkTmux(): boolean {
    if (this.hasTmux !== undefined) return this.hasTmux
    const result = spawnSync('tmux', ['-V'], { encoding: 'utf-8' })
    this.hasTmux = result.status === 0
    if (!this.hasTmux) {
      logForDebugging(
        'Terminal panel: tmux not found, falling back to non-persistent shell',
      )
    }
    return this.hasTmux
  }

  private hasSession(): boolean {
    const result = spawnSync(
      'tmux',
      ['-L', getTerminalPanelSocket(), 'has-session', '-t', TMUX_SESSION],
      { encoding: 'utf-8' },
    )
    return result.status === 0
  }

  private createSession(): boolean {
    const shell = process.env.SHELL || '/bin/bash'
    const cwd = pwd()
    const socket = getTerminalPanelSocket()

    const result = spawnSync(
      'tmux',
      [
        '-L',
        socket,
        'new-session',
        '-d',
        '-s',
        TMUX_SESSION,
        '-c',
        cwd,
        shell,
        '-l',
      ],
      { encoding: 'utf-8' },
    )

    if (result.status !== 0) {
      logForDebugging(
        `Terminal panel: failed to create tmux session: ${result.stderr}`,
      )
      return false
    }

    // 绑定 Meta+J（从终端内部切换回 Open Claude Code 中文汉化版）
    // 并配置状态栏提示。用 ';' 链接以将 5 个 spawnSync 调用合并为 1。
    // biome-ignore format: one tmux command per line
    spawnSync('tmux', [
      '-L', socket,
      'bind-key', '-n', 'M-j', 'detach-client', ';',
      'set-option', '-g', 'status-style', 'bg=default', ';',
      'set-option', '-g', 'status-left', '', ';',
      'set-option', '-g', 'status-right', ' Alt+J to return to Claude ', ';',
      'set-option', '-g', 'status-right-style', 'fg=brightblack',
    ])

    if (!this.cleanupRegistered) {
      this.cleanupRegistered = true
      registerCleanup(async () => {
        // Detached async spawn — spawnSync here would block the event loop
        // and serialize the entire cleanup Promise.all in gracefulShutdown.
        // .on('error') swallows ENOENT if tmux disappears between session
        // creation and cleanup — prevents spurious uncaughtException noise.
        spawn('tmux', ['-L', socket, 'kill-server'], {
          detached: true,
          stdio: 'ignore',
        })
          .on('error', () => {})
          .unref()
      })
    }

    return true
  }

  private attachSession(): void {
    spawnSync(
      'tmux',
      ['-L', getTerminalPanelSocket(), 'attach-session', '-t', TMUX_SESSION],
      { stdio: 'inherit' },
    )
  }

  // ── show shell ────────────────────────────────────────────────────

  private showShell(): void {
    const inkInstance = instances.get(process.stdout)
    if (!inkInstance) {
      logForDebugging('Terminal panel: no Ink instance found, aborting')
      return
    }

    inkInstance.enterAlternateScreen()
    try {
      if (this.checkTmux() && this.ensureSession()) {
        this.attachSession()
      } else {
        this.runShellDirect()
      }
    } finally {
      inkInstance.exitAlternateScreen()
    }
  }

  // ── helpers ───────────────────────────────────────────────────────

  /** Ensure a tmux session exists, creating one if needed. */
  private ensureSession(): boolean {
    if (this.hasSession()) return true
    return this.createSession()
  }

  /** Fallback when tmux is not available — runs a non-persistent shell. */
  private runShellDirect(): void {
    const shell = process.env.SHELL || '/bin/bash'
    const cwd = pwd()
    spawnSync(shell, ['-i', '-l'], {
      stdio: 'inherit',
      cwd,
      env: process.env,
    })
  }
}
