#!/usr/bin/env bash
# Instalador do kit de desenvolvimento profissional do Career Gap.
#
# Mostra o que existe, pergunta o que você quer e roda só os comandos `claude plugin ...`
# correspondentes. Não usa sudo, não mexe em arquivo seu e não instala nada sem você marcar.
#
#   bash <(curl -fsSL https://raw.githubusercontent.com/EnzoAraujoDuarte/kit-career-gap/main/install.sh)
#
# Com --simular, só imprime os comandos que rodaria.

set -euo pipefail

SIMULAR=0
[[ "${1:-}" == "--simular" ]] && SIMULAR=1

KIT_URL="https://github.com/EnzoAraujoDuarte/kit-career-gap"

negrito() { printf '\033[1m%s\033[0m\n' "$*"; }
apagado() { printf '\033[2m%s\033[0m\n' "$*"; }

rodar() {
  if [[ $SIMULAR -eq 1 ]]; then
    apagado "  (simulação) $*"
  else
    apagado "  $*"
    "$@"
  fi
}

# Cada item: nome | o que é, em uma linha | quando rende | comandos separados por ';;'
ITENS=(
  "Kit essencial (regras + skills pr, depurar, decisao, passagem + agente revisor + Context7)|Regras de código, testes, git e trabalho com IA carregadas em toda sessão; o assistente faz a menor mudança, mostra o que rodou e pede aprovação antes de apagar ou publicar.|Quando você já versiona com git e já usa um assistente com critério.|claude plugin marketplace add $KIT_URL;;claude plugin install essencial@kit-career-gap --scope user"
  "superpowers|Biblioteca de skills e um método de trabalho: brainstorming antes de codar, teste primeiro, depuração sistemática, planos em passos pequenos.|Quando você já sabe o que é um bom teste e já depura sozinho.|claude plugin install superpowers@claude-plugins-official --scope user"
  "impeccable|Skill de design: audita contraste, hierarquia, estados, responsivo e os clichês de interface gerada, e lapida o que achou.|Quando você já monta uma página e sabe o que é um layout bom.|claude plugin marketplace add pbakaus/impeccable;;claude plugin install impeccable@impeccable --scope user"
  "frontend-design (Anthropic)|Skill que força direção visual, tipografia e hierarquia deliberadas em vez da interface genérica.|Quando você já monta uma página com CSS.|claude plugin install frontend-design@claude-plugins-official --scope user"
  "skill-creator (Anthropic)|Skill para escrever e testar as suas próprias skills: a tarefa recorrente do seu jeito.|Quando você já tem uma tarefa que repete toda semana.|claude plugin install skill-creator@claude-plugins-official --scope user"
)

echo
negrito "Kit de desenvolvimento profissional · Career Gap"
echo "Para quem já começou a criar alguma coisa. Marque o que quer; nada é instalado sem você pedir."
echo

if ! command -v claude >/dev/null 2>&1; then
  negrito "O Claude Code não está instalado neste computador."
  echo "Instale primeiro, com o comando oficial, e depois rode este instalador de novo:"
  echo
  echo "  macOS, Linux e WSL:   curl -fsSL https://claude.ai/install.sh | bash"
  echo "  Windows (PowerShell): irm https://claude.ai/install.ps1 | iex"
  echo
  echo "Guia completo: https://code.claude.com/docs/en/quickstart"
  exit 1
fi

for i in "${!ITENS[@]}"; do
  IFS='|' read -r nome oque quando _ <<<"${ITENS[$i]}"
  printf '  %d. ' "$((i + 1))"; negrito "$nome"
  echo "     $oque"
  apagado "     Rende: $quando"
  echo
done

echo "Digite os números separados por espaço (ex.: 1 3), 't' para tudo ou Enter para sair."
# Lê do terminal mesmo quando o script chega por `bash <(curl …)`; sem terminal, lê da entrada.
if { exec 3</dev/tty; } 2>/dev/null; then :; else exec 3<&0; fi
printf '> '
read -r -u 3 escolha || escolha=""

[[ -z "$escolha" ]] && { echo "Nada instalado. Até a próxima."; exit 0; }
if [[ "$escolha" == "t" || "$escolha" == "T" ]]; then
  escolha=$(seq -s ' ' 1 "${#ITENS[@]}")
fi

falhas=0
for n in $escolha; do
  if ! [[ "$n" =~ ^[0-9]+$ ]] || (( n < 1 || n > ${#ITENS[@]} )); then
    echo "Ignorando '$n': não é um item da lista."
    continue
  fi
  IFS='|' read -r nome _ _ comandos <<<"${ITENS[$((n - 1))]}"
  echo
  negrito "$nome"
  IFS=';;' read -r -a lista <<<"$comandos"
  for cmd in "${lista[@]}"; do
    [[ -z "$cmd" ]] && continue
    # shellcheck disable=SC2086
    if ! rodar $cmd; then
      echo "  Este passo falhou. O resto continua; depois rode o comando acima à mão para ver o erro."
      falhas=$((falhas + 1))
    fi
  done
done

echo
if (( falhas > 0 )); then
  negrito "Terminou com $falhas passo(s) com erro."
else
  negrito "Pronto."
fi
echo "Abra uma sessão nova do Claude Code, ou rode /reload-plugins na que está aberta."
echo "Num projeto seu, copie modelos/projeto/AGENTS.md do kit para a raiz e preencha: $KIT_URL"
