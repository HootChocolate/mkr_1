WITH RECURSIVE rede AS (
    select cast(0 as integer) recursion_level,
        '-'||cliente.id||'-' as list_cliente,
        dc.id_cliente_pai_empresarial||'.'||cliente.id as ordem,
        public.get_descricao_posicao_arvore_geracoes(0, 'desc', :language) as arvore_geracao,
        cliente.id as id_cliente,
        mp.codigo as codigo_mundial,
        mp.nome as nome_cliente,
        graduacao_vigente.descricao_graduacao as graduacao,
        mf.nome as filial,
        pessoa_filial.nome_reduz as fantasia_filial,
        cliente_topo.nome_cliente as presidente,
        public.consulta_saldo_pontos_extrato_bonificacao_rede(
            cliente.id, 
            case when DATE_PART('MONTH', cast(now() as timestamp)) = DATE_PART('MONTH', cast(:date_start as timestamp)) then 'PREVIA' else 'APURACAO' end,
            :date_start, :date_end
        ) as total_pontos,
        (select count(*) from mkr_cliente_dados_comerciais where id_cliente_pai_empresarial = cliente.id) as nr_filhos_diretos
    from mkr_cliente cliente
    inner join mkr_cliente_dados_comerciais dc on dc.id_cliente = cliente.id
    inner join mkr_pessoa mp on mp.id = cliente.id_pessoa 
    left join mkr_filial mf on mf.id = cliente.id_filial
    left join mkr_pessoa pessoa_filial on pessoa_filial.id = mf.id_pessoa 
    , public.get_dados_graduacao_vigente_cliente(cliente.id, cast(:date_end as timestamp), :language) graduacao_vigente
    , public.consulta_dados_cliente_topo_rede(cliente.id, 1, '', :language) cliente_topo
    where 1 = 1
        and cliente.id = :id_cliente
        and true =
            case when coalesce(:mostrar_di_sem_pontos,false)
            then true 
            else
                public.consulta_saldo_pontos_extrato_bonificacao_rede(
                    cliente.id, 
                    case when DATE_PART('MONTH', cast(now() as timestamp)) = DATE_PART('MONTH', cast(:date_start as timestamp)) then 'PREVIA' else 'APURACAO' end,
                    :date_start, :date_end
                ) > 0
            end
    union ALL
    select rede.recursion_level + 1 as recursion_level,
        rede.list_cliente||''||filho_cliente.id||'-' as list_cliente,
        rede.ordem||'.'||filho_cliente.id as ordem,
        public.get_descricao_posicao_arvore_geracoes(rede.recursion_level + 1, 'desc', :language) as arvore_geracao,
        filho_cliente.id as id_cliente,
        filho_mp.codigo as codigo_mundial,
        filho_mp.nome as nome_cliente,
        filho_graduacao_vigente.descricao_graduacao as graduacao,
        filho_mf.nome as filial,
        filho_pessoa_filial.nome_reduz as fantasia_filial,
        filho_cliente_topo.nome_cliente as presidente,
        public.consulta_saldo_pontos_extrato_bonificacao_rede(
            filho_cliente.id, 
            case when DATE_PART('MONTH', cast(now() as timestamp)) = DATE_PART('MONTH', cast(:date_start as timestamp)) then 'PREVIA' else 'APURACAO' end,
            :date_start, :date_end
        ) as total_pontos,
        (select count(*) from mkr_cliente_dados_comerciais where id_cliente_pai_empresarial = filho_cliente.id) as nr_filhos_diretos
    from mkr_cliente filho_cliente
    inner join mkr_cliente_dados_comerciais filho_dc on filho_dc.id_cliente = filho_cliente.id
    inner join mkr_pessoa filho_mp on filho_mp.id = filho_cliente.id_pessoa  
    left join mkr_filial filho_mf on filho_mf.id = filho_cliente.id_filial
    left join mkr_pessoa filho_pessoa_filial on filho_pessoa_filial.id = filho_mf.id_pessoa 
    inner join rede on rede.id_cliente = filho_dc.id_cliente_pai_empresarial 
    , public.get_dados_graduacao_vigente_cliente(filho_cliente.id, cast(:date_end as timestamp), :language) filho_graduacao_vigente
    , public.consulta_dados_cliente_topo_rede(filho_cliente.id, 1, '', :language) filho_cliente_topo
    where 1 = 1
        and rede.list_cliente not like '%-'||filho_cliente.id||'-%'
        and filho_dc.id_status_penn in (1,2,5)
        and filho_cliente.id_tipo  =  1
        and true =
            case when coalesce(:mostrar_di_sem_pontos,false)
            then true 
            else
                public.consulta_saldo_pontos_extrato_bonificacao_rede(
                    filho_cliente.id, 
                    case when DATE_PART('MONTH', cast(now() as timestamp)) = DATE_PART('MONTH', cast(:date_start as timestamp)) then 'PREVIA' else 'APURACAO' end,
                    :date_start, :date_end
                ) > 0
            end
)
select * from rede order by rede.ordem, rede.nome_cliente