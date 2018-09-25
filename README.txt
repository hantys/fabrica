- falar com pablo sobre o layout
- otimizar desempenho das paginas do sistema
- criar template para auditoria

TO DO
	https://github.com/mbuckbee/Web-To-Pdf-Gem
- Revisar todos os index das paginas e alterar links e botoes
- Botao novo em todos os shows
- Criar relatorio de orcamentos

- puxar categoria/faturamento do contrato com fornecedor
- puxa banco do fornecedor

- Cadastro de inventario
- Criar sistema de viagens com vinculacao aos orcamentos
- Bloquear cliente opcao
- Gerar varias ordem de pedido

- Transferencia de valores
- credito/debito de banco

- RELATÓRIOS
	1.0 – FATURAMENTO
		1.1 VALOR VENDIDO POR PERIODO - ok
		1.2 VALOR FATURADO POR PERIODO - ok
		1.3 VALOR RECEBIDO POR PERIODO - ok

	2.0 – PEDIDOS
		2.1 QUAIS PEDIDOS FALTAM FATURAR - ok
		2.2 RESUMO DE RESULTADO DOS PEDIDOS POR PERIODO, DESPESA E RECEITA. - pensar como fazer no sistema ou no data studio e linkar com o sistema
		2.3 RESUMO DE PEDIDOS POR CLIENTES (HISTORICO GERAL ENVOLVENDO PARCELAS DE CONTAS Á RECEBER) - pensar como fazer no sistema ou no data studio e linkar com o sistema

	3.0 – DOS PRODUTOS
		3.1 TOTAL DE PRODUÇÃO POR PERIODO - ok
		3.2 CUSTO DE PRODUÇÃO DOS PRODUTOS (COM MÉDIA) - ok
		3.3 % DE LUCRO BRUTO DOS PRODUTOS. - pergunta como e

	4.0 – DA MATERIA PRIMA - todos no data studio
		4.1 SALDO DE MATERIA PRIMA
		4.2 QUANTIDADE DE MATERIA PRIMA EXTRUSSADA POR PERIODO

	5.0 DO CONTAS Á RECEBER
		5.1 VALOR Á RECEBER VENCIDO E VICENDOS
		5.2 PREVISÃO DE RECEBIMENTO (TABELA COM JUROS)
		5.3 CONTAS Á RECEBER VENCIDO E VICENDO POR REPRESENTANTE
		5.4 CONSULTA DO CLIENTE (MOSTRA SE O CLIENTE TEM ALGUM BLOETO VENCIDO E HISTÓRICO

	6.0 DO CONTAS Á PAGAR
		6.1 VALOR TOTAL Á PAGAR E PAGO POR PERIODO

	7.0 DOS REPRESENTANTES - todos no data studio criar link para pedido
		7.1 VALOR TOTAL VENDIDO / FATURADO POR REPRESENTANTE.


DONE
- Saldo de conta em bancos
- Contas a receber juros
- Faturar pedido direciona para contas a receber
- Criar Contas a receber  bill_receivable
	* tipo
		º orcamento
			- orcamento_id
		° outros
			- nome
			- cpf/cnpj
			- phone
			- obs
	* categoria
	* faturamento
	* anexo
	* parcelas
		º banco
		º anexo
		º data
		º valor
		º status
	* status
	* total pago (ex: R$200,00 de R$1000,00)
- pagamentos multiplos e pagina de anexo
- revisar textos dos controller em criar/atualizar/deletar
- Reservar orcamento completo
- quando pagar possibilidade de juros
- Produtos criar categorias
- validacoes de contas a pgar e contrato com fornecedor referentes ao valor
- alterar contas a pagar nao herda de pedidos
- Ordem de serviço (igual ao gerar pdf so que sem valores)
- Muda nome orcamento p pedidos
- Criar Contas a Pagar - bill_payable_ installment
	* Contrato com fornecedor
		° nome
		° fornecedor
		° obs
		° valor total
		° valor restante
		° orcamentos
			- valor parcial
	* select contrato com fornecedor
	* status
	* categoria
	* faturamento
	* obs
	* anexo
	* total pago (ex: R$200,00 de R$1000,00)
	* parcelas
		º boleto
			- codigo titulo/convenio (ideia de mascara contar por quantidade de caracter titulo: 47, convenio: 48)
		º transferencia
			- banco
			- ag
			- conta
			- variacao
			- banco de saida
		º cartao de credito (criar cadastro de cartao)
			- nome
			- final (limit 4)
			- vencimento
		º anexo
		º data
		º valor


- Add obs quando for autorizar
* Tirar confidencial do nacional
* Busca na producao diaria
- relacao de produtos a serem produzidos
- paginacao
- foco do login
- criar reserva no budget_product
- corrigir edicao do orcamento
- retorno da borra como pvc e calcular seu valor apartir do custo da borra
- adicionar um status, confirmado para o representante
- na entrada de porduto final por materia prima, deixar entrada de peso dos tubos e calcular a borra
- composto nao e produto final, ele e igual a lista dos itens do orcamento
	* fazer alteracao no sistema para produto final
- forma de pagamento criar item e sub item
- implementar biblioteca paranoia
- TODOS OS  ORÇAMENTOS:
	* STATUS  DO  ORÇAMENTO (AGUARDANDO AUTORIZAÇÃO / AUTORIZADO  / REPROVADO / FATURADO  / ENTREGUE)
	* DATA  DE  CRIAÇÃO
- criar auditoria
- criar mascaras
- add select2 no item do orcamento
- puxar endereco apartir do cep
- criar regra de usuarios para determinar suas autorizacoes
- gerar orcamento igual o enviado no pdf
- revisar textos em ingles nos controllers do sistema
- alterar desconto por item: desconto deve ser em cima do valor unitario