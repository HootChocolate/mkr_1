##Regras:
Devem ser desativados clientes que não adquiriram produtos nos últimos 6 meses, ou o valor dos pontos dos produtos adquiridos seja menor do que 1 ( Um ponto).
Assim: 
	Data da última compra >= 6 meses ou 
	Pontos totais dos últimos 6 meses < 1      

Caso um DI seja desativado, a rotina deverá verificar na conta-corrente todos os pedidos que possuem o código deste DA, e este pedidos deverão ter a Rotina bônus/SPV executada novamente (Gerar extorno - SPV(DEB)).

#Desativação por data:
- Caso tenha compras com datas próximas, volte elas pra bastante tempo atrás;
- Certifique-se que o status do cliente KVN10 esteja ativo;
- Realize uma compra com o usuário KVN10 com MENOS de 4.800.00;
- Pague o produto;
- Rode a prévia;
- Depois da rotina rodar, mude o status do pedido de Prévia para apuração e a data de aprovação do pedido para menos de 6 meses;
- Adicione os valores no cenário acima;

# Desativação por pontos:
- Certifique-se que o status do cliente DES_3_1_1 esteja ativo;
- Caso tenha compras com datas próximas, volte elas pra bastante tempo atrás e data de apuração;
- Realize uma compra com o usuário DES_3_1_1 que seja menor que R$ 4.800,00;
- Pague o produto;
- Rode a prévia;
- Depois da rotina rodar, mude o status do pedido de Prévia para apuração e mude a data de aprovação do pedido para menos 6 e um dia atrás;

##Validações:
Desativou?
Redistribuiu os pontos?
Fez a redistribuição dos pontos e do crédito?


update mkr_hub_ped_venda mhpv set dh_alteracao = '2020-09-10 00:50:00' where numero = 'PED02684'
update mkr_hub_ped_venda mhpv set dh_finalizacao_pedido = '2020-09-10 00:50:00' where numero = 'PED02684'
update mkr_hub_ped_venda mhpv set dh_inclusao_pedido = '2020-09-10 00:50:00' where numero = 'PED02684'
update mkr_hub_ped_venda mhpv set dh_registro = '2020-09-10 00:50:00' where numero = 'PED02684'

update mkr_hub_ped_venda_pgto set dh_aprovacao = '2020-09-10 00:50:00' where id_hub_ped_venda = 8423
update mkr_hub_ped_venda_pgto set data_pagamento = '2020-09-10 00:50:00' where id_hub_ped_venda = 8423
update mkr_hub_ped_venda_pgto set dh_atualizacao = '2020-09-10 00:50:00' where id_hub_ped_venda = 8423
update mkr_hub_ped_venda_pgto set dh_registro = '2020-09-10 00:50:00' where id_hub_ped_venda = 8423
