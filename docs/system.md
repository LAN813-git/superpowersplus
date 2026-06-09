# Super Powers Plus 完整体系文档

> 融合 obra/superpowers + mattpocock/skills + 社区精选插件，23 个技能，5 阶段工作流，七大核心插件全覆盖。

## 核心理念

- **Iron Law**：每个核心技能有不可违反的铁律
- **反合理化表**：对抗 Agent 跳步借口
- **反馈循环优先**：调试从构建信号开始
- **垂直切片**：一个测试一个实现
- **双轴分离**：审查时标准和需求分开看
- **代码库探索优先**：能查到的不问用户
- **磁盘工作记忆**：上下文窗口易失，重要内容写文件
- **人类优先写作**：去除 AI 痕迹，写得像人

## 五阶段工作流

```
设计 → 计划 → 实现 → 审查 → 交付
```

### 阶段 1：设计

技能：`brainstorming` + `prototype`

- HARD-GATE：用户批准设计前禁止编码
- 探索代码库优先于提问

### 阶段 2：计划

技能：`writing-plans` + `to-issues`

- 零占位符精确执行计划
- 垂直切片拆解

### 阶段 3：实现

技能：`tdd` + `diagnose`

- Iron Law：先写失败测试再写代码
- 调试先建反馈循环

### 阶段 4：审查

技能：`review` + `qa-triage`

- 双轴：Standards vs Spec 并行
- 交互式 QA→自动分诊

### 阶段 5：交付

技能：`verification-before-completion` + `finishing-a-development-branch`

- 无证据不声称完成
- 分支收尾：merge/PR/keep/discard

## 技能列表

### 融合技能（8 个）

| 技能 | 融合来源 |
|------|---------|
| `diagnose` | mp 反馈循环 + sp Iron Law |
| `tdd` | sp Iron Law + mp 垂直切片 |
| `review` | mp 双轴分离 + sp 隔离审查 |
| `brainstorming` | sp HARD-GATE + mp 探索优先 |
| `writing-pipeline` | mp fragments+shape+beats |
| `qa-triage` | mp qa+triage |
| `planning-with-files-zh` | Manus 风格文件规划（社区） |
| `humanizer-zh` | op7418/Humanizer-zh（社区） |

### 引用技能（15 个）

来源 superpowers：`verification-before-completion` `writing-plans` `dispatching-parallel-agents` `finishing-a-development-branch` `using-git-worktrees`

来源 mattpocock：`grill-with-docs` `to-issues` `to-prd` `prototype` `caveman` `handoff` `teach` `zoom-out` `improve-codebase-architecture` `git-guardrails`
