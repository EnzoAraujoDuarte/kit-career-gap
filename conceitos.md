# De onde vêm as regras

Nenhuma regra do kit é invenção: cada uma é uma prática com nome, livro e décadas de uso. Esta
página diz qual conceito está por trás de cada grupo de regras e onde ler mais. Serve para
quem quer entender o porquê, e para discordar com argumento.

## Como escrever código

| Conceito | O que diz, em uma frase | Regras | Onde ler |
| --- | --- | --- | --- |
| **Design simples** (Extreme Programming, Kent Beck) | O código passa nos testes, revela a intenção, não duplica e tem o mínimo de peças, nesta ordem | COD-01 | *Programação Extrema (XP) Explicada*, Bookman, 2004; [extremeprogramming.org](http://www.extremeprogramming.org/rules.html) |
| **KISS** (keep it simple) | A solução mais simples que funciona ganha | COD-09, COD-10 | Idem; é a prática "design simples" do XP |
| **YAGNI** (you aren't gonna need it) | Não construa para um futuro imaginado | COD-11 | [Martin Fowler, *YAGNI*](https://martinfowler.com/bliki/Yagni.html) |
| **DRY** (don't repeat yourself) | Cada conhecimento tem uma representação só | COD-15 | *O Programador Pragmático*, Hunt e Thomas, Bookman, 2010; [as dicas do livro](https://pragprog.com/tips/) |
| **Regra de três** | Duplicação só vira abstração na terceira ocorrência | COD-16 | *Refatoração*, Martin Fowler, Novatec, 2020 |
| **Clean Code** (Robert C. Martin) | Nome revela intenção; função faz uma coisa; comentário explica o porquê | COD-17 a COD-23 | *Código Limpo*, Alta Books, 2009 |
| **Linguagem do negócio** (Domain-Driven Design, Eric Evans) | O código usa as palavras de quem usa o sistema | COD-17 | *Domain-Driven Design*, Alta Books, 2016 |
| **Design patterns** (Gamma, Helm, Johnson e Vlissides) | Soluções com nome para problemas que se repetem; só quando o problema aparece | COD-09 | [refactoring.guru, em português](https://refactoring.guru/pt-br/design-patterns) |
| **Conserte a causa** | Sintoma silenciado volta | COD-04 | *O Programador Pragmático*, dica "Conserte o problema, não a culpa" |

## Como verificar

| Conceito | O que diz | Regras | Onde ler |
| --- | --- | --- | --- |
| **Teste primeiro** (XP, TDD) | Escreva o teste que falha, faça passar, limpe | TST-01, TST-03 | *TDD: Desenvolvimento Guiado por Testes*, Kent Beck, Bookman, 2010 |
| **Teste de regressão** | Todo bug corrigido ganha um teste que o pega de novo | TST-03 | Idem |
| **Pirâmide de testes** | Muitos testes rápidos e isolados, alguns pela rota inteira, poucos de ponta a ponta; escolha pelo custo e pela confiança | TST-02 | [Martin Fowler, *The Practical Test Pyramid*](https://martinfowler.com/articles/practical-test-pyramid.html) |

## Como entregar

| Conceito | O que diz | Regras | Onde ler |
| --- | --- | --- | --- |
| **Conventional Commits** | `tipo(escopo): descrição`, lido por gente e por ferramenta | GIT-06, GIT-12 | [conventionalcommits.org, em português](https://www.conventionalcommits.org/pt-br/v1.0.0/) |
| **Mudanças pequenas e integração contínua** (XP) | Integre cedo e várias vezes; um PR que cabe numa sentada | GIT-08, GIT-13 | *Programação Extrema (XP) Explicada* |
| **Revisão em par** (XP, programação em par) | Toda linha é lida por duas pessoas; aqui, uma delas é o revisor | `revisor` | Idem |
| **Configuração fora do código** (Twelve-Factor App) | Senha e chave em variável de ambiente, nunca no repositório | IA-03 | [12factor.net, em português](https://12factor.net/pt_br/) |

## Arquitetura

Dois princípios bastam para quem está começando:

- **Separe o domínio do framework.** As regras do negócio moram em funções e módulos que não
  importam o framework, o banco nem a API de IA, e por isso são testáveis sozinhas. O resto é
  adaptador. É a ideia de *ports and adapters* (arquitetura hexagonal, Alistair Cockburn) e da
  *Arquitetura Limpa* (Robert C. Martin, Alta Books, 2019), na versão mais simples que funciona.
- **Um monólito modular antes de qualquer serviço.** Microsserviços, filas e bancos de grafos
  resolvem problemas de escala que um projeto novo não tem; o custo deles é certo, o ganho não.
  [Martin Fowler sobre microsserviços](https://martinfowler.com/articles/microservices.html).

## Produto

- **Construa a menor coisa que funciona e mostre a alguém.** O *tracer bullet* do Programador
  Pragmático e o produto mínimo viável do *Lean Startup* (Eric Ries, Sextante, 2019) dizem o
  mesmo: uma versão feia de ponta a ponta ensina mais que uma versão bonita de uma parte.
- **Pergunte sobre a vida da pessoa, não sobre a sua ideia.** Quem usa o sistema diz "sim" por
  educação; o que ela faz hoje para resolver o problema é o dado. *The Mom Test*, Rob
  Fitzpatrick, [momtestbook.com](https://www.momtestbook.com/).
- **Prazo fixo, escopo variável.** Decida quanto tempo vale a aposta e corte o escopo para
  caber, não o contrário. *Shape Up*, Basecamp, [basecamp.com/shapeup](https://basecamp.com/shapeup),
  gratuito.

## Ferramentas que acompanham o kit

| Ferramenta | Para quê | Onde |
| --- | --- | --- |
| **Context7** | Documentação atual da biblioteca dentro do assistente, em vez de resposta de versão velha | vem no plugin `essencial`; [upstash/context7](https://github.com/upstash/context7) |
| **ai-memory** | Memória entre sessões e entre agentes: hooks capturam cada sessão, um servidor compila tudo em páginas Markdown versionadas no Git do projeto e a próxima sessão abre com um "de onde paramos", no Claude Code, Codex, Cursor, Gemini CLI e outros. Sem chamar modelo por padrão. Projeto do Fabio Akita, MIT | [akitaonrails/ai-memory](https://github.com/akitaonrails/ai-memory) |
| **impeccable** | Skill de design: audita contraste, hierarquia, estados, responsivo e os clichês de interface gerada | [pbakaus/impeccable](https://github.com/pbakaus/impeccable) |
| **superpowers** | Biblioteca de skills e método de trabalho: brainstorming antes de codar, TDD, depuração sistemática, planos | [obra/superpowers](https://github.com/obra/superpowers) |
| **Skills da Anthropic** | `frontend-design` para interface com personalidade, `skill-creator` para escrever as suas, e as de documento (docx, pdf, pptx, xlsx) | [anthropics/skills](https://github.com/anthropics/skills) |
| **Marketplace oficial** | Plugins mantidos pela Anthropic, do mesmo jeito que este kit se instala | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |
| **AGENTS.md** | O arquivo de instruções do projeto que vários agentes leem, não só o Claude Code | [agents.md](https://agents.md) |

## Sites para calibrar o olho

- **[Awwwards](https://www.awwwards.com/websites/)** — o que o front-end de nível alto faz em
  layout, tipografia e movimento, com os sites de verdade para inspecionar no DevTools.
- **[Mobbin](https://mobbin.com/)** — padrões de interface de produtos reais (login, busca,
  formulário, estado vazio), para decidir como um componente costuma se comportar antes de
  inventar. Plano gratuito com limite.
- **[refactoring.guru](https://refactoring.guru/pt-br)** — padrões de projeto e refatorações
  em português, com exemplos em várias linguagens.
