---
name: diagnose
description: Fused diagnosis skill — mattpocock's feedback-loop-first philosophy + superpowers' Iron Law and anti-rationalization framework. Use when user reports a bug, says something is broken/throwing/failing, or describes a performance regression.
---

# Diagnose

A discipline for hard bugs. **The feedback loop IS the skill.** Everything else is mechanical.

**Iron Law:** NO FIXES WITHOUT A FEEDBACK LOOP AND ROOT CAUSE FIRST.

Skip phases only when explicitly justified to your human partner.

## The Feedback Loop — Build This First

**This is the most important phase.** If you have a fast, deterministic, agent-runnable pass/fail signal for the bug, you will find the cause. If you don't have one, no amount of staring at code will save you.

Spend disproportionate effort here. **Be aggressive. Be creative. Refuse to give up.**

### Ways to construct one — try them in roughly this order

1. **Failing test** at whatever seam reaches the bug — unit, integration, e2e.
2. **Curl / HTTP script** against a running dev server.
3. **CLI invocation** with a fixture input, diffing stdout against a known-good snapshot.
4. **Headless browser script** (Playwright / Puppeteer) — drives the UI, asserts on DOM/console/network.
5. **Replay a captured trace.** Save a real network request / payload / event log to disk; replay it through the code path in isolation.
6. **Throwaway harness.** Spin up a minimal subset of the system that exercises the bug code path with a single function call.
7. **Property / fuzz loop.** If the bug is "sometimes wrong output", run 1000 random inputs and look for the failure mode.
8. **Bisection harness.** If the bug appeared between two known states, automate "boot at state X, check, repeat" so you can `git bisect run` it.
9. **Differential loop.** Run the same input through old-version vs new-version and diff outputs.
10. **HITL bash script.** Last resort. If a human must click, drive _them_ with a structured loop script.

Build the right feedback loop, and the bug is 90% fixed.

### Iterate on the loop itself

Treat the loop as a product. Once you have _a_ loop, ask:

- Can I make it **faster**? (Cache setup, skip unrelated init, narrow the test scope.)
- Can I make the **signal sharper**? (Assert on the specific symptom, not "didn't crash".)
- Can I make it **more deterministic**? (Pin time, seed RNG, isolate filesystem, freeze network.)

A 30-second flaky loop is barely better than no loop. A 2-second deterministic loop is a debugging superpower.

### Non-deterministic bugs

The goal is not a clean repro but a **higher reproduction rate**. Loop the trigger 100x, parallelise, add stress, narrow timing windows, inject sleeps. A 50%-flake bug is debuggable; 1% is not — keep raising the rate until it's debuggable.

### When you genuinely cannot build a loop

Stop and say so explicitly. List what you tried. Ask your human partner for: (a) access to whatever environment reproduces it, (b) a captured artifact (HAR file, log dump, core dump, screen recording), or (c) permission to add temporary production instrumentation. **Do not proceed without a loop.**

## Phase 1 — Reproduce

Run the loop. Watch the bug appear.

Confirm:

- [ ] The loop produces the failure mode the **user** described — not a different failure that happens to be nearby.
- [ ] The failure is reproducible across multiple runs (or at a high enough rate to debug against).
- [ ] You have captured the exact symptom (error message, wrong output, slow timing).

Do not proceed until you reproduce the bug.

## Phase 2 — Hypothesise

Generate **3-5 ranked hypotheses** before testing any of them. Single-hypothesis generation anchors on the first plausible idea.

Each hypothesis must be **falsifiable**: state the prediction it makes.

> Format: "If <X> is the cause, then <changing Y> will make the bug disappear / <changing Z> will make it worse."

If you cannot state the prediction, the hypothesis is a vibe — discard or sharpen it.

**Show the ranked list to your human partner before testing.** They often have domain knowledge that re-ranks instantly. Cheap checkpoint, big time saver. Don't block on it — proceed with your ranking if the user is AFK.

## Phase 3 — Instrument

Each probe must map to a specific prediction from Phase 2. **Change one variable at a time.**

Tool preference:

1. **Debugger / REPL inspection** if the env supports it. One breakpoint beats ten logs.
2. **Targeted logs** at the boundaries that distinguish hypotheses.
3. Never "log everything and grep".

**Tag every debug log** with a unique prefix, e.g. `[DEBUG-a4f2]`. Cleanup at the end becomes a single grep.

**Perf branch.** For performance regressions: establish a baseline measurement (timing harness, `performance.now()`, profiler, query plan), then bisect. Measure first, fix second.

## Phase 4 — Fix + Regression Test

Write the regression test **before the fix** — but only if there is a **correct seam** for it.

A correct seam is one where the test exercises the **real bug pattern** as it occurs at the call site. If the only available seam is too shallow, a regression test there gives false confidence.

**If no correct seam exists, that itself is the finding.** Note it. The codebase architecture is preventing the bug from being locked down.

If a correct seam exists:

1. Turn the minimised repro into a failing test at that seam.
2. Watch it fail.
3. Apply the fix.
4. Watch it pass.
5. Re-run the original feedback loop against the un-minimised scenario.

**If the fix doesn't work:**
- Count how many fixes you've tried.
- If < 3: Return to Phase 1 with new information.
- **If >= 3: STOP. This is an architectural problem, not a bug.** Discuss with your human partner before attempting more fixes.

## Phase 5 — Cleanup + Post-Mortem

Required before declaring done:

- [ ] Original repro no longer reproduces (re-run the feedback loop)
- [ ] Regression test passes (or absence of seam is documented)
- [ ] All `[DEBUG-...]` instrumentation removed
- [ ] Throwaway prototypes deleted
- [ ] The hypothesis that turned out correct is stated in the commit / PR message

**Then ask: what would have prevented this bug?** If the answer involves architectural change, hand off to `improve-codebase-architecture` with the specifics. Make the recommendation **after** the fix is in.

## Red Flags — STOP and Return to Phase 1

If you catch yourself thinking:
- "Quick fix for now, investigate later"
- "Just try changing X and see if it works"
- "Add multiple changes, run tests"
- "Skip the test, I'll manually verify"
- "It's probably X, let me fix that"
- "I don't fully understand but this might work"
- "One more fix attempt" (when already tried 2+)
- Each fix reveals new problem in different place

**ALL of these mean: STOP. Return to the feedback loop.**

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Issue is simple, don't need process" | Simple issues have root causes too. Process is fast for simple bugs. |
| "Emergency, no time for process" | Systematic debugging is FASTER than guess-and-check thrashing. |
| "Just try this first, then investigate" | First fix sets the pattern. Do it right from the start. |
| "I'll write test after confirming fix works" | Untested fixes don't stick. Test first proves it. |
| "Multiple fixes at once saves time" | Can't isolate what worked. Causes new bugs. |
| "I see the problem, let me fix it" | Seeing symptoms != understanding root cause. |
| "One more fix attempt" (after 2+ failures) | 3+ failures = architectural problem. Question pattern, don't fix again. |

## Quick Reference

| Phase | Key Activity | Exit Criteria |
|-------|-------------|---------------|
| **Loop** | Build pass/fail signal | Fast, deterministic, agent-runnable |
| **Reproduce** | Run loop, watch bug appear | Matches user's described symptom |
| **Hypothesise** | 3-5 ranked, falsifiable predictions | Shown to user (or AFK timeout) |
| **Instrument** | One variable at a time, tagged logs | Evidence narrows to specific cause |
| **Fix** | Regression test + minimal fix | Loop passes, regression test passes |
| **Cleanup** | Remove debug artifacts, post-mortem | All checkboxes green |

## Real-World Impact

- Systematic approach: 15-30 minutes to fix
- Random fixes approach: 2-3 hours of thrashing
- First-time fix rate: 95% vs 40%
- New bugs introduced: Near zero vs common
