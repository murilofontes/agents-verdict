# Agents Verdict

Sistema reutilizável de pesquisa multi-agente com debate e veredito validado. Funciona com qualquer tema.

## Instalação do skill (Claude Code)

```bash
git clone https://github.com/murilofontes/agents-verdict
cd agents-verdict
./install-skill.sh
# depois, no Claude Code:
# /reload-skills
```

O skill fica disponível globalmente como `agents-verdict` e é ativado automaticamente quando você pede pesquisa com múltiplas IAs.

## Como usar

Abra Claude Code neste diretório e invoque o orquestrador:

```
@orquestrador
```

O menu interativo guia todo o fluxo.

## Fluxo resumido

```
1. Novo tema → gera prompt padronizado para copiar nas IAs externas
2. Colar resposta (repita 4x, uma por IA externa)
3. Rodar pipeline → executa pesquisa + debate + veredito automaticamente
4. Ver relatório final
```

## Agentes

| Agente | Papel |
|--------|-------|
| `orquestrador` | Menu principal + coordenação |
| `gerador-prompt` | Gera prompt comparável para IAs externas |
| `ia-externa` | Analisa e estrutura resposta de IA externa (chamado 4×) |
| `pesquisador` | Pesquisa independente por foco (chamado 4×: relatos, oficial, mercado, riscos) |
| `mediador-debate` | Mapa de convergências e divergências |
| `juiz` | Veredito independente com justificativas (chamado 2×) |

## Estrutura de outputs

```
outputs/
├── grupo-a/          # Análises das IAs externas
├── grupo-b/          # Pesquisas independentes
├── grupo-c/          # Mapa de divergências
├── final/            # Vereditos + relatório final
└── historico/        # Temas anteriores arquivados
```

## Reusar para outro tema

Use a Opção 1 do menu. O sistema perguntará se quer arquivar o tema anterior antes de começar.

## Critérios de avaliação

Ver `criterios/avaliacao.md` — escala de confiança e sinais de baixa confiabilidade usados por todos os agentes.
