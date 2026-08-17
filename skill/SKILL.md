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
| 2 | ⚡ Fast path — paste all responses now, pipeline runs automatically after |
| 3 | Paste one external AI response (repeat up to 4×) |
| 4 | Check status (how many responses collected) |
| 5 | Run full pipeline (research + debate + verdict) |
| 6 | View final report |
| 7 | Exit |

Option 2 is the fast path: it asks how many responses you have (2-4), collects each one in a loop, then runs the full pipeline (same as Option 5) and displays the report — no need to return to the menu in between.

## Pipeline (Option 5)

```
Phase 1 (parallel): ia-externa ×4  +  pesquisador ×4
Phase 2:            mediador-debate  →  divergence map
Phase 3 (parallel): juiz ×2  →  independent verdicts
Phase 4:            compile relatorio-final.md
Phase 5:            display report inline (verdict first, evidence after)
```

## Report Structure

The final report always opens with the verdict block:

```
▶ VEREDITO
  └─ 2-4 sentence conclusion
  └─ Overall confidence: 🟢/🟡/🔴
  └─ Judge consensus: unanimous / X open points
  └─ Key claims table (🟢🟡 only)

Evidências e Análise
  └─ Full claims table (all confidence levels)
  └─ Resolved divergences + criterion used
  └─ Open points between judges (if any)

Fontes
  └─ External AIs + confidence ratings
  └─ Independent research URLs per agent
```

The report is displayed inline in the conversation immediately after generation — no need to use Option 6. The file `outputs/final/relatorio-final.md` is also saved for permanent reference.

## Agents

| Agent | Role | Calls | Browser |
|-------|------|-------|---------|
| `orquestrador` | Menu + coordination | entry point | — |
| `gerador-prompt` | Generates comparable prompt for external AIs | 1× per topic | — |
| `ia-externa` | Structures and evaluates one external AI response | 4× parallel | — |
| `pesquisador` | Independent web research (user reports / official / market / risks) | 4× parallel | ✅ |
| `mediador-debate` | Convergence/divergence map across all 8 agent outputs + tiebreaker searches | 1× | ✅ |
| `juiz` | Independent final verdict with explicit justifications | 2× parallel | — |

`pesquisador` and `mediador-debate` can use WebSearch, WebFetch, and the local Chrome browser (via Chrome DevTools MCP) — all pre-authorized in `.claude/settings.json`, no permission prompts.

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
