WITH RECURSIVE rede AS (
    select 0 recursion_level,
        '-'||cliente.id||'-' as list_cliente,
        cliente.id as id_cliente,
        dc.id_cliente_pai_empresarial id_pai,
        public.get_descricao_posicao_arvore_geracoes_asc(0, :language) as arvore_geracao,
        mp.codigo as codigo_mundial,
        mp.nome as nome,
        ss.nome as socio,
        graduacao_vigente.id_graduacao_titulo as id_graduacao,
        graduacao_vigente.descricao_graduacao_titulo as graduacao,
        graduacao_vigente.ordem_hierarquia_titulo as ordem_hierarquia,
        coalesce(mp.avatar, '/static/img/avatar.jpg') avatar,
        status_penn.constante as status_penn,
        cliente.id_status as id_status_cliente
    from mkr_cliente cliente
    inner join mkr_cliente_dados_comerciais dc on dc.id_cliente = cliente.id
    left join mkr_pessoa mp on mp.id = cliente.id_pessoa 
    left join mkr_filial mf on mf.id = cliente.id_filial
    left join mkr_pessoa pessoa_filial on pessoa_filial.id = mf.id_pessoa
    left join mkr_pessoa_socio ps on (ps.id_pessoa = cliente.id_pessoa 
        and ps.id_tipo_socio = (select id from mkr_tipo_socio where constante = 'SOCIO_ADMINISTRADOR'))
    left join mkr_pessoa ss on (ss.id = ps.id_socio)
    inner join mkr_status_penn status_penn on status_penn.id = dc.id_status_penn
    , public.get_dados_graduacao_vigente_cliente(cliente.id, cast(now() as timestamp), :language) graduacao_vigente
    where cliente.id = (select id_cliente from mkr_usuario_cliente muc where id_usuario = :id_usuario)
    union ALL
    select rede.recursion_level + 1 as recursion_level,
        rede.list_cliente||''||filho_cliente.id||'-' as list_cliente,
        filho_cliente.id as id_cliente,
        filho_dc.id_cliente_pai_empresarial id_pai,
        public.get_descricao_posicao_arvore_geracoes_asc((rede.recursion_level +1), :language) as arvore_geracao,
        filho_mp.codigo as codigo_mundial,
        filho_mp.nome as nome,
        ss.nome as socio,
        filho_graduacao_vigente.id_graduacao_titulo as id_graduacao,
        filho_graduacao_vigente.descricao_graduacao_titulo as graduacao,
        filho_graduacao_vigente.ordem_hierarquia_titulo as ordem_hierarquia,
        coalesce(filho_mp.avatar, '/static/img/avatar.jpg') avatar,
        filho_status_penn.constante as status_penn,
        filho_cliente.id_status as id_status_cliente
    from mkr_cliente filho_cliente
    inner join mkr_cliente_dados_comerciais filho_dc on filho_dc.id_cliente = filho_cliente.id
    left join mkr_pessoa filho_mp on filho_mp.id = filho_cliente.id_pessoa 
    left join mkr_filial filho_mf on filho_mf.id = filho_cliente.id_filial
    left join mkr_pessoa filho_pessoa_filial on filho_pessoa_filial.id = filho_mf.id_pessoa 
    left join mkr_pessoa_socio ps on (ps.id_pessoa = filho_cliente.id_pessoa 
        and ps.id_tipo_socio = (select id from mkr_tipo_socio where constante = 'SOCIO_ADMINISTRADOR'))
    left join mkr_pessoa ss on (ss.id = ps.id_socio)
    inner join mkr_status_penn filho_status_penn on filho_status_penn.id = filho_dc.id_status_penn
    inner join rede on rede.id_pai = filho_dc.id_cliente 
    , public.get_dados_graduacao_vigente_cliente(filho_cliente.id, cast(now() as timestamp), :language) filho_graduacao_vigente
    where rede.list_cliente not like '%-'||filho_cliente.id||'-%'
)
select * from rede 
where rede.ordem_hierarquia >= 3
    and rede.status_penn = 'ATIVO'
    and rede.id_status_cliente != (select id from mkr_status_cliente where constante = 'CANCELADO')
order by rede.ordem_hierarquia desc