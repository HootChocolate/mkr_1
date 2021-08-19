-- CLIENTE: 59630 | PESSOA: 123144  | Usuario: 
select * from mkr_cliente mc2 where id = 59630
--select * from mkr_pessoa mp
--select * from mkr_usuario_cliente muc where id_cliente = 59630
select * from mkr_cliente_dados_comerciais mcdc where id_cliente = 59630
select * from mkr_acao_status_cliente_disparo where  id_cliente = 59630
select * from mkr_cliente_anotacao mca where id_cliente = 59630
--select * from mkr_gestao_contrato_cliente where id_cliente = 59630
--select * from mkr_contrato_cliente where id_gestao_contrato_cliente = 56
--select * from mkr_pessoa_dados_bancarios where id_pessoa = 123144
select * from mkr_pessoa_documento where id_pessoa = 123144
--select * from mkr_pessoa_email where id_pessoa = 123144
--select * from mkr_pessoa_endereco where id_pessoa = 123144
select * from mkr_pessoa_juridica where id_pessoa = 123144
--select * from mkr_pessoa_telefone mpt where id_pessoa = 142904
--select * from mkr_usuario mu where id_pessoa = 123144
--select * from mkr_sessao ms where id_usuario = 
--select * from mkr_perfil_usuario mpu where id_usuario = 8354
--select * from mkr_pessoa_socio mps where id_socio = 123144
--select * from mkr_ws_log mwl where id_usuario = 703
--select * from mkr_cliente_qualificacao mcq where id_cliente = 59630
--select * from mkr_hub_ped_venda mhpv where id_pessoa = 123144
--select * from mkr_hub_ped_venda mhpv 
--select * from mkr_log_entidade mle 

--delete from mkr_ws_log mwl where id_usuario = 703
--delete from mkr_cliente_qualificacao mcq where id_cliente = 59630
--delete from mkr_usuario_cliente muc where id_cliente = 59630
--delete from mkr_cliente_dados_comerciais mcdc where id_cliente = 59630
--delete from mkr_acao_status_cliente_disparo where  id_cliente = 59630
delete from mkr_cliente_anotacao mca where id_cliente = 59630
--delete from mkr_gestao_contrato_cliente where id_cliente = 59630
--delete from mkr_contrato_cliente where id_gestao_contrato_cliente = 56
--delete from mkr_cliente mc where id_pessoa = 123144
--delete from mkr_pessoa_dados_bancarios where id_pessoa = 142906
--delete from mkr_pessoa_documento where id_pessoa = 123144
--delete from mkr_pessoa_email where id_pessoa = 142906
--delete from mkr_pessoa_endereco where id_pessoa = 142906
--delete from mkr_pessoa_juridica where id_pessoa = 123144
--delete from mkr_pessoa_telefone mpt where id_pessoa = 142906
--delete from mkr_usuario mu where id_pessoa = 142906
--delete from mkr_perfil_usuario mpu where id_usuario = 703
--delete from mkr_sessao ms where id_usuario = 703
delete from mkr_pessoa where id = 123144
delete from mkr_pessoa_socio mps where id_pessoa = 123144

select * from mkr_pessoa_socio mps where id_pessoa = 142906

--- DELETAR O SOCIO: (REMOVE PELO ID DO SÓCIO): 139028
delete from mkr_pessoa_socio mps where id_pessoa = 142906
delete from mkr_pessoa where id = 139028
delete from mkr_pessoa_email where id_pessoa = 139028
delete from mkr_pessoa_documento where id_pessoa = 139028
delete from mkr_pessoa_endereco where id_pessoa = 139028
delete from mkr_pessoa_fisica where id_pessoa = 139028
delete from mkr_pessoa_telefone mpt where id_pessoa = 139028


