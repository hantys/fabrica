- falar com pablo sobre o layout
- otimizar desempenho das paginas do sistema
- criar template para auditoria

TO DO
	https://github.com/mbuckbee/Web-To-Pdf-Gem
- Revisar todos os index das paginas e alterar links e botoes
- Botao novo em todos os shows
- Criar relatorio de orcamentos

- Produtos criar categorias
- quando pagar possibilidade de juros
- pagamentos multiplos e pagina de anexo
- Reservar orcamento completo
- Cadastro de inventario
- Criar sistema de viagens com vinculacao aos orcamentos

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

- TODOS OS  ORÇAMENTOS:
	* RELATÓRIO DO  DOS ORÇAMENTOS  (GERAL),  COM EXPORTAÇÃO  PRO EXCEL COM DADOS DO  CLIENTE


DONE
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