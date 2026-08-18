---
name: agents-verdict
description: Use when the user wants to research any topic with multiple AI sources, compare external AI responses side-by-side, run a structured multi-agent debate, or produce a confidence-tagged final verdict. Triggers on research sessions, fact-checking requests, AI comparison tasks, or "what's the real answer about X" questions.
---

# Agents Verdict

Multi-agent research system that runs two independent research teams, debates results (including external AI responses), and produces a validated confidence-tagged report with a mandatory acionável recommendation.

## Pré-requisitos

### Claude in Chrome (navegação real, menos detectável)
1. Instale a extensão **Claude for Chrome** na Chrome Web Store
2. Na primeira vez: `claude --chrome` — instala o native messaging host
3. Reinicie o Chrome se a extensão não for detectada

> Sem isso, os agentes usam Chrome DevTools MCP como fallback (Chrome isolado, mais detectável)

## Como invocar

```bash
cd ~/Documents/Claude/Projects/agents-verdict
```

```
@orquestrador
```

## Menu

```
╔══════════════════════════════════════════╗
║           🔬  AGENTS VERDICT             ║
╚══════════════════════════════════════════╝

  1  📝  Novo tema — gerar prompt para IAs
  2  ⚡  Tenho resultados — analisar agora
  3  ➕  Colar resposta de IA (uma por vez)
  4  📊  Ver status atual
  5  🚀  Rodar pipeline completo
  6  📄  Ver relatório final
  7  🚪  Sair
```

Opção 2 é o fast path: coleta 0-4 respostas de IAs (0 = só pesquisa independente) e dispara o pipeline completo automaticamente.

## Pipeline (Opção 5)

```
Phase 1 (paralelo — até 12 agentes):
  Equipe Alpha: pesquisador ×4  → outputs/grupo-alpha/
  Equipe Beta:  pesquisador ×4  → outputs/grupo-beta/
  IAs externas: ia-externa ×N   → outputs/grupo-ia/

Phase 2: mediador-debate → mapa de divergências
Phase 3 (paralelo): juiz ×3 → vereditos independentes
Phase 4: orquestrador compila + publica artifact HTML
```

## Relatório (artifact HTML)

```
▶ VEREDITO
  └─ Conclusão em 2-4 frases
  └─ ⭐ Recomendação acionável obrigatória
  └─ Tabela comparativa de candidatos (preço, nota, atributos)
  └─ Confiança geral + consenso X/3 juízes

Perspectiva dos Juízes
  └─ ⚖️ Magistrado Pragmático   [avatar + balão de fala]
  └─ 🔍 Árbitro Conservador     [avatar + balão de fala]
  └─ 🎯 Mediador Ousado         [avatar + balão de fala]

Equipes de Pesquisa
  └─ Alpha (azul): 👤📰💰⚠️
  └─ Beta (verde): 👤📰💰⚠️

IAs Externas Consultadas
  └─ Cards com confiança por IA

Evidências (colapsável)
  └─ Tabela completa de afirmações (Alpha | Beta | IAs | Juízes)
  └─ Divergências resolvidas
  └─ Pontos em aberto entre juízes (se houver)

Fontes
  └─ 8 pesquisadores com URLs consultadas
```

## Agentes

| Agente | Persona | Papel | Chamadas |
|--------|---------|-------|---------|
| `orquestrador` | — | Menu + coordenação + veredito final + artifact | entry point |
| `gerador-prompt` | — | Prompt padronizado para IAs externas | 1× |
| `ia-externa` | — | Estrutura e avalia resposta de IA | 0-4× |
| `pesquisador` | 👤📰💰⚠️ | Pesquisa independente por foco | 8× (4 Alpha + 4 Beta) |
| `mediador-debate` | — | Mapa de divergências entre todas as fontes | 1× |
| `juiz` | ⚖️🔍🎯 | Veredito independente + recomendação acionável obrigatória | 3× |

## Browser

| Método | Quando usar |
|--------|------------|
| **Claude in Chrome** (`mcp__claude-in-chrome__*`) | **Principal** — Chrome real do usuário, menos detectável. `list_connected_browsers` → `select_browser` → `tabs_context_mcp` → `navigate` → `get_page_text` → `tabs_close_mcp` |
| **Chrome DevTools MCP** (`mcp__plugin_chrome-devtools-mcp_chrome-devtools__*`) | **Fallback** — Chrome isolado. Usar se Claude in Chrome indisponível |

Ambos pré-autorizados em `.claude/settings.json` — sem prompts de permissão.

## Reutilizar para novo tema

Opção 1 do menu — o sistema pergunta se quer arquivar o tema anterior.

## Projeto

`~/Documents/Claude/Projects/agents-verdict/`
GitHub: https://github.com/murilofontes/agents-verdict
