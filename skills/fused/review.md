---
name: review
description: Fused dual-axis code review — mattpocock's Standards vs Spec separation + superpowers' isolated reviewer context. Use when user wants to review a branch, PR, work-in-progress, or says "review since X".
---

# Review

Two-axis review of the diff between `HEAD` and a fixed point the user supplies:

- **Standards** — does the code conform to this repo's documented coding standards?
- **Spec** — does the code faithfully implement the originating issue / PRD / spec?

Both axes run as **parallel sub-agents with isolated context** (no session history) so they evaluate the work product objectively, not the thought process behind it.

## Process

### 1. Pin the fixed point

Whatever the user said is the fixed point — a commit SHA, branch name, tag, `main`, `HEAD~5`, etc. Don't be opinionated; pass it through. If they didn't specify one, ask: "Review against what — a branch, a commit, or `main`?"

Capture the diff command: `git diff <fixed-point>...HEAD` (three-dot). Also note the commit list via `git log <fixed-point>..HEAD --oneline`.

### 2. Identify the spec source

Look for the originating spec, in this order:

1. Issue references in commit messages (`#123`, `Closes #45`).
2. A path the user passed as an argument.
3. A PRD/spec file under `docs/`, `specs/`, or `.scratch/` matching the branch name.
4. If nothing found, ask the user. If they say there isn't one, the **Spec** sub-agent skips and reports "no spec available".

### 3. Identify the standards sources

Anything in the repo that documents how code should be written:

- `CLAUDE.md`, `AGENTS.md`, `CONTRIBUTING.md`
- `CONTEXT.md`, per-context `CONTEXT.md` files, `docs/adr/`
- `.editorconfig`, `eslint.config.*`, `biome.json`, `prettier.config.*`
- Any `STYLE.md`, `STANDARDS.md`, `STYLEGUIDE.md`

Collect the list. The **Standards** sub-agent will read them.

### 4. Spawn both sub-agents in parallel

Send a single message with two `Agent` tool calls. Use the `general-purpose` subagent for both.

**Critical: Each sub-agent gets ONLY the diff + its specific brief. No session history. No context from your work.** This forces objective evaluation of the output, not the process.

**Standards sub-agent prompt** — include:

- The full diff command and commit list.
- The list of standards-source files from step 3.
- Brief: "Read the standards docs. Then read the diff. Report — per file/hunk — every place the diff violates a documented standard. Cite the standard (file + rule). Distinguish hard violations from judgement calls. Skip anything tooling enforces (linters, formatters). End with severity ranking: Critical / Important / Minor for each finding. Under 500 words."

**Spec sub-agent prompt** — include:

- The diff command and commit list.
- The path or fetched contents of the spec.
- Brief: "Read the spec. Then read the diff. Report: (a) requirements the spec asked for that are missing or partial; (b) behaviour in the diff that wasn't asked for (scope creep); (c) requirements that look implemented but where the implementation looks wrong. Quote the spec line for each finding. End with severity ranking: Critical / Important / Minor. Under 500 words."

If the spec is missing, skip the Spec sub-agent and note this in the final report.

### 5. Aggregate

Present the two reports under `## Standards` and `## Spec` headings, verbatim or lightly cleaned. **Do NOT merge or rerank findings** — the two axes are deliberately separate so the user can see them independently.

End with:
- Total findings per axis.
- Worst single issue flagged.
- Overall assessment: Ready to proceed / Needs fixes / Needs redesign.

## Severity Definitions

| Level | Definition | Action |
|-------|-----------|--------|
| **Critical** | Correctness bug, security issue, data loss risk, or spec violation that breaks core functionality | Fix immediately. Do not proceed until resolved. |
| **Important** | Convention violation, missing edge case, spec gap that affects user experience | Fix before merge. |
| **Minor** | Style preference, nice-to-have improvement, non-blocking spec deviation | Note for later. Can proceed. |

## Why Two Axes

A change can pass one axis and fail the other:

- Code that follows every standard but implements the wrong thing → **Standards pass, Spec fail.**
- Code that does exactly what the issue asked but breaks the project's conventions → **Spec pass, Standards fail.**

Reporting them separately stops one axis from masking the other.

## Why Isolated Context

The reviewer sub-agents get NO session history. This is deliberate:

- **Prevents bias** — the reviewer can't be influenced by the implementer's reasoning or intent.
- **Forces evidence-based evaluation** — the reviewer must judge the diff on its own merits.
- **Preserves your context** — the reviewer's findings don't pollute your working memory.

## When to Use

**Mandatory:**
- After completing a major feature
- Before merge to main/master
- After each subagent-driven development task

**Valuable:**
- When stuck (fresh perspective)
- Before refactoring (baseline check)
- After fixing a complex bug

## Red Flags

**Never:**
- Skip review because "it's simple"
- Ignore Critical findings
- Proceed with unfixed Important issues
- Give the reviewer your session context
- Merge findings from the two axes into one list

**If reviewer is wrong:**
- Push back with technical reasoning
- Show code/tests that prove it works
- Request clarification
