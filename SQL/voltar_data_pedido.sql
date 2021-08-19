select * from mkr_pessoa where nome like 'RAUL SILVA'
select * from mkr_cliente where id_pessoa = 34584 
select * from mkr_hub_ped_venda where numero = 'PED02561'
select * from mkr_cliente_qualificacao where id_cliente = 23002

update mkr_hub_ped_venda set dh_alteracao = '2021-02-23 00:00:10' where numero = 'PED02216'
update mkr_hub_ped_venda set dh_finalizacao_pedido = '2021-02-23 00:00:10' where numero = 'PED02216'
update mkr_hub_ped_venda set dh_inclusao_pedido = '2021-02-23 00:00:10' where numero = 'PED02216'
update mkr_hub_ped_venda set dh_registro = '2021-02-23 00:00:10' where numero = 'PED02216'

update mkr_hub_ped_venda_pgto set dh_aprovacao = '2021-02-23 00:00:10' where id_hub_ped_venda = 7954 
update mkr_hub_ped_venda_pgto set data_pagamento = '2021-02-23 00:00:10' where id_hub_ped_venda = 7954 
update mkr_hub_ped_venda_pgto set dh_atualizacao = '2021-02-23 00:00:10' where id_hub_ped_venda = 7954
update mkr_hub_ped_venda_pgto set dh_registro = '2021-02-23 00:00:10' where id_hub_ped_venda = 7954
update mkr_hub_ped_venda_item set dh_atualizacao = '2021-02-23 00:00:10' where id_hub_ped_venda = 7954
update mkr_hub_ped_venda_item set dh_atualizacao = '2021-02-23 00:00:10' where id_hub_ped_venda = 7954
