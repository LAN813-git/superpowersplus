# Super Powers Plus

Super Powers Plus is a complete software development methodology for your coding agents, built on top of [obra/superpowers](https://github.com/obra/superpowers) and [mattpocock/skills](https://github.com/mattpocock/skills). It combines the best of both worlds into 21 composable skills and a 5-stage workflow that just works.

## Quickstart

Give your agent Super Powers Plus: [Claude Code](#claude-code), [Codex CLI](#codex-cli), [Cursor](#cursor), [Gemini CLI](#gemini-cli), [GitHub Copilot CLI](#github-copilot-cli).

## How it works

It starts from the moment you fire up your coding agent. As soon as it sees that you're building something, it *doesn't* just jump into trying to write code. Instead, it steps back and asks you what you're really trying to do.

Once it's teased a spec out of the conversation, it shows it to you in chunks short enough to actually read and digest.

After you've signed off on the design, your agent puts together an implementation plan that's clear enough for an enthusiastic junior engineer with poor taste, no judgement, no project context, and an aversion to testing to follow. It emphasizes true red/green TDD, YAGNI (You Aren't Gonna Need It), and DRY.

Next up, once you say "go", it launches a *subagent-driven-development* process, having agents work through each engineering task, inspecting and reviewing their work, and continuing forward.

There's a bunch more to it, but that's the core of the system. And because the skills trigger automatically, you don't need to do anything special. Your coding agent just has Super Powers Plus.

## Installation

Installation differs by harness. If you use more than one, install Super Powers Plus separately for each one.

### Claude Code

```bash
curl -sSL https://raw.githubusercontent.com/LAN813-git/superpowersplus/main/install.sh | bash
```

Or on Windows (PowerShell):

```powershell
irm https://raw.githubusercontent.com/LAN813-git/superpowersplus/main/install.ps1 | iex
```

### Codex CLI

```bash
# Copy skills to Codex skills directory
cp -r skills/fused/* ~/.codex/skills/
```

### Cursor

```bash
# Copy skills to Cursor rules directory
mkdir -p .cursor/rules
cp skills/fused/*.md .cursor/rules/
```

### Gemini CLI

```bash
# Append skills to GEMINI.md
cat skills/fused/*.md >> GEMINI.md
```

### GitHub Copilot CLI

```bash
# Copy skills to Copilot instructions
mkdir -p .github
cat skills/fused/*.md >> .github/copilot-instructions.md
```

## The Basic Workflow

1. **brainstorming** - Activates before writing code. Refines rough ideas through questions, explores alternatives, presents design in sections for validation. Saves design document. HARD-GATE: no code until user approves.

2. **writing-plans** - Activates with approved design. Breaks work into bite-sized tasks (2-5 minutes each). Every task has exact file paths, complete code, verification steps.

3. **test-driven-development** - Activates during implementation. Enforces RED-GREEN-REFACTOR: write failing test, watch it fail, write minimal code, watch it pass, commit. Iron Law: no production code without a failing test first.

4. **review** - Activates between tasks. Dual-axis review: Standards (code quality) and Spec (requirement compliance) run in parallel as isolated subagents. Reports issues by severity.

5. **verification-before-completion** - Activates when claiming done. No completion claims without fresh verification evidence.

**The agent checks for relevant skills before any task.** Mandatory workflows, not suggestions.

## What's Inside

### Fused Skills (6)

| Skill | Fusion | What it does |
|-------|--------|--------------|
| **diagnose** | mp feedback loop + sp Iron Law | Build signal before debugging |
| **tdd** | sp Iron Law + mp vertical slice | RED-GREEN-REFACTOR discipline |
| **review** | mp dual-axis + sp isolated reviewer | Standards vs Spec in parallel |
| **brainstorming** | sp HARD-GATE + mp explore-first | Design before code |
| **writing-pipeline** | mp fragments+shape+beats | 3-stage writing workflow |
| **qa-triage** | mp qa+triage | Interactive QA → auto triage |

### Referenced Skills (15)

**From superpowers**: `verification-before-completion` `writing-plans` `dispatching-parallel-agents` `finishing-a-development-branch` `using-git-worktrees`

**From mattpocock**: `grill-with-docs` `to-issues` `to-prd` `prototype` `caveman` `handoff` `teach` `zoom-out` `improve-codebase-architecture` `git-guardrails`

## Philosophy

- **Iron Law** - Every core skill has non-negotiable rules
- **Anti-rationalization table** - Directly counters agent skip-step excuses
- **Feedback loop first** - Debugging and development start from building signals
- **Vertical slice** - One test, one implementation, no batching
- **Dual-axis separation** - Standards and requirements reviewed separately
- **Codebase exploration first** - If the code has the answer, don't ask the user

## Contributing

1. Fork the repository
2. Create a branch for your work
3. Follow the skill file conventions (kebab-case, clear description)
4. Submit a PR

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## Community

- **Issues**: https://github.com/LAN813-git/superpowersplus/issues
- **Discussions**: https://github.com/LAN813-git/superpowersplus/discussions

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Acknowledgments

- [obra/superpowers](https://github.com/obra/superpowers) - The original superpowers framework
- [mattpocock/skills](https://github.com/mattpocock/skills) - Engineering skills library
