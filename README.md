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

## Arquitetura

```
Fase 1   (paralelo — até 12 agentes):
  Alpha ×4 — mainstream: busca o popular, bem avaliado, corroborado por fóruns
  Beta  ×4 — contrarian: busca falhas, decepções, alternativas que o mainstream ignora
  IAs externas ×N → outputs/grupo-ia/ (0-4, opcional)

Fase 1.5 (seleção inline + paralelo):
  Orquestrador seleciona top 5 finalistas por score de consenso
  pesquisador-aprofundador ×5 — navega fontes reais (booking page, reviews, produto)

Fase 2   (sequencial):
  mediador-debate → mapa de fatos e disputas (sem conclusão — preserva independência dos juízes)

Fase 3   (paralelo — evidência assimétrica por juiz, anti-herding):
  Juiz 1 (Pragmático)  → lê grupo-alpha/ primeiro
  Juiz 2 (Conservador) → lê grupo-beta/ primeiro
  Juiz 3 (Ousado)      → lê grupo-ia/ primeiro

Fase 4   (orquestrador):
  Sintetiza 3 perspectivas divergentes → veredito acionável + artifact HTML
```

## Agentes

| Agente | Papel | Chamadas |
|--------|-------|---------|
| `orquestrador` | Menu + coordenação + seleção de finalistas inline | entry point |
| `gerador-prompt` | Gera prompt comparável para IAs externas | 1× |
| `ia-externa` | Analisa e estrutura resposta de IA externa | 0-4× |
| `pesquisador` | Pesquisa independente (alpha=mainstream / beta=contrarian) | 8× |
| `pesquisador-aprofundador` | Navega à fonte real para aprofundar cada finalista | ×N finalistas |
| `mediador-debate` | Mapa de fatos e disputas — sem conclusão | 1× |
| `juiz` | Veredito independente com evidência primária diferente por persona | 3× |

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
├── grupo-alpha/      # Pesquisas da Equipe Alpha (mainstream)
├── grupo-beta/       # Pesquisas da Equipe Beta (contrarian)
├── grupo-ia/         # Análises das IAs externas
├── funil/            # Seleção de finalistas + perfis aprofundados
├── grupo-c/          # Mapa de divergências + preferências do usuário
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
