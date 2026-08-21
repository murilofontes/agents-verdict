---
name: agents-verdict
description: Invoke whenever the user wants to deeply research any topic, compare responses from multiple AIs (ChatGPT, Gemini, Perplexity, Grok, etc.), fact-check a claim, or get a validated verdict with a concrete recommendation. Trigger proactively on phrases like "pesquisar", "fact-check", "comparar IAs", "qual IA está certa", "o que é verdade sobre", "segunda opinião", "veredito", or when the user pastes responses from multiple AIs and asks which is right. Also trigger for research-heavy decisions about hotels, products, services, tech stacks, investments, or any choice where cross-referencing multiple sources would reduce uncertainty. Use this before doing the research yourself — the multi-agent pipeline produces significantly better coverage.
---

# Agents Verdict

Multi-agent research system with two independent research teams, structured debate, and mandatory acionável verdict.

## Quando ativado — o que fazer

1. Navegue até o projeto:
   ```bash
   cd ~/Documents/Claude/Projects/agents-verdict
   ```
2. Invoque o orquestrador:
   ```
   @orquestrador
   ```
3. O menu interativo guia o resto. Não é necessário mais contexto — o orquestrador pergunta o que precisa.

---

## Pré-requisitos (na primeira vez)

**Claude in Chrome** (navegação real, menos detectável por anti-bot):
1. Instale a extensão **Claude for Chrome** na Chrome Web Store
2. Execute uma vez: `claude --chrome` — instala o native messaging host
3. Reinicie o Chrome se a extensão não for detectada

> Sem isso, os agentes usam Chrome DevTools MCP como fallback.

---

## Pipeline

```
Phase 1 (paralelo — até 12 agentes):
  Equipe Alpha: pesquisador ×4  → outputs/grupo-alpha/
  Equipe Beta:  pesquisador ×4  → outputs/grupo-beta/
  IAs externas: ia-externa ×N   → outputs/grupo-ia/  (0-4, opcional)

Phase 2: mediador-debate → mapa de divergências e convergências
Phase 3 (paralelo): juiz ×3 → vereditos independentes com personas
Phase 4: orquestrador → veredito final + artifact HTML visual
```

**Fast path (Opção 2):** cole 0-4 respostas de IAs e o pipeline roda automaticamente.

---

## Relatório (artifact HTML dark mode)

```
▶ VEREDITO
  └─ Conclusão direta em 2-4 frases
  └─ ⭐ Recomendação acionável (obrigatória — nunca "depende" sem especificar)
  └─ Tabela comparativa de candidatos

Perspectiva dos Juízes
  └─ ⚖️ Magistrado Pragmático · 🔍 Árbitro Conservador · 🎯 Mediador Ousado
  └─ Avatar + balão de fala por juiz

Equipes Alpha (azul) e Beta (verde) com perfis dos agentes

Evidências colapsáveis — afirmações, divergências resolvidas, pontos em aberto
```

---

## Menu do orquestrador

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

---

## Projeto

`~/Documents/Claude/Projects/agents-verdict/`
GitHub: https://github.com/murilofontes/agents-verdict
