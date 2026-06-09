# Fused Skills Index

融合自 mattpocock/skills + superpowers，取各家之长。共 21 个技能（6 个融合新建 + 15 个纯引用）。

## 融合技能（6个，新建文件）

| 技能 | 来源融合 | 核心增强 |
|------|---------|---------|
| `diagnose.md` | mp 反馈循环 + sp Iron Law | 先建循环再调试 + 反合理化表 + 3次升级阈值 |
| `tdd.md` | sp Iron Law + mp 垂直切片 | 删除重来纪律 + 反水平切片 + tracer bullet |
| `review.md` | mp 双轴分离 + sp 隔离审查者 | Standards vs Spec 并行 + 无上下文审查 + 严重性分级 |
| `brainstorming.md` | sp HARD-GATE + mp 代码库优先 | 先设计后编码 + 探索优先于提问 + 轻量化流程 |
| `writing-pipeline.md` | mp fragments+shape+beats | 三阶段写作流水线：素材挖掘→结构塑形→节拍叙事 |
| `qa-triage.md` | mp qa+triage | 交互式 QA→自动分诊→状态机流转 |

## 纯引用技能（15个，symlink/复制）

| 技能 | 来源 | 用途 |
|------|------|------|
| `verification-before-completion.md` | sp | 完成前验证守门员 |
| `writing-plans.md` | sp | 零占位符精确执行计划 |
| `dispatching-parallel-agents.md` | sp | 并行 Agent 调度 |
| `finishing-a-development-branch.md` | sp | 分支收尾（merge/PR/keep/discard） |
| `using-git-worktrees.md` | sp | Git worktree 隔离工作区 |
| `grill-with-docs.md` | mp | 领域词汇驱动的需求访谈 |
| `to-issues.md` | mp | 计划→GitHub issues（垂直切片） |
| `to-prd.md` | mp | 对话→PRD |
| `prototype.md` | mp | 一次性原型回答设计问题 |
| `caveman.md` | mp | 超压缩通信省 75% token |
| `handoff.md` | mp | 对话压缩为交接文档 |
| `teach.md` | mp | 多会话教学系统 |
| `zoom-out.md` | mp | 上层抽象视角 |
| `improve-codebase-architecture.md` | mp | 架构巡检（删除测试 + HTML 报告） |
| `git-guardrails.md` | mp | Git 危险命令 hooks |

## 使用方式

直接在 Claude Code 中调用对应技能名即可。融合技能在 `~/.claude/skills/fused/` 目录下。

## 设计原则

- **Iron Law**：每个核心技能都有不可违反的铁律（sp 贡献）
- **反合理化表**：直接对抗 Agent 最常见的跳步借口（sp 贡献）
- **反馈循环优先**：调试和开发都从构建信号开始（mp 贡献）
- **垂直切片**：一个测试一个实现，不批量（mp 贡献）
- **双轴分离**：审查时标准和需求分开看，不互相掩盖（mp 贡献）
- **代码库探索优先**：能从代码找到的答案不问用户（mp 贡献）

## 技能边界说明

### Brainstorming vs Prototype

| 维度 | Brainstorming | Prototype |
|------|---------------|-----------|
| **阶段** | 设计阶段（先于任何代码） | 验证阶段（设计之后） |
| **产出** | 设计文档（spec） | 可运行的原型代码 |
| **目的** | 探索需求、确定架构 | 验证具体设计决策 |
| **形式** | 对话 + 文档 | 可执行代码 |
| **保留** | 持久保存设计文档 | 验证后删除或吸收 |

**标准流程**：Brainstorming → 设计文档 →（可选）Prototype 验证 → Writing Plans → 实现

### Writing Pipeline（三阶段写作）

| 阶段 | 技能 | 用途 |
|------|------|------|
| Stage 1 | `writing-fragments` | 挖掘碎片素材 |
| Stage 2 | `writing-shape` | 素材→文章结构 |
| Stage 3 | `writing-beats` | 节拍式叙事 |

**自动路由**：
- "fragments", "ideate", "raw material" → Stage 1
- "shape", "structure", "turn into article" → Stage 2
- "beats", "narrative", "journey" → Stage 3

### QA-Triage（QA→分诊闭环）

| 阶段 | 功能 | 产出 |
|------|------|------|
| Phase 1 | QA 会话 | GitHub issue |
| Phase 2 | 自动分诊 | 状态标签 + agent brief |
| Phase 3 | 监控恢复 | 需关注 issue 列表 |

**状态机**：unlabeled → needs-triage → needs-info / ready-for-agent / ready-for-human / wontfix
