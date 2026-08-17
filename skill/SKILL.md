---
name: agents-verdict
description: Use when the user wants to research any topic with multiple AI sources, compare external AI responses side-by-side, run a structured multi-agent debate, or produce a confidence-tagged final verdict. Triggers on research sessions, fact-checking requests, AI comparison tasks, or "what's the real answer about X" questions.
---

# Agents Verdict

Multi-agent research system that debates AI responses and independent web research to produce a validated, confidence-tagged final report.

## How to Invoke

Open Claude Code in the project directory:

```bash
cd ~/Documents/Claude/Projects/agents-verdict
```

Then call the orchestrator:

```
@orquestrador
```

## Menu Options

| Option | Action |
|--------|--------|
| 1 | Generate standardized prompt to paste into external AIs |
| 2 | Paste one external AI response (repeat up to 4×) |
| 3 | Check status (how many responses collected) |
| 4 | Run full pipeline (research + debate + verdict) |
| 5 | View final report |

## Pipeline (Option 4)

```
Phase 1 (parallel): ia-externa ×4  +  pesquisador ×4
Phase 2:            mediador-debate  →  divergence map
Phase 3 (parallel): juiz ×2  →  independent verdicts
Phase 4:            compile relatorio-final.md
```

## Agents

| Agent | Role | Calls |
|-------|------|-------|
| `orquestrador` | Menu + coordination | entry point |
| `gerador-prompt` | Generates comparable prompt for external AIs | 1× per topic |
| `ia-externa` | Structures and evaluates one external AI response | 4× parallel |
| `pesquisador` | Independent web research (user reports / official / market / risks) | 4× parallel |
| `mediador-debate` | Convergence/divergence map across all 8 agent outputs | 1× |
| `juiz` | Independent final verdict with explicit justifications | 2× parallel |

## Confidence Scale

| Icon | Level | Criteria |
|------|-------|----------|
| 🟢 | High | 3+ independent sources converge, no red flags |
| 🟡 | Medium | 1-2 sources or minor flag |
| 🔴 | Low | Single source, red flag, or unverifiable |
| ⚪ | N/A | Subjective opinion |

## Reusing for a New Topic

Choose Option 1 from the menu — the orchestrator asks whether to archive the previous research before starting fresh.

## Project Location

`~/Documents/Claude/Projects/agents-verdict/`  
GitHub: https://github.com/murilofontes/agents-verdict
