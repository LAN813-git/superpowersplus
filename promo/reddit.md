# Reddit Post (r/ClaudeAI)

**Title:**
> I unified the 7 essential Claude Code plugins into one install. 23 skills, auto-upgrade from superpowers.

**Body:**

---

If you use Claude Code, you've probably collected skills from different repos. obra/superpowers for discipline. mattpocock/skills for engineering. Maybe planning-with-files for context management. Maybe humanizer-zh for Chinese output.

I got tired of managing them separately. So I merged everything into one package.

**[Super Powers Plus](https://github.com/LAN813-git/superpowersplus)** = 7 core plugins unified.

### The 7 plugins

| # | Plugin | What it solves |
|---|--------|----------------|
| 1 | Super Powers + Mattpocock | Agent skips design, skips tests, calls it done |
| 2 | Planning with Files | Context fills up, agent forgets everything |
| 3 | PDF | Can't read technical docs |
| 4 | Frontend Design | Ugly UI, no responsive layout |
| 5 | Code Review | Ships code with vulnerabilities |
| 6 | Skill Creator | Can't extend agent capabilities |
| 7 | Humanizer zh | Chinese output sounds like a translation engine |

### Install (auto-upgrades from existing superpowers/mattpocock)

```bash
curl -sSL https://raw.githubusercontent.com/LAN813-git/superpowersplus/main/install.sh | bash
```

Windows:
```powershell
irm https://raw.githubusercontent.com/LAN813-git/superpowersplus/main/install.ps1 | iex
```

If you already have superpowers or mattpocock installed, the installer detects conflicts, backs up originals, and replaces with enhanced versions. One command.

### What changes

Before: agent jumps into code, context gets lost between sessions, Chinese docs read like Google Translate.

After:
1. **Planning** -- creates `task_plan.md` on disk. Survives `/clear`, session restarts, context compaction.
2. **Design** -- HARD-GATE: no code until you approve the spec.
3. **TDD** -- Iron Law: no production code without a failing test.
4. **Review** -- two parallel subagents: code quality + requirement compliance.
5. **Verify** -- no "done" without fresh evidence.
6. **Humanize** -- strips 24 AI patterns from Chinese text before shipping.

**[GitHub ->](https://github.com/LAN813-git/superpowersplus)**

---
