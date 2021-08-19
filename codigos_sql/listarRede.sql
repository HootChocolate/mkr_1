SELECT C.ID,
    P.NOME,
    coalesce(graduacao_vigente.descricao_graduacao,LOWER(tc.descricao)) as GRADUACAO,
    COALESCE(P.AVATAR,'https://icons.iconarchive.com/icons/google/noto-emoji-people-face/128/10134-boy-icon.png') AVATAR,
    COALESCE(CD.ID_CLIENTE_PAI_EMPRESARIAL,0) ID_SUPERIOR,
    COALESCE(A.TOTAL, 0) FILHOS,
    public.consulta_saldo_pontos_extrato_bonificacao_rede(
        CD.id_cliente, 'PREVIA', cast(:data_inicial as timestamp), cast(:data_final as timestamp)
    ) as PONTOS,
    TO_CHAR(graduacao_vigente.data_aprovacao, 'DD/MM/YYYY') as dh_graduacao
FROM MKR_CLIENTE_DADOS_COMERCIAIS CD 
INNER JOIN MKR_CLIENTE C ON (C.ID = CD.ID_CLIENTE)
INNER JOIN MKR_TIPO_CLIENTE TC ON (TC.ID = C.ID_TIPO)
INNER JOIN MKR_PESSOA P ON (P.ID = C.ID_PESSOA)
LEFT JOIN (
    SELECT COUNT(*) TOTAL, A.ID_CLIENTE_PAI_EMPRESARIAL 
    FROM MKR_CLIENTE_DADOS_COMERCIAIS A, MKR_CLIENTE B, mkr_status_penn msp, mkr_status_cliente msc 
    WHERE B.ID = A.ID_CLIENTE AND msp.participa_rede = true
    and A.id_status_penn = msp.id 
    and msc.id = B.id_status 
    and msc.participa_rede = true
    GROUP BY A.ID_CLIENTE_PAI_EMPRESARIAL
) A ON (A.ID_CLIENTE_PAI_EMPRESARIAL = C.ID)
, public.get_dados_graduacao_vigente_cliente(c.id, cast(now() as timestamp), :language) graduacao_vigente
WHERE 1 = 1
    and CD.id_status_penn  in (1,2,3,5)
        and c.id_status not in (25,7,18,19)
        and (c.id_tipo in (1) or (c.id_status not in (23) and c.id_tipo in (2,8,7))) 
    AND (
        true = case when :superior is not null and :superior != 0 
            then CD.ID_CLIENTE_PAI_EMPRESARIAL = coalesce(:superior,0) 
            else 
                case when :id_cliente_filtro is not null and :id_cliente_filtro != 0 
                then c.id = :id_cliente_filtro 
                else c.id = (SELECT uc.id_cliente FROM MKR_USUARIO_CLIENTE UC WHERE UC.ID_USUARIO = :id_usuario)
                end
            end
    )
