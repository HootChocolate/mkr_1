        where inner_pv.id_pessoa = mp.id
            and inner_status.tipo_status in (
                'AGUARDANDO_PAGAMENTO','PENDENTE','APROVADO','AGUARDANDO_CONFERENCIA',
                'TRANSPORTE','CONCLUIDO','FATURADO','PRE_VENDA_PENDENTE','PRE_VENDA_APROVADO'
            )