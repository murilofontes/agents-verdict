#!/bin/bash
# Limpa todos os outputs de execuções anteriores, preservando .gitkeep
set -e

DIRS=(
  outputs/grupo-alpha
  outputs/grupo-beta
  outputs/grupo-ia
  outputs/funil
  outputs/grupo-c
  outputs/final
)

for dir in "${DIRS[@]}"; do
  find "$dir" -type f ! -name ".gitkeep" -delete 2>/dev/null || true
done

# Reset estado
cat > estado/estado-atual.md << 'EOF'
tema: ""
data_inicio: ""
tipo_tema: ""
ias_coladas: []
pipeline_executado: false
EOF

echo "✅ Cache limpo."
