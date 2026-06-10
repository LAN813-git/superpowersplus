# 示例：新功能开发

## 自动触发的工作流

```
> 给项目添加用户认证
```

代理自动执行：

1. **planning-with-files** — 创建 `task_plan.md` 拆解阶段
2. **brainstorming** — 探索代码库 → 问设计问题（JWT? Session?）→ 呈现方案
3. **writing-plans** — 垂直切片执行计划，每个任务 2-5 分钟
4. **tdd** — 先写失败测试 → 写最少代码 → 重构 → 提交
5. **review** — Standards + Spec 双轴并行审查
6. **verification** — 跑测试确认通过

全程自动，你只需要回答设计问题。

## 会话中断后恢复

```
> 继续上次的工作
```

代理读取 `task_plan.md` + `progress.md`，从上次停下的地方继续。
