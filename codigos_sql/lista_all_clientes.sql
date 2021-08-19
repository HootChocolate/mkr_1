WITH RECURSIVE resultado AS (
    select cliente.id, 
    pessoa.codigo as codigo,
    pessoa.nome, 
    pessoa.avatar, '-'||cliente.id||'-' as list_cliente
    FROM mkr_cliente cliente
    inner join mkr_pessoa pessoa on pessoa.id = cliente.id_pessoa 
    WHERE cliente.id in (select id_cliente from mkr_usuario_cliente where id_usuario = :id_usuario)
    UNION ALL
    select filho_cliente.id, filho_pessoa.codigo, filho_pessoa.nome, filho_pessoa.avatar, resultado.list_cliente||''||filho_cliente.id||'-' as list_cliente
    FROM mkr_cliente filho_cliente
    inner join mkr_pessoa filho_pessoa on filho_pessoa.id = filho_cliente.id_pessoa 
    inner join mkr_cliente_dados_comerciais filho_dc on filho_dc.id_cliente = filho_cliente.id
    JOIN resultado ON resultado.id = filho_dc.id_cliente_pai_empresarial 
    where resultado.list_cliente not like '%-'||filho_cliente.id||'-%'
    and filho_dc.id_status_penn in (select id from mkr_status_penn where constante in ('ATIVO','INATIVO','PENDENTE'))
    and filho_cliente.id_tipo = 1
)
SELECT * FROM resultado