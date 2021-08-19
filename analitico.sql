select cliente.id as id_cliente,
    mf.id as id_filial,
    pv.dh_registro as data_pedido,
    mp.codigo as codigo_mundial,
    mf.codigo as codigo_filial,
    pgto.numero_transacao as chave_pagamento,
    pgto.dh_aprovacao as data_pagamento,
    pv.valor_produtos as valor_total_pedido,
    pv.valor_descontos as valor_desconto_pedido,
    pv.valor_total as valor_liquido,
    string_agg(cond_pgto.nome, ' - ') as formas_pagamento,
    sum(meb.valor) as total_pontos,
    tm.descricao as tipo_movimento,
    categoria.constante like '%_ESTORNO' as is_estorno
from mkr_hub_ped_venda pv
inner join mkr_hub_ped_venda_pgto pgto on pgto.id_hub_ped_venda = pv.id
inner join mkr_hub_cond_pagamento_parcela cp_parc on cp_parc.id = pgto.id_hub_cond_pag_parc 
inner join mkr_hub_cond_pagamento cond_pgto on cond_pgto.id = cp_parc.id_hub_cond_pagamento_origem 
inner join mkr_pessoa mp on mp.id = pv.id_pessoa 
inner join mkr_cliente cliente on cliente.id_pessoa = mp.id
inner join mkr_usuario_cliente uc on uc.id_cliente = cliente.id
inner join mkr_cliente_dados_comerciais dc on dc.id_cliente = cliente.id
inner join mkr_filial mf on mf.id = pv.id_filial
inner join mkr_pessoa pessoa_filial on pessoa_filial.id = mf.id_pessoa 
inner join mkr_extrato_bonificacao meb on meb.id_hub_pedido_venda = pv.id
inner join mkr_categoria_bonus categoria on categoria.id = meb.id_categoria_bonus
inner join mkr_tipo_movimento tm on tm.id = meb.id_tipo_movimento
where 1 = 1
    and cliente.id = :id_cliente
    and meb.id_cliente = cliente.id
    and tm.id = :id_tipo_movimento
    and categoria.constante like 'PONTO%'
    and pv.dh_registro between :date_start and :date_end
    and case when :id_condicao_pagto is null then true else cond_pgto.id = :id_condicao_pagto end
group by cliente.id,
    mf.id,
    pv.dh_registro,
    mp.codigo,
    mf.codigo,
    pgto.numero_transacao, 
    pgto.dh_aprovacao, 
    pv.valor_produtos, 
    pv.valor_total, 
    pv.valor_descontos,
    tm.descricao, 
    is_estorno