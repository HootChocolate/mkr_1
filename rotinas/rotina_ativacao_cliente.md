###Regras:
- A conta de dias é feita olhando a data de pagamento do pedido
- Na tabela mkr_hub_pedido_venda_compl ser > 1 ponto;
- Depois que o cliente D.I  tem o seu cadastro aprovado pela adm da nippon, o status do cadastro de cliente fica como ATIVO e o status pen permanece como PENDENTE.
- Esse cliente D.I pode entrar na plataforma e fazer compras. Se após 180 dias corridos a rotina verificar que ele fez 1 ponto ou mais o status penn desse cliente passa a ser ATIVO caso contrário torna-se INATIVO


### SQL:
- Fonte: rotina_ativacao_cliente
- Verifica se existe o id_pais
- O status precisa ser 'APROVADO', 'AGUARDANDO_CONFERENCIA', 'TRANSPORTE', 'CONCLUIDO', 'FATURADO'