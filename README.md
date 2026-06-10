# Super Powers Plus

Super Powers Plus unifies the 7 essential plugins for AI coding agents into a single install. No more manually collecting skills from different repos. One command, everything works.

## Quickstart

Give your agent Super Powers Plus: [Claude Code](#claude-code), [Codex CLI](#codex-cli), [Cursor](#cursor), [Gemini CLI](#gemini-cli), [GitHub Copilot CLI](#github-copilot-cli).

## The 7 Core Plugins

| # | Plugin | What it solves |
|---|--------|----------------|
| 1 | **Super Powers + Mattpocock** | Agent jumps into code without understanding the goal. No tests, no review, no verification. |
| 2 | **Planning with Files** | Context window fills up, agent forgets what it was doing. Session restart = start over. |
| 3 | **PDF** | Can't read technical docs, API whitepapers, or papers with charts. |
| 4 | **Frontend Design** | Programmer aesthetics. Ugly UI, no dark mode, no responsive layout. |
| 5 | **Code Review** | Code ships with dead loops, OWASP vulnerabilities, spec violations nobody caught. |
| 6 | **Skill Creator** | Repeating the same workflow manually. Can't extend the agent's capabilities. |
| 7 | **Humanizer zh** | Chinese output sounds like a translation engine. Stiff, formulaic, obviously AI. |

## How it works

The moment you start your agent, Super Powers Plus takes over:

**1. Plan first.** Before touching code, the agent reads or creates a `task_plan.md` in your project. This file is the agent's disk working memory -- it survives context compaction, session restarts, and `/clear`. Every phase, every finding, every error gets written to disk.

**2. Design before code.** The agent explores your codebase, asks you what you actually want, and presents a design in chunks you can actually read. HARD-GATE: no code until you approve.

**3. Build with discipline.** RED-GREEN-REFACTOR. Write a failing test first, then the minimum code to pass it. Iron Law: no production code without a failing test.

**4. Review in parallel.** Two independent subagents review your code at the same time -- one checks code quality (Standards), the other checks requirement compliance (Spec). They don't see each other's work.

**5. Verify before shipping.** No "done" claims without fresh evidence. Tests must pass, specs must be met, and if you're writing Chinese documentation, the Humanizer strips 24 AI writing patterns before it ships.

And because the skills trigger automatically, you don't need to do anything special. Your coding agent just has Super Powers Plus.

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
cp -r skills/fused/* ~/.codex/skills/
```

### Cursor

```bash
mkdir -p .cursor/rules
cp skills/fused/*.md .cursor/rules/
```

### Gemini CLI

```bash
cat skills/fused/*.md >> GEMINI.md
```

### GitHub Copilot CLI

```bash
mkdir -p .github
cat skills/fused/*.md >> .github/copilot-instructions.md
```

### Upgrading from obra/superpowers or mattpocock/skills

If you already have [obra/superpowers](https://github.com/obra/superpowers) or [mattpocock/skills](https://github.com/mattpocock/skills) installed, the installer will:

1. **Detect** conflicting skill files in `~/.claude/skills/` and `~/.agents/skills/`
2. **Back up** originals to `~/.claude/skills-backup-<timestamp>/`
3. **Remove** conflicting files
4. **Install** Super Powers Plus (enhanced versions)

To rollback: `cp ~/.claude/skills-backup-<timestamp>/* ~/.claude/skills/`

No manual cleanup needed. Just run the install command.

## What's Inside

23 skills organized by the 7 core plugins:

### Plugin 1: Super Powers + Mattpocock (engineering workflow)

| Skill | What it does |
|-------|--------------|
| **brainstorming** | HARD-GATE: design before code, explore codebase first |
| **writing-plans** | Zero-placeholder execution plans, 2-5 min per task |
| **tdd** | RED-GREEN-REFACTOR, Iron Law enforced |
| **diagnose** | Build feedback loop before debugging |
| **review** | Dual-axis: Standards vs Spec in parallel |
| **verification-before-completion** | No done without fresh evidence |
| **dispatching-parallel-agents** | Parallel subagent orchestration |
| **finishing-a-development-branch** | Branch lifecycle: merge/PR/keep/discard |
| **using-git-worktrees** | Isolated workspaces for feature work |
| **grill-with-docs** | Domain-driven requirement interviews |
| **to-issues** | Plan to GitHub issues, vertical sliced |
| **to-prd** | Conversation to PRD |
| **prototype** | Throwaway prototypes for design validation |
| **caveman** | Ultra-compressed comms, ~75% token savings |
| **handoff** | Conversation compaction for agent handoff |
| **teach** | Multi-session teaching system |
| **zoom-out** | High-level abstraction perspective |
| **improve-codebase-architecture** | Architecture inspection with delete tests |
| **git-guardrails** | Git dangerous command hooks |

### Plugin 2: Planning with Files

| Skill | What it does |
|-------|--------------|
| **planning-with-files-zh** | Physical `task_plan.md` + `findings.md` + `progress.md` as disk working memory. Survives `/clear`, session restarts, context compaction. |

### Plugin 7: Humanizer zh

| Skill | What it does |
|-------|--------------|
| **humanizer-zh** | Detects and removes 24 AI writing patterns in Chinese. Quality scoring: directness, rhythm, trust, authenticity, conciseness (50 pts total). |

### Plugins 3-6: Built-in

PDF, Frontend Design, Code Review (via `review` above), and Skill Creator are built into Claude Code and activated by default. No extra installation needed.

## The Basic Workflow

```
                    ┌─────────────┐
                    │   Planning   │ ← task_plan.md on disk
                    │  with Files  │
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │ Brainstorming│ ← HARD-GATE
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │Writing Plans │ ← exact file paths + code
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │     TDD      │ ← RED-GREEN-REFACTOR
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │    Review    │ ← Standards ‖ Spec
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │ Verification │ ← no done without evidence
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │  Humanizer   │ ← strip AI patterns (zh)
                    └──────┬──────┘
                           │
                         Done.
```

## Philosophy

- **Iron Law** -- Every core skill has non-negotiable rules. The agent can't rationalize its way out.
- **Anti-rationalization table** -- Every skill lists the top 3 excuses the agent will try, with exact counter-arguments.
- **Feedback loop first** -- Debugging and development start from building signals, not guessing.
- **Vertical slice** -- One test, one implementation. No batching.
- **Dual-axis separation** -- Standards and requirements reviewed in parallel, by isolated subagents.
- **Codebase exploration first** -- If the code has the answer, don't ask the user.
- **Disk working memory** -- Context window is volatile. Anything important goes to files that survive session restarts.
- **Human-first writing** -- AI output has patterns. We detect and strip them.

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

- [obra/superpowers](https://github.com/obra/superpowers) -- The original superpowers framework
- [mattpocock/skills](https://github.com/mattpocock/skills) -- Engineering skills library
- [OthmanAdi/planning-with-files](https://github.com/OthmanAdi/planning-with-files) -- Manus-style file planning
- [op7418/Humanizer-zh](https://github.com/op7418/Humanizer-zh) -- Chinese AI writing pattern remover
