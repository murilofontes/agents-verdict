# Agents Verdict — Design Spec
**Data:** 2026-08-17  
**Status:** Aprovado pelo usuário

## Objetivo

Sistema reutilizável de pesquisa multi-agente com debate e veredito validado. O usuário fornece um tema, cola respostas de 4 IAs externas, e o sistema executa pesquisa independente, debate, e produz um relatório com afirmações classificadas por confiança.

## Localização

`/Users/murilofontes/Documents/Claude/Projects/agents-verdict/`

## Estrutura de Pastas

```
agents-verdict/
├── .claude/agents/          # 6 subagents (templates reutilizáveis)
├── criterios/avaliacao.md   # Critérios compartilhados por todos os agentes
├── inputs/
│   ├── prompt-usado.md      # Prompt gerado para IAs externas
│   └── ia-externas/         # Respostas coladas (1 arquivo por IA)
├── outputs/
│   ├── grupo-a/             # Análises estruturadas das IAs externas
│   ├── grupo-b/             # Pesquisas independentes
│   ├── grupo-c/             # Mapa de divergências
│   ├── final/               # Vereditos dos juízes + relatório final
│   └── historico/           # Temas anteriores arquivados
├── estado/estado-atual.md   # Estado atual (tema, IAs coladas, pipeline)
└── docs/superpowers/specs/  # Este arquivo
```

## Agentes (6 templates)

| Arquivo | Papel | Chamadas | Ferramentas |
|---------|-------|----------|-------------|
| `orquestrador.md` | Menu + coordenação de fases | 1x | Read, Write, Edit, Bash, Agent |
| `gerador-prompt.md` | Gera prompt padronizado para IAs externas | 1x por tema | Read, Write |
| `ia-externa.md` | Analisa resposta de uma IA externa | 4x em paralelo | Read, Write |
| `pesquisador.md` | Pesquisa independente com foco específico | 4x em paralelo | Read, Write, WebSearch, WebFetch |
| `mediador-debate.md` | Compila 8 outputs, gera mapa de divergências | 1x | Read, Write, WebSearch, WebFetch |
| `juiz.md` | Veredito independente com justificativas | 2x em paralelo | Read, Write |

**Otimizações de tokens:**
- Critérios lidos por path, não embedados nos prompts
- Outputs em tabelas MD (não prosa)
- Cada agente recebe só o contexto que precisa
- Agentes reutilizáveis (template único chamado N vezes com parâmetros diferentes)

## Fluxo de Execução

```
Opção 1: gerar prompt → salvar inputs/prompt-usado.md
Opção 2 (4x): colar resposta → salvar inputs/ia-externas/[nome].md
Opção 4:
  PARALELO → ia-externa × 4 + pesquisador × 4
  SEQUENCIAL → mediador-debate
  PARALELO → juiz × 2
  → compilar relatorio-final.md
Opção 5: exibir relatório
```

## Estrutura do Relatório Final

1. Resposta consolidada (afirmações 🟢/🟡 com consenso)
2. Tabela de afirmações com confiança e agentes que sustentam
3. Divergências resolvidas + critério usado
4. Pontos em aberto entre os juízes (se houver)
5. Fontes organizadas por agente
