# Guia para agentes de IA — Fábrica

## Visão geral

Este é um monólito Ruby on Rails para gestão de produção, estoque, clientes,
fornecedores e contas a pagar/receber. É uma aplicação legada: preserve a
compatibilidade com Ruby 2.5.3, Rails 5.2.1 e Webpacker 3.

- Backend: Rails, PostgreSQL, Devise, CanCanCan, Ransack e Sidekiq.
- Frontend: ERB, Sass, jQuery/Bootstrap e componentes React 16 pontuais.
- O projeto não possui suíte de testes automatizados.
- Background jobs: Sidekiq e `sidekiq-scheduler`.

## Estrutura do código

- `app/models/`: regras de domínio, associações, validações e persistência.
- `app/controllers/`: endpoints e coordenação da requisição; mantenha a regra
  de negócio nos modelos ou extraia um objeto dedicado quando necessário.
- `app/views/`: templates ERB e layouts.
- `app/jobs/`: tarefas assíncronas. Os jobs financeiros agendados estão em
  `config/sidekiq.yml`.
- `config/routes.rb`: rotas REST e rotas de fluxo de negócio.
- `db/migrate/`: alterações de esquema, sempre por migrations.

## Ambiente local

O ambiente recomendado é Docker Compose. A aplicação fica em
`http://localhost:3000`.

```bash
make build       # cria as imagens
make start       # inicia aplicação, PostgreSQL e Redis em primeiro plano
make stop        # encerra os serviços
make create      # cria os bancos
make migrate     # aplica migrations
make console     # abre o Rails console no container
make bash        # abre um shell no container da aplicação
```

Antes de alterar dependências, confirme a compatibilidade com as versões
fixadas em `Gemfile`, `Gemfile.lock`, `package.json` e no `Dockerfile`.
Não atualize Ruby, Rails, Node, Bundler ou dependências em massa como efeito
colateral de uma tarefa.

## Convenções de alteração

1. Leia os arquivos relacionados antes de editar.
2. Para novos recursos persistentes, crie uma migration e atualize o modelo.
3. Preserve os contratos das rotas existentes, especialmente as rotas
   financeiras e de estoque que usam verbos HTTP e paths não convencionais.
4. Ao alterar jobs, mantenha processamento idempotente, tratamento de
   registros inexistentes e cuidado com reexecuções do scheduler.
5. Valide manualmente as mudanças de forma focalizada no ambiente local.
6. Não adicione ferramentas de teste, lint, formatadores ou novas dependências sem
   necessidade explícita.

## Padrão de desempenho para páginas de listagem

Ao criar ou alterar páginas que possam exibir listas grandes:

1. Nunca carregue a coleção completa. Entregue no máximo 50 registros por
   requisição usando paginação no banco (`page(...).per(50)`).
2. Faça filtros e ordenação no banco. A busca pelos demais registros deve usar
   requisições AJAX e atualizar somente o bloco de resultados, sem recarregar a
   página inteira.
3. Campos de seleção com coleções grandes devem usar autocomplete remoto com
   atraso de aproximadamente 250 ms. O endpoint deve aplicar autorização,
   selecionar apenas as colunas necessárias com `pluck` e limitar a resposta a
   50 opções. Nunca use `Model.all`, `map` ou uma coleção completa dentro da
   view para montar esses campos.
4. Preserve o valor selecionado ao reabrir um filtro ou formulário, carregando
   somente o registro correspondente.
5. Antecipe associações exibidas na lista com `includes`, `preload` ou
   `eager_load` no controller para evitar consultas N+1.
6. Extraia a tabela e a paginação para uma partial reutilizada pela resposta
   HTML e pela resposta AJAX. Mostre estado de carregamento e trate respostas
   vazias sem bloquear a interface.
7. Antes e depois da alteração, confira tempo de resposta, consultas SQL,
   quantidade de registros e tamanho do HTML. Só adicione índices por migration
   quando os filtros e o plano da consulta demonstrarem essa necessidade.

## Segurança e operações

- Nunca exponha, replique ou adicione credenciais, URLs com senha, tokens ou
  chaves em código, documentação ou commits. Use variáveis de ambiente.
- Não execute comandos destrutivos de banco (`db:drop`, `db:reset`, limpeza de
  dados) sem solicitação explícita.
- Não faça deploy nem altere a configuração de produção sem autorização
  explícita.
- O Compose atual inicia Rails, PostgreSQL e Redis, mas não um processo
  Sidekiq. Ao validar um job localmente, inicie e verifique o worker
  separadamente.

## Validação final

Após mudanças de comportamento, valide manualmente o fluxo afetado no ambiente
local. Em alterações de banco, aplique as migrations no ambiente de
desenvolvimento e confirme que o schema foi atualizado apenas pelo mecanismo de
migration.
