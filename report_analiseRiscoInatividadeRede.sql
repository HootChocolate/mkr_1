WITH RECURSIVE rede AS (
    select cast(0 as integer) recursion_level,
        '-'||cliente.id||'-' as list_cliente,
        dc.id_cliente_pai_empresarial||'.'||cliente.id as ordem,
        cliente.id as id_cliente,
        mp.codigo as codigo_mundial,
        mp.nome as nome_cliente,
        graduacao_vigente.descricao_graduacao as graduacao_vigente,
        status_penn.descricao as status_penn,
        dc.data_registro_penn,
        filial.codigo as codigo_filial,
        saldo_pontos.* as saldo_pontos,
        public.get_status_risco_inativacao_cliente(cliente.id, :language) as status_risco,
        pessoa_pai.nome as nome_pai_empresarial,
        cidade.id as id_cidade,
        uf.id as id_estado,
        pais.id as id_pais
    from mkr_cliente cliente
    inner join mkr_cliente_dados_comerciais dc on dc.id_cliente = cliente.id
    inner join mkr_pessoa mp on mp.id = cliente.id_pessoa
    inner join mkr_pessoa_endereco endereco on endereco.id = (
        select inner_endereco.id
        from mkr_pessoa_endereco inner_endereco
        inner join mkr_tipo_endereco tp_ende on tp_ende.id = inner_endereco.id_tipo
        where inner_endereco.ativo = true 
            and inner_endereco.id_pessoa = mp.id
        order by tp_ende.constante desc
        limit 1
    )
    inner join mkr_cidade cidade on cidade.id = endereco.id_cidade
    inner join mkr_estado uf on uf.id = cidade.id_estado 
    inner join mkr_pais pais on pais.id = uf.id_pais
    inner join mkr_status_penn status_penn on status_penn.id = dc.id_status_penn
    inner join mkr_cliente cliente_pai on cliente_pai.id = dc.id_cliente_pai_empresarial
    inner join mkr_pessoa pessoa_pai on pessoa_pai.id = cliente_pai.id_pessoa
    left join mkr_filial filial on filial.id = cliente.id_filial
    , public.consulta_saldo_pontos_extrato_bonificacao_individual(
        cliente.id, 'APURACAO', cast(now() - cast('180 day' as interval) as timestamp), cast(now() as timestamp)
    ) saldo_pontos
    , public.get_dados_graduacao_vigente_cliente(cliente.id, cast(now() as timestamp), :language) graduacao_vigente
    where cliente.id = :id_cliente
    union all
    select rede.recursion_level + 1 as recursion_level,
        rede.list_cliente||''||filho_cliente.id||'-' as list_cliente,
        rede.ordem||'.'||filho_cliente.id as ordem,
        filho_cliente.id as id_cliente,
        filho_mp.codigo as codigo_mundial,
        filho_mp.nome as nome_cliente,
        filho_graduacao_vigente.descricao_graduacao as graduacao_vigente,
        filho_status_penn.descricao as status_penn,
        filho_dc.data_registro_penn,
        filho_filial.codigo as codigo_filial,
        filho_saldo_pontos.* as saldo_pontos,
        public.get_status_risco_inativacao_cliente(filho_cliente.id, :language) as status_risco,
        filho_pessoa_pai.nome as nome_pai_empresarial,
        filho_cidade.id as id_cidade,
        filho_uf.id as id_estado,
        filho_pais.id as id_pais
    from mkr_cliente filho_cliente
    inner join mkr_cliente_dados_comerciais filho_dc on filho_dc.id_cliente = filho_cliente.id
    inner join mkr_pessoa filho_mp on filho_mp.id = filho_cliente.id_pessoa
    left join mkr_pessoa_endereco filho_endereco on filho_endereco.id = (
        select inner_endereco.id
        from mkr_pessoa_endereco inner_endereco
        inner join mkr_tipo_endereco tp_ende on tp_ende.id = inner_endereco.id_tipo
        where inner_endereco.ativo = true 
            and inner_endereco.id_pessoa = filho_mp.id
        order by tp_ende.constante desc
        limit 1
    )
    left join mkr_cidade filho_cidade on filho_cidade.id = filho_endereco.id_cidade
    left join mkr_estado filho_uf on filho_uf.id = filho_cidade.id_estado 
    left join mkr_pais filho_pais on filho_pais.id = filho_uf.id_pais
    inner join mkr_status_penn filho_status_penn on filho_status_penn.id = filho_dc.id_status_penn
    inner join mkr_cliente filho_cliente_pai on filho_cliente_pai.id = filho_dc.id_cliente_pai_empresarial
    inner join mkr_pessoa filho_pessoa_pai on filho_pessoa_pai.id = filho_cliente_pai.id_pessoa
    left join mkr_filial filho_filial on filho_filial.id = filho_cliente.id_filial
    inner join rede on rede.id_cliente = filho_dc.id_cliente_pai_empresarial
    , public.consulta_saldo_pontos_extrato_bonificacao_individual(
        filho_cliente.id, 'APURACAO', cast(now() - cast('180 day' as interval) as timestamp), cast(now() as timestamp)
    ) filho_saldo_pontos
    , public.get_dados_graduacao_vigente_cliente(filho_cliente.id, cast(now() as timestamp), :language) filho_graduacao_vigente
    where rede.list_cliente not like '%-'||filho_cliente.id||'-%'
)
select * from rede order by rede.ordem
