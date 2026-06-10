# 快速上手

## 安装

```bash
# Linux / macOS
curl -sSL https://raw.githubusercontent.com/LAN813-git/superpowersplus/main/install.sh | bash

# Windows (PowerShell)
irm https://raw.githubusercontent.com/LAN813-git/superpowersplus/main/install.ps1 | iex
```

## 验证

```bash
ls ~/.claude/skills/fused/
# 应看到 23 个 .md 文件 + 2 个目录（模板和脚本）
```

## 第一次使用：新功能开发

```bash
claude

> 给项目添加用户认证
```

代理会自动：

1. **创建规划文件** — `task_plan.md` 拆解阶段，`progress.md` 记录日志
2. **探索代码库** — 先看现有架构，不盲目提问
3. **设计方案** — 问你用 JWT 还是 Session，分段确认
4. **TDD 实现** — 先写失败测试，再写代码
5. **双轴审查** — Standards 和 Spec 并行检查
6. **验证交付** — 跑测试确认通过

全程自动，你只需要回答设计问题和确认方案。

## 第二次使用：会话恢复

关掉终端，重新打开：

```bash
claude

> 继续上次的工作
```

代理会：
1. 检测到 `task_plan.md` 存在
2. 读取规划文件恢复上下文
3. 运行 `session-catchup.py` 检查未同步的变更
4. 从上次停下的地方继续

这就是 Planning with Files 的价值：上下文丢失 ≠ 进度丢失。

## 常见场景

### Bug 调试

```
> 登录接口返回 500
```

代理自动触发 `diagnose`：先建反馈循环（复现 → 最小化 → 假设），不猜原因。

### 代码审查

```
> 审查 main 分支的变更
```

代理触发 `review`：两个 subagent 并行，一个查代码质量，一个查需求符合度。

### 中文文档优化

```
> 帮我把这份技术文档去一下 AI 味
```

代理触发 `humanizer-zh`：扫描 24 种模式，重写问题片段，给出 50 分制评分。

### 复杂项目规划

```
> 帮我规划一个微服务架构迁移
```

代理触发 `planning-with-files-zh`：创建 `task_plan.md` 拆解阶段，`findings.md` 记录调研，`progress.md` 跟踪进度。

## 技能路由速查

| 你说 | 触发技能 |
|------|---------|
| "我想做一个 XXX" | `brainstorming` |
| "帮我规划这个项目" | `planning-with-files-zh` |
| "这个 bug 怎么回事" | `diagnose` |
| "审查这段代码" | `review` |
| "去一下 AI 味" | `humanizer-zh` |
| "帮我写篇文章" | `writing-pipeline` |
| "提交一个 issue" | `qa-triage` |
| "压缩对话，准备交接" | `handoff` |

## 下一步

- [完整体系文档](system.md) — 七大插件详解
- [技能路由表](skill-routing.md) — 意图→技能映射
