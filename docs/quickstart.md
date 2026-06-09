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
# 应看到 23 个 .md 文件
```

## 第一次使用

```bash
claude

> brainstorming 我想给项目添加用户认证
```

Claude 会先探索代码库，问你设计问题，然后呈现方案。

## 更多示例

- [新功能开发](../examples/new-feature.md)
- [Bug 调试](../examples/debug-bug.md)
- [代码审查](../examples/code-review.md)
