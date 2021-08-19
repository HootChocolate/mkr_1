select * from mkr_pessoa mp where nome = 'ATV_FILHO_1'
select * from mkr_cliente mc where id_pessoa = 20758 -- 9476
select * from mkr_cliente_dados_comerciais mcdc where id_cliente = 9476
select * from mkr_cliente_dados_comerciais where id_consultor = 9476
select * from mkr_cliente_qualificacao mcq where id_cliente  = 9476
select * from mkr_acao_status_cliente_disparo mascd where id_cliente = 9476
select * from mkr_entrevista me where id_consultor = 9476
select * from mkr_venda_vinculo mvv where id_consultor = 9476
select * from mkr_pessoa_dados_bancarios mpdb where id_pessoa = 20758
select * from mkr_pessoa_email mpe where id_pessoa = 20758
select * from mkr_pessoa_fisica mpf where id_pessoa = 20758

delete from mkr_pessoa_fisica where id_pessoa = 20758
delete from mkr_pessoa_telefone where id_pessoa = 20758
delete from mkr_pessoa_endereco where id_pessoa = 20758
delete from mkr_pessoa_email where id_pessoa = 20758
delete from mkr_pessoa_dados_bancarios where id_pessoa = 20758
delete from mkr_venda_vinculo where id_consultor = 9476
delete from mkr_entrevista where id_consultor = 9476
delete from mkr_acao_status_cliente_disparo where id = 381
delete from mkr_cliente_qualificacao where id = 8224
delete from mkr_cliente_dados_comerciais where id = 7158
delete from mkr_cliente_dados_comerciais where id = 7159
delete from mkr_cliente where id_pessoa = 20758
delete from mkr_pessoa where id = 20758

