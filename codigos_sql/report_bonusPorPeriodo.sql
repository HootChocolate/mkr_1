WITH RECURSIVE rede AS (
    select 0 recursion_level,
        '-'||cliente.id||'-' as list_cliente,
        dc.id_cliente_pai_empresarial||'.'||cliente.id as ordem,
        public.get_descricao_posicao_arvore_geracoes(0, 'desc', :language) as arvore_geracao,
        cliente.id as id_cliente,
        mp.codigo as codigo_mundial,
        mp.nome as nome_cliente,
        tp_movto.descricao as tipo_movimento,
        dados_pedidos.soma_valor as base_calculo,
        public.consulta_soma_valor_extrato_bonificacao(
            cliente.id, tp_movto.constante, 'SPV_GRADUACAO', cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as credito_spv_graduacao,
        public.consulta_soma_valor_extrato_bonificacao(
            cliente.id, tp_movto.constante, 'SPV_DIRETO', cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as credito_spv_direto,
        public.consulta_soma_valor_extrato_bonificacao_spv_credito(
            cliente.id, tp_movto.constante,cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as total_creditos,
        public.consulta_soma_valor_extrato_bonificacao(
            cliente.id, tp_movto.constante, 'SPV_SAQUE', cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as debito_spv_saque,
        public.consulta_soma_valor_extrato_bonificacao(
            cliente.id, tp_movto.constante, 'SPV_COMPRA', cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as debito_spv_compra,
        public.consulta_soma_valor_extrato_bonificacao(
            cliente.id, tp_movto.constante, 'SPV_GRADUACAO_ESTORNO', cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as debito_spv_graduacao,
        public.consulta_soma_valor_extrato_bonificacao(
            cliente.id, tp_movto.constante, 'SPV_DIRETO_ESTORNO', cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as debito_spv_direto,
        public.consulta_soma_valor_extrato_bonificacao_spv_debito(
            cliente.id, tp_movto.constante, cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as total_debitos,
        public.consulta_soma_valor_extrato_bonificacao_spv_credito(
            cliente.id, tp_movto.constante, cast(:date_start as timestamp), cast(:date_end as timestamp)
        )
        -
        public.consulta_soma_valor_extrato_bonificacao_spv_debito(
            cliente.id, tp_movto.constante, cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as saldo_final
    from mkr_cliente cliente
    inner join mkr_cliente_dados_comerciais dc on dc.id_cliente = cliente.id
    inner join mkr_pessoa mp on mp.id = cliente.id_pessoa
    left join (
        select sum(pv.valor_total) as soma_valor, extrato.id_cliente as id_cliente_extratos
        from mkr_hub_ped_venda pv 
        inner join mkr_extrato_bonificacao extrato on extrato.id_hub_pedido_venda = pv.id
        where extrato.data_movimento between :date_start and :date_end
            and extrato.id_tipo_movimento = :id_tipo_movimento
            and extrato.id_categoria_bonus not in (select id from mkr_categoria_bonus where constante like 'PONTO%')
        group by extrato.id_cliente 
    ) dados_pedidos on dados_pedidos.id_cliente_extratos = cliente.id
    , mkr_tipo_movimento tp_movto
    where cliente.id = :id_cliente
        and tp_movto.id = :id_tipo_movimento
    union ALL
    select rede.recursion_level + 1 as recursion_level,
        rede.list_cliente||''||filho_cliente.id||'-' as list_cliente,
        rede.ordem||'.'||filho_cliente.id as ordem,
        public.get_descricao_posicao_arvore_geracoes(rede.recursion_level + 1, 'desc', :language) as arvore_geracao,
        filho_cliente.id as id_cliente,
        filho_mp.codigo as codigo_mundial,
        filho_mp.nome as nome_cliente,
        filho_tp_movto.descricao as tipo_movimento,
        filho_dados_pedidos.soma_valor as base_calculo,
        public.consulta_soma_valor_extrato_bonificacao(
            filho_cliente.id, filho_tp_movto.constante, 'SPV_GRADUACAO', cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as credito_spv_graduacao,
        public.consulta_soma_valor_extrato_bonificacao(
            filho_cliente.id, filho_tp_movto.constante, 'SPV_DIRETO', cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as credito_spv_direto,
        public.consulta_soma_valor_extrato_bonificacao_spv_credito(
            filho_cliente.id, filho_tp_movto.constante, cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as total_creditos,
        public.consulta_soma_valor_extrato_bonificacao(
            filho_cliente.id, filho_tp_movto.constante, 'SPV_SAQUE', cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as debito_spv_saque,
        public.consulta_soma_valor_extrato_bonificacao(
            filho_cliente.id, filho_tp_movto.constante, 'SPV_COMPRA', cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as debito_spv_compra,
        public.consulta_soma_valor_extrato_bonificacao(
            filho_cliente.id, filho_tp_movto.constante, 'SPV_GRADUACAO_ESTORNO', cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as debito_spv_graduacao,
        public.consulta_soma_valor_extrato_bonificacao(
            filho_cliente.id, filho_tp_movto.constante, 'SPV_DIRETO_ESTORNO', cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as debito_spv_direto,
        public.consulta_soma_valor_extrato_bonificacao_spv_debito(
            filho_cliente.id, filho_tp_movto.constante, cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as total_debitos,
        public.consulta_soma_valor_extrato_bonificacao_spv_credito(
            filho_cliente.id, filho_tp_movto.constante, cast(:date_start as timestamp), cast(:date_end as timestamp)
        )
        -
        public.consulta_soma_valor_extrato_bonificacao_spv_debito(
            filho_cliente.id, filho_tp_movto.constante, cast(:date_start as timestamp), cast(:date_end as timestamp)
        ) as saldo_final
    from mkr_cliente filho_cliente
    inner join mkr_cliente_dados_comerciais filho_dc on filho_dc.id_cliente = filho_cliente.id
    inner join mkr_pessoa filho_mp on filho_mp.id = filho_cliente.id_pessoa  
    left join (
        select sum(pv.valor_total) as soma_valor, extrato.id_cliente as id_cliente_extratos
        from mkr_hub_ped_venda pv 
        inner join mkr_extrato_bonificacao extrato on extrato.id_hub_pedido_venda = pv.id
        where extrato.data_movimento between :date_start and :date_end 
            and extrato.id_tipo_movimento = :id_tipo_movimento
            and extrato.id_categoria_bonus not in (select id from mkr_categoria_bonus where constante like 'PONTO%')
        group by extrato.id_cliente 
    ) filho_dados_pedidos on filho_dados_pedidos.id_cliente_extratos = filho_cliente.id
    inner join rede on rede.id_cliente = filho_dc.id_cliente_pai_empresarial
    , mkr_tipo_movimento filho_tp_movto
    where filho_tp_movto.id = :id_tipo_movimento
        and rede.list_cliente not like '%-'||filho_cliente.id||'-%'
)
select * from rede order by rede.ordem
