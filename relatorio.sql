select bud.id as pedido_id,
bud.client_id,
bud.employee_id,
bud.user_id,
bud.cod_name,
bud.value,
bud.discount_items,
bud.discount,
bud.discount_type,
bud.value_with_discount,
bud.status,
bud.created_at at time zone 'utc' at time zone 'brt' as criado_em,
bud.deadline at time zone 'utc' at time zone 'brt' as Entrega,
(Select employees.name from employees where employees.id = u.employee_id) as gerado_por,
empl.name as funcionario,
cli.company_name,
cli.fantasy_name
from budgets as bud
left join employees as empl on empl.id = bud.employee_id
left join clients as cli on cli.id = bud.client_id
left join users as u on u.id = bud.user_id
where bud.deleted_at is null

select
stock.id,
ra.name,
ra.amount,
ra.weight,
count(stock.raw_material_id) as Entradas,
stock.weight as peso_entrada,
stock.price,
stock.created_at at time zone 'utc' at time zone 'brt' as criado_em
from stock_raw_materials as stock
left join raw_materials as ra on ra.id = stock.raw_material_id
where ra.deleted_at is null and stock.deleted_at is null
group by
ra.name,
ra.amount,
ra.weight,
stock.id,
stock.weight,
stock.created_at,
stock.price