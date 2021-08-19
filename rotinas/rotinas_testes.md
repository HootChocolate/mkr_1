### Rotinas
### Ver onde são adicionadas mensagens no data de response para validação so testes de api rest com o postman;

# Qualificação - Ok (Final do dia)

# Apuração (Prévia): Ok
- Não deve acontecer a distribuição de bônus para inativos e não qualificados;
- Não deve receber bônus de graduação quem estiver inativo;

# Apuração (Apuração) (Qualificado) (Mensal?(Doc de spv)): 
*Para apurar um cliente rode a rotina de qualificação também*
Cliente utilizado qua4

SQL:
- Verifica o status_penn do cliente;
- Data de aprovação do pagamento do pedido
- Olha no mkr_extrato_bonificacao a data_movimento que seja entre a data inicial e a data final;
	- O status seja diferente de Cancelado;
	- O tipo de movimento seja Prévia;
	- E que exita informação de id_pais do usuário;


Na mkr_extrato_bonificacao pega a data_movimento 


# Cancelamento:(ATIVACAO):
- O status vai se passar a ser cancelado quando em 20 dias não houver alterações no cadastro (Verificar qual campo será observado p/ calculo de tempo)((Depois de ficar cancelado, o atendente filial pode voltar o cara no fluxo, maanualmennte);


- Verificar se o filial vai conseguir retornar o cliente ao fluxo;
	- Após iniciar o cadastro de um cliente D.A, a partir da data de início de cadastro se não houver nenhuma alteração no período de 20 dias o status do cadastro passa a ser cancelado.
SQL:
mkr_status_cliente status
mkr_documento docto (Entidade 'Cliente')
mkr_log_entidade - max(dh_registro)
mkr_log_entidade_campo  - status

# Ativação: Ok
	+ Cliente: ativacao2
	- Pontos realizados nos últimos 180 dias > 1.1 (uma compa ou mais);
	- Devem ser desativados clientes que não adquiriram produtos nos últimos 6 meses , ou o valor dos pontos dos produtos adquiridos seja meno do que 1.1 ( Um ponto) (uma compa ou mais): 
	Data da última compra >= 6 meses ou 
	Pontos totais dos últimos 6 meses < 1

-- SQL:
Precisa do id_pais;
mkr_hub_ped_venda_pgto - dh_aprovacao 
mkr_hub_pedido_venda_compl - quantidade de pontos
order by cliente.id

# Desativação (Status penn) Ok
* Devem ser desativados clientes que não adquiriram produtos nos zúltimos 180 dias, OU o valor dos pontos dos produtos adquiridos seja menor do que 1 (180 dias), levando em consideração a data de registro do status penn dos ultimos 180 dias;*
- O status_penn deve ter sido alterado a mais de 180 dias atrás;
- Qual é o período que é redistriubido o spv dos pedidos do cliente que está sendo desativado?

A rotina de desativação está desativando quando a data do status penn for maior que 180 dias(sem nenhum pedido nos ultimos 180 dias) ou quando nos últimos 180 dias a quantidade de pontos for menor que 1


# Graduação:
 * Diarias para ciclo de cotas / Mensal para graduação *
- Faz a comparação dos pontos do período e valor necessário da cota de graduação.
	 Se a 	cota foi atingida o registro no histórico de graduação é gravado com a opção “Graduando = True”,
	 e cota 1 = true. 
	Caso não atingida a cota, não é gerado registro na classe histórico de graduação.  

	- Cota 01: 20 pontos na rede;
	- Cota 02: 20 pontos na rede;
	- Pontos Individuais: Ultimos 2 meses os pontos individuais >= 6

+++ Tabelas Para alteração:::::

select * from mkr_pessoa where nome = 'PAI_' -- 480
select * from mkr_cliente where id_pessoa = 480
select * from mkr_extrato_bonificacao where id_hub_pedido_venda = 991
select * from mkr_hub_ped_venda where numero = 'PED00927' -- 992
select * from mkr_hub_ped_venda_item where id_hub_ped_venda = 992 -- 5065
select * from mkr_hub_ped_venda_item_compl where id_hub_pedido_venda_item = 5065
select * from mkr_extrato_bonificacao where id_hub_pedido_venda = 992
select * from mkr_categoria_bonus
select * from mkr_hub_ped_venda_pgto where id_hub_ped_venda = 992
select * from mkr_hub_ped_venda_entrega where id_hub_ped_venda = 991

update mkr_hub_ped_venda_item_compl set pontos = 20.5 where id_hub_pedido_venda_item = 5065
update mkr_hub_ped_venda_entrega set dh_atualizacao = '2020-10-24 09:45:29' where id_hub_ped_venda = 992
update mkr_hub_ped_venda_entrega set dh_registro = '2020-10-24 09:45:29' where id_hub_ped_venda = 992
update mkr_hub_ped_venda_pgto set dh_aprovacao = '2020-10-24 09:45:29' where id = 897
update mkr_hub_ped_venda_pgto set data_pagamento = '2020-10-24 09:45:29' where id = 897
update mkr_hub_ped_venda_pgto set dh_atualizacao = '2020-10-24 09:45:29' where id = 897
update mkr_hub_ped_venda_pgto set dh_registro = '2020-10-24 09:45:29' where id = 897
update mkr_hub_ped_venda_status set dh_aprovacao = ''
update mkr_hub_ped_venda set dh_inclusao_pedido = '2020-10-24 09:45:29' where numero = 'PED00927'
update mkr_hub_ped_venda set dh_alteracao = '2020-10-24 09:45:29' where numero = 'PED00927'
update mkr_hub_ped_venda set dh_registro = '2020-10-24 09:45:29' where numero = 'PED00927'
update mkr_extrato_bonificacao set data_movimento = '2020-10-24 09:45:29' where id_hub_pedido_venda = 992
update mkr_extrato_bonificacao set dh_registro = '2020-10-24 09:45:29' where id_hub_pedido_venda = 992
update mkr_extrato_bonificacao set dh_alteracao = '2020-10-24 09:45:29' where id_hub_pedido_venda = 992
update mkr_extrato_bonificacao set id_tipo_movimento = 2 where id_hub_pedido_venda = 992































select me.id id_entrevista,p.nome,me.dh_registro
from mkr_entrevista me, mkr_cliente c,mkr_pessoa p
where p.id = c.id_pessoa and me.id_consultor = c.id 
  and me.expirado = false 
  and (
 exists (select 1 from mkr_usuario_cliente uc where uc.id_cliente = me.id_entrevistador and uc.id_usuario = :id_usuario) or 
 exists (select 1 from mkr_usuario u where u.id = :id_usuario and u.ADMINISTRATIVO = true )
)
  and current_timestamp between me.dh_inicio and me.dh_fim  














select me.id id_entrevista,p.nome,me.dh_registro
from mkr_entrevista me, mkr_cliente c,mkr_pessoa p
where p.id = c.id_pessoa and me.id_consultor = c.id 
  and me.expirado = false 
  and (
 exists (select 1 from mkr_usuario_cliente uc where uc.id_cliente = me.id_entrevistador and uc.id_usuario = :id_usuario) or 
 exists (select 1 from mkr_usuario u where u.id = :id_usuario and u.ADMINISTRATIVO = true )
)
  and current_timestamp between me.dh_inicio and me.dh_fim  