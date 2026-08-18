# Agents Verdict

Sistema reutilizável de pesquisa multi-agente com debate e veredito validado. Funciona com qualquer tema.

## Pré-requisitos

### Claude in Chrome (navegação real, menos detectável por anti-bot)

1. Instale a extensão **[Claude for Chrome](https://chromewebstore.google.com/detail/claude-for-chrome/fcoeoabgfenejglbffodgkkbkcdhcgfn)** na Chrome Web Store
2. Na primeira vez, inicie o Claude Code com:
   ```bash
   claude --chrome
   ```
   Isso instala o native messaging host e conecta a extensão ao Claude Code.
3. Reinicie o Chrome se a extensão não for detectada imediatamente.

> **Sem isso**, os agentes usarão o Chrome DevTools MCP como fallback (Chrome isolado, mais detectável por sites com proteção anti-bot).

---

## Instalação do skill

```bash
git clone https://github.com/murilofontes/agents-verdict
cd agents-verdict
./install-skill.sh
# depois, no Claude Code:
# /reload-skills
```

O skill fica disponível globalmente e é ativado automaticamente quando você pede pesquisa com múltiplas IAs.

## Como usar

Abra Claude Code neste diretório e invoque o orquestrador:

```
@orquestrador
```

O menu interativo guia todo o fluxo.

## Arquitetura v2

```
Phase 1 (paralelo — até 12 agentes simultâneos):
  Equipe Alpha: pesquisador ×4  → outputs/grupo-alpha/
  Equipe Beta:  pesquisador ×4  → outputs/grupo-beta/
  IAs externas: ia-externa ×N   → outputs/grupo-ia/  (0-4, opcional)

Phase 2: mediador-debate → mapa de divergências
Phase 3 (paralelo): juiz ×3 → vereditos independentes
Phase 4: orquestrador → veredito final + artifact HTML visual
```

## Agentes

| Agente | Papel | Chamadas |
|--------|-------|---------|
| `orquestrador` | Menu + coordenação | entry point |
| `gerador-prompt` | Gera prompt comparável para IAs externas | 1× |
| `ia-externa` | Analisa e estrutura resposta de IA externa | 0-4× |
| `pesquisador` | Pesquisa independente por foco (relatos/oficial/mercado/riscos) | 8× (4 Alpha + 4 Beta) |
| `mediador-debate` | Mapa de convergências e divergências entre as 2 equipes + IAs | 1× |
| `juiz` | Veredito independente com recomendação acionável obrigatória | 3× |

### Personas dos agentes

| Agente | Emoji | Título |
|--------|-------|--------|
| Pesquisador 1 | 👤 | Analista de Campo |
| Pesquisador 2 | 📰 | Investigador de Fontes |
| Pesquisador 3 | 💰 | Especialista de Mercado |
| Pesquisador 4 | ⚠️ | Auditora de Riscos |
| Juiz 1 | ⚖️ | Magistrado Pragmático |
| Juiz 2 | 🔍 | Árbitro Conservador |
| Juiz 3 | 🎯 | Mediador Ousado |

## Estrutura de outputs

```
outputs/
├── grupo-alpha/      # Pesquisas da Equipe Alpha
├── grupo-beta/       # Pesquisas da Equipe Beta
├── grupo-ia/         # Análises das IAs externas
├── grupo-c/          # Mapa de divergências
├── final/            # Vereditos dos juízes + relatório + artifact HTML
└── historico/        # Temas anteriores arquivados
```

## Relatório final

O artifact HTML gerado inclui:
- **Veredito** com recomendação acionável destacada e tabela de candidatos
- **Juízes** com avatares e balões de fala mostrando a visão de cada um
- **Equipes** Alpha e Beta com perfis dos agentes
- **Evidências** em seções colapsáveis

## Critérios de avaliação

Ver `criterios/avaliacao.md` — escala de confiança e sinais de baixa confiabilidade usados por todos os agentes.
