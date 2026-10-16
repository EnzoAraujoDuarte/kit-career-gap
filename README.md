# Kit de trabalho com IA — Career Gap

Regras de código, skills de trabalho e um agente revisor para quem está começando a programar
com um assistente de IA. Serve a qualquer linguagem e qualquer stack: as regras falam de
intenção, tamanho de mudança, testes, git e de como dividir o trabalho com a IA, não de um
framework.

Esta pasta é um marketplace de plugins do Claude Code. O `AGENTS.md` que o modelo de projeto
cria também é lido por outros agentes (Codex, Cursor, Copilot), então as regras do projeto
valem fora do Claude Code.

## O que vem

| Plugin | Conteúdo |
| --- | --- |
| [`essencial`](plugins/essencial/) | Quatro regras carregadas em toda sessão (código, testes, git, trabalhar com IA); as skills `pr`, `depurar`, `decisao` e `passagem`; o agente `revisor`; e a documentação atual das bibliotecas pelo [Context7](https://context7.com) |

As regras não são invenção: design simples, KISS, DRY e YAGNI do Extreme Programming e do
Programador Pragmático; nomes e comentários do Clean Code; a regra de três de Fowler; padrões
de projeto só quando o problema aparece; Conventional Commits; configuração fora do código.
Cada grupo de regras diz de onde vem, e [`conceitos.md`](conceitos.md) junta tudo, com
arquitetura e produto, e onde ler mais.

## Outras skills e ferramentas que valem

As que o autor usa no trabalho, além do que vem no plugin:

- [impeccable](https://github.com/pbakaus/impeccable): a skill de design com que o Career Gap
  se audita (contraste, hierarquia, estados, responsivo, clichês de interface gerada).
- [superpowers](https://github.com/obra/superpowers): biblioteca de skills e método de trabalho,
  com brainstorming antes de codar, TDD e depuração sistemática.
- [ai-memory](https://github.com/akitaonrails/ai-memory), do Fabio Akita: memória entre sessões e
  entre agentes. Captura cada sessão por hooks, guarda em Markdown versionado no Git do projeto e
  abre a próxima com um "de onde paramos", mesmo trocando de Claude Code para Codex ou Cursor.
  Não é plugin do Claude Code: instala-se com o instalador oficial e `ai-memory setup`.
- [Skills da Anthropic](https://github.com/anthropics/skills): `frontend-design`, `skill-creator`
  e as de documento.
- [Marketplace oficial](https://github.com/anthropics/claude-plugins-official): plugins mantidos
  pela Anthropic, instalados do mesmo jeito que este kit.
- Para calibrar o olho: [Awwwards](https://www.awwwards.com/websites/) e
  [Mobbin](https://mobbin.com/). Detalhes em [`conceitos.md`](conceitos.md).

## Instalar com um comando

Cole no terminal (macOS, Linux ou WSL) e aperte Enter. O instalador lista o que existe, pergunta
os números que você quer e roda só os comandos `claude plugin …` correspondentes. Sem senha, sem
mexer nos seus arquivos; o código está em [`install.sh`](install.sh).

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/EnzoAraujoDuarte/kit-career-gap/main/install.sh)
```

Ele oferece o kit essencial e, do marketplace oficial e do autor de cada uma, as skills
superpowers, impeccable, frontend-design e skill-creator. Para ver o que faria sem instalar nada,
acrescente `--simular`. Se o Claude Code não estiver instalado, ele para e mostra o comando
oficial.

## Instalar à mão

Precisa do Claude Code instalado e de `jq` (vem no macOS 15 em diante; no Linux, `apt install jq`).

1. Registre esta pasta como marketplace, uma vez:

   ```bash
   claude plugin marketplace add https://github.com/EnzoAraujoDuarte/kit-career-gap
   ```

2. Instale o `essencial` para todos os seus projetos:

   ```bash
   claude plugin install essencial@kit-career-gap --scope user
   ```

   A chave do Context7 que ele pede é opcional; deixe vazia se não tiver.

3. Rode `/reload-plugins` na sessão aberta, ou abra uma nova.

4. Num projeto seu, copie `modelos/projeto/AGENTS.md` e `modelos/projeto/CLAUDE.md` para a raiz
   e preencha o que é (uma frase), a stack e os comandos que precisam passar antes de uma
   tarefa contar como pronta. É o mínimo que um assistente não descobre lendo o código.

## Como usar no dia a dia

- Peça a mudança. As regras já estão na sessão: o assistente faz a menor mudança que resolve,
  mostra o comando que rodou e pede aprovação antes de qualquer coisa destrutiva.
- Algo quebrou? `/depurar`. Ele reproduz antes de mexer, e não chuta correção.
- Terminou? `/pr`. Ele cria a branch, commita no formato combinado, envia e abre o pull request
  para você revisar. Nunca junta sozinho.
- Antes de abrir o PR, chame o agente `revisor`: ele lê o diff sem o contexto da conversa e
  relata só o que se sustenta.
- Tomou uma decisão difícil de desfazer? `/decisao` grava um registro curto em `decisoes/`, e
  toda sessão futura vê o índice.
- Vai parar no meio? `/passagem` escreve a nota para a próxima sessão continuar.

## Mudar as regras

`plugins/essencial/regras/` é a fonte. O Claude Code carrega os plugins desta pasta no lugar,
então uma edição vale na próxima sessão ou depois de `/reload-plugins`. Confira com:

```bash
claude plugin validate . --strict
```

Quando uma regra do kit não servir ao seu projeto, diga o contrário no `AGENTS.md` dele: o
projeto manda.

## Estrutura

```text
.
├── .claude-plugin/marketplace.json   # catálogo
├── plugins/essencial/
│   ├── .claude-plugin/plugin.json
│   ├── .mcp.json                     # Context7
│   ├── regras/                       # carregadas em toda sessão
│   ├── skills/                       # pr, depurar, decisao, passagem
│   ├── agents/revisor.md
│   └── hooks/                        # carrega as regras e o índice de decisões
├── install.sh                        # o instalador interativo
├── decisoes/                         # registros de decisão
├── modelos/                          # arquivos iniciais de projeto e o modelo de decisão
└── conceitos.md                      # de onde vem cada regra, e onde ler mais
```

Nasceu dentro do [Career Gap](https://career-gap-tcc.vercel.app), um TCC sobre o que estudar
e construir para a primeira vaga em desenvolvimento web, e é a forma de trabalhar do autor,
reescrita para qualquer pessoa.

## Licença

MIT. Use, adapte e redistribua; mantenha o aviso de copyright.
