# Super Powers Plus 完整体系文档

> 七大核心插件统一体，23 个技能，5 阶段工作流。

## 七大核心插件

Super Powers Plus 不是某个单一项目的分支。它是七个独立插件的统一体，每个插件解决 AI 编码代理的一个核心问题。

| # | 插件 | 解决的问题 |
|---|------|-----------|
| 1 | Super Powers + Mattpocock | 代理直接写代码，不问需求，不写测试，不验证 |
| 2 | Planning with Files | 上下文爆满后遗忘，会话重启后丢失进度 |
| 3 | PDF | 无法读取技术文档、API 白皮书、带图表的论文 |
| 4 | Frontend Design | 程序员审美，UI 粗糙，无暗黑模式，无响应式 |
| 5 | Code Review | 代码带着死循环、OWASP 漏洞、需求偏离上线 |
| 6 | Skill Creator | 重复工作流无法自动化，代理能力不可扩展 |
| 7 | Humanizer zh | 中文输出像翻译机，生硬、套路化、一看就是 AI |

## 核心理念

### Iron Law（铁律）

每个核心技能都有不可违反的规则。代理不能通过"合理化"跳过任何一步。

示例（TDD 技能）：
- 没有失败的测试 → 不能写生产代码
- 测试通过了 → 必须提交
- 重构时发现没有覆盖 → 补测试再重构

### 反合理化表

每个技能内置一张表，列出代理最常见的 3-5 个跳步借口，并给出精确反驳。

示例（Brainstorming 技能）：
- 借口："需求很清楚，直接写代码更快" → 反驳：你上次返工就是因为没确认边界条件
- 借口："探索代码库太慢了" → 反驳：你上周写了一个已存在的工具函数

### 磁盘工作记忆

上下文窗口是内存（易失，有限）。文件系统是磁盘（持久，无限）。

Planning with Files 技能将三个文件放在项目根目录：
- `task_plan.md` — 阶段、进度、决策
- `findings.md` — 研究发现
- `progress.md` — 会话日志

这些文件通过 PreToolUse 钩子自动注入上下文，每次工具调用前刷新。会话重启、`/clear`、上下文压缩都不会丢失。

### 人类优先写作

AI 生成的文本有 24 种可识别的模式（夸大的象征意义、宣传性语言、三段式法则、破折号过度使用等）。Humanizer zh 技能检测并修复这些模式，用 50 分制质量评分验证效果。

## 五阶段工作流

```
规划 → 设计 → 实现 → 审查 → 交付
```

### 阶段 1：规划

技能：`planning-with-files-zh`

- 检查是否存在 `task_plan.md`，有则读取恢复上下文
- 无则创建规划文件，拆解任务为阶段
- 每个发现写入 `findings.md`，每个操作记录到 `progress.md`
- 两步操作规则：每执行 2 次查看/搜索操作后，立即保存关键发现

### 阶段 2：设计

技能：`brainstorming` + `prototype`

- HARD-GATE：用户批准设计前禁止编码
- 探索代码库优先于提问用户
- 分段展示设计方案，逐段确认
- 可选：用 prototype 验证关键设计决策

### 阶段 3：实现

技能：`tdd` + `diagnose` + `writing-plans`

- writing-plans：零占位符精确执行计划，每个任务有完整文件路径和代码
- tdd：Iron Law — 先写失败测试，再写最少代码通过
- diagnose：调试时先建反馈循环，不猜原因

### 阶段 4：审查

技能：`review` + `qa-triage`

- 双轴并行审查：Standards（代码质量）和 Spec（需求符合度）
- 两个独立 subagent 各审各的，互不干扰
- qa-triage：交互式 QA → 自动分诊 → 状态机流转

### 阶段 5：交付

技能：`verification-before-completion` + `finishing-a-development-branch` + `humanizer-zh`

- 无新鲜验证证据不声称完成
- 分支收尾：merge/PR/keep/discard
- 中文文档交付前过 humanizer 去 AI 痕迹

## 技能完整列表（23 个）

### Plugin 1: Super Powers + Mattpocock（19 个）

**融合新建（6 个）**

| 技能 | 融合来源 | 核心增强 |
|------|---------|---------|
| `diagnose` | mp 反馈循环 + sp Iron Law | 先建循环再调试 + 反合理化表 + 3 次升级阈值 |
| `tdd` | sp Iron Law + mp 垂直切片 | 删除重来纪律 + 反水平切片 + tracer bullet |
| `review` | mp 双轴分离 + sp 隔离审查 | Standards vs Spec 并行 + 无上下文审查 + 严重性分级 |
| `brainstorming` | sp HARD-GATE + mp 代码库优先 | 先设计后编码 + 探索优先于提问 + 轻量化流程 |
| `writing-pipeline` | mp fragments+shape+beats | 三阶段写作流水线：素材挖掘→结构塑形→节拍叙事 |
| `qa-triage` | mp qa+triage | 交互式 QA→自动分诊→状态机流转 |

**纯引用（13 个）**

来源 superpowers：`verification-before-completion` `writing-plans` `dispatching-parallel-agents` `finishing-a-development-branch` `using-git-worktrees`

来源 mattpocock：`grill-with-docs` `to-issues` `to-prd` `prototype` `caveman` `handoff` `teach` `zoom-out` `improve-codebase-architecture` `git-guardrails`

### Plugin 2: Planning with Files（1 个）

| 技能 | 来源 | 核心功能 |
|------|------|---------|
| `planning-with-files-zh` | OthmanAdi/planning-with-files | 物理规划文件作为磁盘工作记忆，支持 /clear 后自动恢复 |

配套资源：
- `planning-with-files-zh-templates/` — task_plan.md、findings.md、progress.md 模板
- `planning-with-files-zh-scripts/` — 会话恢复、完成检查、初始化脚本

### Plugin 7: Humanizer zh（1 个）

| 技能 | 来源 | 核心功能 |
|------|------|---------|
| `humanizer-zh` | op7418/Humanizer-zh | 24 种 AI 写作模式识别 + 50 分制质量评分 |

五大类模式：
1. 内容模式（夸大意义、宣传性语言、模糊归因）
2. 语言语法（AI 词汇、系动词回避、否定式排比）
3. 风格模式（破折号过度、粗体过度、表情符号）
4. 交流模式（协作痕迹、知识截止免责声明、谄媚语气）
5. 填充词（填充短语、过度限定、通用积极结论）

### Plugins 3-6: 内置（无需打包）

- PDF — Anthropic 内置 `pdf` skill
- Frontend Design — Anthropic 内置 `frontend-design` skill
- Code Review — 已包含在 `review` 技能中
- Skill Creator — Anthropic 内置 `write-a-skill` skill
