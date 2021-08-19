select resultado.*, 
    public.consulta_saldo_pontos_rede_por_usuario(
         :id_usuario,
         case when to_char(now(), 'YYYY-MM') = to_char(cast(:date_start as timestamp), 'YYYY-MM')  then 'PREVIA' else 'APURACAO' end,
         :date_start, :date_end
    ) as pontos_rede,
    ROW_NUMBER () OVER (ORDER BY nome) POSICAO
from (
    WITH RECURSIVE rede AS (
        select cliente.id as id_cliente,
            '-'||cliente.id||'-' as list_cliente,
            pessoa.nome,
            COALESCE(pessoa.avatar ,'https://icons.iconarchive.com/icons/google/noto-emoji-people-face/128/10128-child-icon.png') AVATAR,
            public.consulta_saldo_pontos_extrato_bonificacao_individual(
                cliente.id,
                case when to_char(now(), 'YYYY-MM') = to_char(cast(:date_start as timestamp), 'YYYY-MM')  then 'PREVIA' else 'APURACAO' end,
                :date_start, :date_end
            ) as pontos
        from mkr_cliente_dados_comerciais dc
        inner join mkr_cliente cliente on cliente.id = dc.id_cliente 
        inner join mkr_pessoa pessoa on pessoa.id = cliente.id_pessoa
        where dc.id_cliente_pai_empresarial in (select id_cliente from mkr_usuario_cliente muc where id_usuario = :id_usuario)
        UNION all
        select filho_cliente.id as id_cliente,
            rede.list_cliente||''||filho_cliente.id||'-' as list_cliente,
            filho_pessoa.nome,
            COALESCE(filho_pessoa.avatar ,'https://icons.iconarchive.com/icons/google/noto-emoji-people-face/128/10128-child-icon.png') AVATAR,
            public.consulta_saldo_pontos_extrato_bonificacao_individual(
                filho_cliente.id, 
                case when to_char(now(), 'YYYY-MM') = to_char(cast(:date_start as timestamp), 'YYYY-MM')  then 'PREVIA' else 'APURACAO' end,
                :date_start, :date_end
            ) as pontos
        from mkr_cliente_dados_comerciais filho_dc
        inner join mkr_cliente filho_cliente on filho_cliente.id = filho_dc.id_cliente 
        inner join mkr_pessoa filho_pessoa on filho_pessoa.id = filho_cliente.id_pessoa
        JOIN rede ON rede.id_cliente = filho_dc.id_cliente_pai_empresarial
        where rede.list_cliente not like '%-'||filho_cliente.id||'-%'
    ) 
    select * from rede
) resultado
