WITH RECURSIVE rede AS (
    select 0 recursion_level,
        '-'||cliente.id||'-' as list_cliente,
        cliente.id as id_cliente,
        dc.id_cliente_pai_empresarial id_pai,
        public.get_descricao_posicao_arvore_geracoes_desc(0, :language) as arvore_geracao,
        mp.codigo as codigo_mundial,
        mp.nome as nome_cliente,
        graduacao_vigente.id_graduacao_titulo as id_graduacao,
        graduacao_vigente.descricao_graduacao_titulo as graduacao,
        mf.nome as filial,
        mf.codigo as codigo_filial,
        graduacao_vigente.peso_graduacao_peso as peso_graduacao,
        dc.id_status_penn,
        tp_cliente.constante as tipo_cliente
    from mkr_cliente cliente
    inner join mkr_cliente_dados_comerciais dc on dc.id_cliente = cliente.id
    inner join mkr_pessoa mp on mp.id = cliente.id_pessoa 
    left join mkr_filial mf on mf.id = cliente.id_filial
    left join mkr_pessoa pessoa_filial on pessoa_filial.id = mf.id_pessoa 
    inner join mkr_tipo_cliente tp_cliente on tp_cliente.id = cliente.id_tipo
    , public.get_dados_graduacao_vigente_cliente(cliente.id, cast(now() as timestamp), :language) graduacao_vigente
    where cliente.id = coalesce(:id_cliente,(select id_cliente from mkr_usuario_cliente muc where id_usuario = :id_usuario))
    union ALL
    select rede.recursion_level + 1 as recursion_level,
        rede.list_cliente||''||filho_cliente.id||'-' as list_cliente,
        filho_cliente.id as id_cliente,
        filho_dc.id_cliente_pai_empresarial id_pai,
        public.get_descricao_posicao_arvore_geracoes_desc((rede.recursion_level +1), :language) as arvore_geracao,
        filho_mp.codigo as codigo_mundial,
        filho_mp.nome as nome_cliente,
        filho_graduacao_vigente.id_graduacao_titulo as id_graduacao,
        filho_graduacao_vigente.descricao_graduacao_titulo as graduacao,
        filho_mf.nome as filial,
        filho_mf.codigo as codigo_filial,
        filho_graduacao_vigente.peso_graduacao_peso as peso_graduacao,
        filho_dc.id_status_penn,
        filho_tp_cliente.constante as tipo_cliente
    from mkr_cliente filho_cliente
    inner join mkr_cliente_dados_comerciais filho_dc on filho_dc.id_cliente = filho_cliente.id
    inner join mkr_pessoa filho_mp on filho_mp.id = filho_cliente.id_pessoa 
    inner join mkr_tipo_cliente filho_tp_cliente on filho_tp_cliente.id = filho_cliente.id_tipo
    inner join mkr_status_penn filho_msp on filho_msp.id = filho_dc.id_status_penn
    left join mkr_filial filho_mf on filho_mf.id = filho_cliente.id_filial
    left join mkr_pessoa filho_pessoa_filial on filho_pessoa_filial.id = filho_mf.id_pessoa 
    inner join rede on rede.id_cliente = filho_dc.id_cliente_pai_empresarial 
    , public.get_dados_graduacao_vigente_cliente(filho_cliente.id, cast(now() as timestamp), :language) filho_graduacao_vigente
    where rede.list_cliente not like '%-'||filho_cliente.id||'-%'
)
select * from rede 
where 1=1
    and rede.tipo_cliente = 'DI'
    and rede.id_status_penn not in (
        select id from mkr_status_penn where constante in ('RECOMENDACAO')
    )