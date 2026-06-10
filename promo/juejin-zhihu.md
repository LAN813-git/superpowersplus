# 掘金/知乎 文章

# Claude Code 七大核心插件统一安装：Super Powers Plus 完整实践

## 前言

用过 Claude Code 的人都有一个感受：它很聪明，但不守规矩。

你说"加个用户认证"，它直接开始写代码，不问你用 JWT 还是 Session。你说"修个 bug"，它改完就说"已修复"，不跑测试不验证。你说"审查代码"，它只看风格，不看需求。上下文一满，它把之前聊的全忘了。

这些问题，已经有人分别解决了——obra/superpowers 解决纪律问题，mattpocock/skills 解决工程问题，planning-with-files 解决上下文丢失问题，humanizer-zh 解决中文输出生硬问题。

问题是：四个项目都要手动配置，技能之间有重叠，新手不知道怎么组合。

所以我把它们融合了。

**[Super Powers Plus](https://github.com/LAN813-git/superpowersplus)** — 七大核心插件，23 个技能，一条命令安装。已安装过 superpowers 或 mattpocock 的用户，安装器自动检测、备份、替换。

---

## 安装

```bash
# Linux / macOS
curl -sSL https://raw.githubusercontent.com/LAN813-git/superpowersplus/main/install.sh | bash

# Windows (PowerShell)
irm https://raw.githubusercontent.com/LAN813-git/superpowersplus/main/install.ps1 | iex
```

如果你已经装过 obra/superpowers 或 mattpocock/skills，安装器会：
1. 扫描 `~/.claude/skills/` 和 `~/.agents/skills/` 下的冲突文件
2. 备份到 `~/.claude/skills-backup-<时间戳>/`
3. 删除冲突原文件
4. 部署增强版到 `~/.claude/skills/fused/`

回滚：`cp ~/.claude/skills-backup-<时间戳>/* ~/.claude/skills/`

---

## 七大核心插件

| # | 插件 | 解决的问题 |
|---|------|-----------|
| 1 | Super Powers + Mattpocock | 代理直接写代码，不问需求，不写测试，不验证 |
| 2 | Planning with Files | 上下文爆满后遗忘，会话重启后丢失进度 |
| 3 | PDF | 无法读取技术文档、API 白皮书 |
| 4 | Frontend Design | 程序员审美，UI 粗糙 |
| 5 | Code Review | 代码带着漏洞上线 |
| 6 | Skill Creator | 重复工作流无法自动化 |
| 7 | Humanizer zh | 中文输出像翻译机 |

---

## 五阶段工作流

Super Powers Plus 的核心不是 23 个技能，而是它们组成的五阶段工作流：

### 1. Planning with Files（规划）

**触发**：任何复杂任务（≥3 步）

**行为**：
- 在项目根目录创建 `task_plan.md`、`findings.md`、`progress.md`
- 这三个文件是代理的"磁盘工作记忆"
- 通过 PreToolUse 钩子自动注入上下文，每次工具调用前刷新
- 会话重启、`/clear`、上下文压缩都不会丢失

**价值**：代理再也不会忘记自己在做什么。

### 2. Brainstorming（设计）

**触发**：你说"我想做一个 XXX"

**行为**：
- 先探索代码库，看有没有现成方案
- 问你设计问题，分段确认
- HARD-GATE：你不同意，就不写代码

**Before**：Claude 直接开始写，写到一半发现方向错了
**After**：先对齐需求，再动手

### 3. TDD（实现）

**触发**：开始编码

**行为**：
- RED：先写一个会失败的测试
- GREEN：写最少的代码让它通过
- REFACTOR：清理代码
- Iron Law：没有失败的测试，就不写生产代码

**Before**：Claude 写了一堆代码，不知道对不对
**After**：每个功能都有测试覆盖

### 4. Review（审查）

**触发**：完成一个任务后

**行为**：
- 双轴审查：Standards（代码质量）和 Spec（需求符合度）并行运行
- 两个独立 subagent 各审各的，互不干扰
- 按严重程度报告问题

### 5. Delivery（交付）

**触发**：声称完成时

**行为**：
- 重新跑测试，收集新鲜验证证据
- 中文文档过 humanizer-zh 去 AI 痕迹
- 50 分制质量评分：直接性、节奏、信任度、真实性、精炼度

---

## Humanizer zh：去 AI 痕迹

这是很多人忽略的一个插件。AI 生成的中文有 24 种可识别的模式：

**内容模式**：夸大的象征意义、宣传性语言、模糊归因、提纲式的"挑战与展望"
**语言语法**：AI 词汇（此外、至关重要、格局）、系动词回避、否定式排比、三段式法则
**风格模式**：破折号过度、粗体过度、表情符号
**交流模式**：协作痕迹（"希望对您有帮助"）、知识截止免责声明、谄媚语气
**填充词**：填充短语、过度限定、通用积极结论

改写前（AI 味）：
> 新的软件更新作为公司致力于创新的证明。此外，它提供了无缝、直观和强大的用户体验——确保用户能够高效地完成目标。

改写后（人味）：
> 软件更新添加了批处理、键盘快捷键和离线模式。测试用户反馈任务完成速度更快。

质量评分 50 分制，低于 35 分需要重新修订。

---

## Planning with Files：磁盘工作记忆

上下文窗口是内存（易失，有限）。文件系统是磁盘（持久，无限）。

代理在项目根目录维护三个文件：
- `task_plan.md` — 阶段、进度、决策
- `findings.md` — 研究发现
- `progress.md` — 会话日志

这些文件通过钩子自动注入上下文。即使你关掉终端、执行 `/clear`、上下文被压缩，进度都不会丢。

```
> 继续上次的工作
```

代理读取 `task_plan.md`，从上次停下的地方继续。

---

## 与 obra/superpowers 的关系

Super Powers Plus 不是替代 obra/superpowers，而是把它作为七大插件之一整合进来。

| 维度 | obra/superpowers | superpowersplus |
|------|------------------|-----------------|
| 范围 | 仅纪律框架 | 七大插件全覆盖 |
| 技能数 | ~10 | 23 |
| 上下文管理 | 无 | Planning with Files |
| 中文优化 | 无 | Humanizer zh |
| 安装 | 手动复制 | 一条命令 + 自动升级 |
| 升级 | 无 | 自动检测冲突、备份、替换 |

---

## 最后

这个项目的核心理念：

> 纪律不是建议，是规则。上下文不是内存，是磁盘。中文不是翻译，是写作。

欢迎 star、issue、PR：

**https://github.com/LAN813-git/superpowersplus**
