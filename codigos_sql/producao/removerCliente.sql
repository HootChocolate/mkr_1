select * from mkr_pessoa where nome = 'MERGLEJ REPRESENTACAO DE TECNOLOGIA DO SONO EIRELI'
select * from mkr_cliente where id_pessoa = 94057 -- 45742
select * from mkr_usuario mu where id_pessoa = 94057
select * from mkr_sessao ms where id_usuario = 8462

delete from mkr_sessao ms where id_usuario = 8462
delete from mkr_perfil_usuario where id_usuario = 8462
delete from mkr_pessoa where id = 94057
delete from mkr_usuario mu where id_pessoa = 94057 
delete from mkr_pessoa_socio mps where id_pessoa = 94057
delete from mkr_usuario_cliente where id_cliente = 45742
delete from mkr_cliente where id_pessoa = 94057
delete from mkr_cliente_dados_comerciais mcdc where id_cliente = 45742
delete from mkr_cliente_anotacao mcdc where id_cliente = 45742
delete from mkr_acao_status_cliente_disparo mascd  where id_cliente = 45742
delete from mkr_pessoa_documento where id_pessoa = 94057
delete from mkr_pessoa_email mpe where id_pessoa = 94057
delete from mkr_pessoa_telefone mpe where id_pessoa = 94057
delete from mkr_pessoa_endereco mpe2 where id_pessoa = 94057
delete from mkr_pessoa_juridica mpj where mpj.id_pessoa = 94057