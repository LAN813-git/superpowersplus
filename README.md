# Super Powers Plus

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/LAN813-git/superpowersplus?style=social)](https://github.com/LAN813-git/superpowersplus)

> **Superpowers + Mattpocock skills 融合增强版。21 个技能，5 阶段工作流，一键安装。**

基于 [obra/superpowers](https://github.com/obra/superpowers) 和 [mattpocock/skills](https://github.com/mattpocock/skills) 融合而成，为 Claude Code 提供完整的工程化开发体系。

## 对比

| | 手动装 skill | obra/superpowers | **superpowersplus** |
|---|:---:|:---:|:---:|
| 技能数量 | 散装 | 仅 sp 系列 | **sp + mp 融合，21 个** |
| 融合技能 | 自己折腾 | 无 | **6 个深度融合** |
| 安装方式 | 手动复制 | 手动复制 | **一键安装** |
| 工作流设计 | 无 | 无 | **五阶段完整工作流** |

## 安装

```bash
# Linux / macOS
curl -sSL https://raw.githubusercontent.com/LAN813-git/superpowersplus/main/install.sh | bash

# Windows (PowerShell)
irm https://raw.githubusercontent.com/LAN813-git/superpowersplus/main/install.ps1 | iex
```

验证：

```bash
ls ~/.claude/skills/fused/
```

## 6 个融合技能

| 技能 | 干什么 | 场景 |
|------|--------|------|
| `diagnose` | 先建反馈循环再调试 | 报错/异常 |
| `tdd` | 先写测试再写代码 | 功能开发 |
| `review` | 双轴审查：规范 + 需求 | 代码审查 |
| `brainstorming` | HARD-GATE：先设计后编码 | 新功能/设计 |
| `writing-pipeline` | 三阶段写作流水线 | 写作/文章 |
| `qa-triage` | 交互式 QA→自动分诊 | QA/bug |

## 15 个引用技能

`verification-before-completion` `writing-plans` `dispatching-parallel-agents` `finishing-a-development-branch` `using-git-worktrees` `grill-with-docs` `to-issues` `to-prd` `prototype` `caveman` `handoff` `teach` `zoom-out` `improve-codebase-architecture` `git-guardrails`

## 五阶段工作流

```
设计 → 计划 → 实现 → 审查 → 交付
 ↓       ↓       ↓       ↓       ↓
brainstorm  plans   tdd    review  verify
```

## 使用

```bash
claude

> brainstorming 我想给项目添加用户认证
> diagnose 登录页面在某些情况下崩溃
> review main
> qa-triage
```

## 文档

- [完整体系文档](docs/system.md)
- [快速上手](docs/quickstart.md)
- [技能路由表](docs/skill-routing.md)
- [使用示例](examples/)

## 致谢

- [obra/superpowers](https://github.com/obra/superpowers) — Anthropic 内置技能体系
- [mattpocock/skills](https://github.com/mattpocock/skills) — 工程技能库

## License

[MIT](LICENSE)
