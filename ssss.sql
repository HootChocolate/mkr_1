select
	P.ID ID_PRODUTO,
	S.ID ID_SKU,
	PAS.QUANTIDADE_ACESSORIOS,sa.id_filial,coalesce(sa.saldo,0) saldo,
	PF.ID is not null FAVORITO,
	HCP.ID_HOME_CATALOGO ID_HOME,
	DP.ID ID_DEPARTAMENTO,
	DP.DESCRICAO DEPARTAMENTO,
	P.CODIGO CODIGO_PRODUTO,
	S.CODIGO CODIGO_SKU,
	TD.COR DESTAQUE_COR,
	coalesce(PCS.caracteristica, PCP.caracteristica) caracteristica,
	coalesce(PCP.TITULO,PCS.TITULO) TITULO,
	coalesce(PCS.SOB_MEDIDA, PCP.SOB_MEDIDA) SOB_MEDIDA,
	coalesce(PCS.POSSUI_SPV, PCP.POSSUI_SPV) POSSUI_SPV,
	PCS.LINK_VIDEO,
	TD.DESCRICAO DESTAQUE_DESCRICAO,
	TD.CONSTANTE DESTAQUE_CONSTANTE,
	GI.ID_HUB_GRADE,
	GI.CODIGO CODIGO_GRADE,
	GI.LEGENDA,
	SGI.ID_HUB_GRADE_ITEM,
	PVI.QUANTIDADE,
	PVI.COMPRIMENTO,
	PVI.LARGURA,
	CPU.PERCENTUAL_SPV,
	case
		when coalesce(PCS.POSSUI_SPV, PCP.POSSUI_SPV) = true then TRUNC(TPI.VALOR_PRECO_VENDA * CPU.PERCENTUAL_SPV / 100, 2)
		else 0
	end as VALOR_SPV,
	PD.PERCENTUAL_DESCONTO,
	TRUNC(TPI.VALOR_PRECO_VENDA * PD.PERCENTUAL_DESCONTO / 100, 2) VALOR_DESCONTO,
	coalesce(IMG.URL, 'http://icons.iconarchive.com/icons/iconsmind/outline/512/Box-Open-icon.png') AVATAR,
	coalesce(coalesce(PCP.TITULO,PCS.TITULO),coalesce(S.DESCRICAO, P.DESCRICAO || ' ' || coalesce(GI.LEGENDA, ''))) DESCRICAO,
	coalesce(S.DESCRICAO, P.DESCRICAO || ' ' || coalesce(GI.LEGENDA, '')) || ' - ' || coalesce(S.CODIGO, P.CODIGO) PESQUISA,
	TPI.VALOR_PRECO_VENDA,
	(TPI.VALOR_PRECO_VENDA - TRUNC(TPI.VALOR_PRECO_VENDA * coalesce(PD.PERCENTUAL_DESCONTO, 0) / 100, 2)) VALOR,
	coalesce(CS.ID_CLASSIFICACAO, 0) CLASSIFICACAO,
	coalesce(CP.ID_CATALOGO, 0) CATALOGO
from
	MKR_HUB_PRODUTO P
inner join MKR_HUB_PRODUTO_SKU S on
	(S.ID_HUB_PRODUTO = P.ID)
left join MKR_HUB_PRODUTO_SKU_GRADE_ITEM SGI on
	(SGI.ID_HUB_PRODUTO_SKU = S.ID)
left join MKR_HUB_GRADE_ITEM GI on
	(GI.ID = SGI.ID_HUB_GRADE_ITEM)
left join MKR_HUB_TABELA_PRECO_ITEM TPI on
	(TPI.ID_HUB_PRODUTO_SKU = S.ID)
inner join (
	select
		CPU.*
	from
		MKR_CATALOGO_PERFIL CPU, MKR_PERFIL_USUARIO PU
	where
		PU.ID_USUARIO = :id_usuario
		and PU.ID_PERFIL = CPU.ID_PERFIL) CPU on
	(1 = 1)
	
	left join (select
		sum(sa.saldo) saldo,
		 am.id_filial,
		sa.id_hub_produto_sku 
	from mkr_hub_armazem am left join MKR_HUB_PRODUTO_SKU_ARMAZEM SA on am.id = sa.id_hub_armazem
	where 1 = 1
		
		and (am.id_filial in (select pv.id_filial from mkr_hub_ped_venda pv where 1= 1 and pv.id_usuario = :id_usuario
		and pv.id_hub_ped_venda_stat_ref = 7 ) or am.id_filial = :id_filial)
		group by  am.id_filial,
		sa.id_hub_produto_sku
		) sa on sa.id_hub_produto_sku = s.id
	
left join (
	select
		COUNT(*) QUANTIDADE_ACESSORIOS, PAS.ID_PRODUTO
	from
		MKR_HUB_PRODUTO_ACESSORIO PAS
	group by
		PAS.ID_PRODUTO) PAS on
	(PAS.ID_PRODUTO = P.ID)
inner join MKR_CATALOGO_PRODUTO CP on
	(CP.id_hub_produto = P.ID
	and CP.ID_CATALOGO = CPU.ID_CATALOGO)
left join MKR_PRODUTO_DESCONTO PD on
	(PD.ID_HUB_PRODUTO_SKU = S.ID
	and PD.ID_CATALOGO = CP.ID_CATALOGO
	and CPU.ID_PERFIL = PD.ID_PERFIL
	and current_timestamp between pd.data_inicial and pd.data_final)
left join MKR_HUB_DEPARTAMENTO DP on
	(DP.ID = P.ID_HUB_DEPARTAMENTO)
left join MKR_HOME_CATALOGO_PRODUTO HCP on
	(HCP.ID_HUB_PRODUTO_SKU = S.ID)
left join MKR_HOME_CATALOGO HC on
	(HC.ID = HCP.ID_HOME_CATALOGO )
left join MKR_TIPO_DESTAQUE TD on
	(TD.ID = HC.ID_TIPO_DESTAQUE)
left join (
	select
		CS.*, C.DESCRICAO, C.ID_SUPERIOR, O.ID ID_NIVEL_2, O.ID_SUPERIOR ID_NIVEL_3
	from
		MKR_CLASSIFICACAO_PRODUTO CS
	inner join MKR_CLASSIFICACAO C on
		(C.ID = CS.id_classificacao)
	left join MKR_CLASSIFICACAO O on
		(O.ID = C.ID_SUPERIOR) ) CS on
	(CS.ID_PRODUTO = P.ID
	and (CS.ID_CLASSIFICACAO = :classificacao
	or CS.ID_SUPERIOR = :classificacao
	or CS.ID_NIVEL_2 = :classificacao
	or CS.ID_NIVEL_3 = :classificacao))
left join MKR_PRODUTO_COMPLEMENTO PCS on
	(S.ID = PCS.id_hub_produto_sku)
left join MKR_PRODUTO_COMPLEMENTO PCP on
	(P.ID = PCP.id_hub_produto)
left join (
	select
		*
	from
		MKR_USUARIO_PRODUTO_FAVORITO PF
	where
		PF.ID_USUARIO = :id_usuario) PF on
	(S.ID = PF.ID_HUB_PRODUTO_SKU)
left join (
	select
		SUM(PVI.QUANTIDADE) QUANTIDADE, PVI.ID_HUB_PRODUTO_SKU, PIC.COMPRIMENTO, PIC.LARGURA
	from
		MKR_HUB_PED_VENDA_ITEM PVI, MKR_HUB_PED_VENDA PV, MKR_USUARIO U, MKR_HUB_PED_VENDA_ITEM_COMPL PIC
	where
		PV.ID = PVI.ID_HUB_PED_VENDA
		and PV.ID_VENDEDOR = U.ID_PESSOA
		and U.ID = :id_usuario
		and PIC.ID_HUB_PEDIDO_VENDA_ITEM = PVI.ID
		and PV.id_hub_ped_venda_stat_ref = 7
	group by
		PVI.ID_HUB_PRODUTO_SKU, PIC.COMPRIMENTO, PIC.LARGURA) PVI on
	(PVI.ID_HUB_PRODUTO_SKU = S.ID)
left join lateral (
	select
		IMG.*, TM.ORDEM
	from
		(
		select
			S.ID ID_SKU, P.ID ID_PRODUTO, coalesce(SM.ENDERECO, SP.ENDERECO) URL, coalesce(SM.ID_HUB_PRODUTO_TIPO_MIDIA, SP.ID_HUB_PRODUTO_TIPO_MIDIA) ID_TIPO
		from
			MKR_HUB_PRODUTO_SKU S
		inner join MKR_HUB_PRODUTO P on
			P.ID = S.ID_HUB_PRODUTO
		left join MKR_HUB_PRODUTO_SKU_MIDIA SM on
			SM.ID_HUB_PRODUTO_SKU = S.ID
		left join MKR_HUB_PRODUTO_MIDIA SP on
			SP.ID_HUB_PRODUTO = P.ID ) IMG , MKR_HUB_PRODUTO_TIPO_MIDIA TM
	where
		IMG.URL is not null
		and TM.ID = IMG.ID_TIPO
		and TM.IDENTIFICADOR in ('CAPA',
		'IMAGEM')
		and S.ID = IMG.ID_SKU
	order by
		TM.ORDEM asc
	limit 1 ) IMG on
	1 = 1
where
	1 = 1
	and ((CS.ID_CLASSIFICACAO = :classificacao
	or CS.ID_SUPERIOR = :classificacao
	or CS.ID_NIVEL_2 = :classificacao
	or CS.ID_NIVEL_3 = :classificacao)
	or coalesce(:classificacao, 0) = 0)
	and 1 = 1
	and P.ativo = true
	and (GI.CODIGO != 'PE' or exists (select 1 from mkr_perfil_usuario mpu where mpu.id_usuario = :id_usuario and mpu.id_perfil = 118))
	and TPI.VALOR_PRECO_VENDA > 0