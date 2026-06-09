---
name: brainstorming
description: Fused design-first skill — superpowers' HARD-GATE + mattpocock's codebase-explore-first principle. Use before any creative work: new features, components, functionality, or behavior changes. Explores intent and requirements before implementation.
---

# Brainstorming

Turn ideas into designs through collaborative dialogue. **Explore the codebase first, then ask questions.**

<HARD-GATE>
Do NOT write any code, scaffold any project, or take any implementation action until you have presented a design and the user has approved it. This applies to EVERY project regardless of perceived simplicity.
</HARD-GATE>

## Process

### 1. Explore before asking

Before asking the user anything, explore the codebase:

- Check files, docs, recent commits, CONTEXT.md, ADRs
- Understand existing patterns and architecture
- Use the project's domain glossary to frame your understanding
- If a question can be answered by exploring the codebase, **explore instead of asking**

This prevents wasting the user's time on answerable questions and ensures your proposals respect existing patterns.

### 2. Assess scope

If the request describes multiple independent subsystems (e.g., "build a platform with chat, file storage, billing, analytics"), flag this immediately. Help the user decompose into sub-projects first. Each sub-project gets its own design -> plan -> implementation cycle.

### 3. Ask clarifying questions

One question at a time. Prefer multiple choice. Focus on: purpose, constraints, success criteria.

### 4. Propose 2-3 approaches

Present options conversationally with trade-offs. Lead with your recommendation and explain why. If the user rejects all approaches, ask what they'd prefer and adapt — don't re-present the same options.

### 5. Present design

- Scale each section to its complexity
- Ask after each section whether it looks right
- Cover: architecture, components, data flow, error handling, testing
- Design for isolation: each unit has one clear purpose, well-defined interfaces, independently testable

### 6. Write design doc

Save to `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md` (or user's preferred location). Commit it.

### 7. Self-review the spec

- **Placeholder scan:** Any "TBD", "TODO", vague requirements? Fix them.
- **Internal consistency:** Do sections contradict each other?
- **Scope check:** Focused enough for one implementation plan?
- **Ambiguity check:** Could any requirement be interpreted two ways? Pick one.

Fix inline. No need to re-review.

### 8. User reviews

> "Spec written and committed to `<path>`. Please review before we write the implementation plan."

Wait for approval. If changes requested, make them and re-run self-review.

### 9. Transition

Invoke `writing-plans` to create the implementation plan. Do NOT invoke any other skill. writing-plans is the ONLY next step.

## Key Principles

- **Explore codebase first** — don't ask what you can find out yourself
- **One question at a time** — don't overwhelm
- **Multiple choice preferred** — easier to answer
- **YAGNI ruthlessly** — remove unnecessary features
- **Incremental validation** — present design, get approval, move on
- **Be flexible** — go back and clarify when needed

## Design for Isolation

Break the system into smaller units that:
- Each have one clear purpose
- Communicate through well-defined interfaces
- Can be understood and tested independently

Can someone understand what a unit does without reading its internals? Can you change the internals without breaking consumers? If not, the boundaries need work.

## Working in Existing Codebases

- Follow existing patterns
- Include targeted improvements where existing code affects the work
- Don't propose unrelated refactoring
- Stay focused on what serves the current goal

## When to Use

**Always:**
- New features
- New components
- Behavior changes
- Architecture decisions

**Skip only when:**
- Single-line fix with clear cause
- User explicitly says "just fix it, no design needed" (and even then, a 2-sentence design is wise)

## Brainstorming vs Prototype

| 维度 | Brainstorming | Prototype |
|------|---------------|-----------|
| **阶段** | 设计阶段（先于任何代码） | 验证阶段（设计之后） |
| **产出** | 设计文档（spec） | 可运行的原型代码 |
| **目的** | 探索需求、确定架构 | 验证具体设计决策 |
| **形式** | 对话 + 文档 | 可执行代码 |
| **保留** | 持久保存设计文档 | 验证后删除或吸收 |

**流程**：Brainstorming → 设计文档 →（可选）Prototype 验证 → Writing Plans → 实现

**何时用 Prototype**：
- 设计中存在需要验证的假设（如"这个状态模型感觉对吗？"）
- 需要直观感受 UI 效果
- 数据模型或交互逻辑需要实际运行才能确认
