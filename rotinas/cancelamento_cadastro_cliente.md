###Regras:
- Motivo1: Passou 20 dias e não houve assinatura o cadastro passa a ser cancelado.
- Motivo 2: Após iniciar o cadastro se não foi realizada nenhuma alteração durante 20 dias o sistema cancela.

- ULTIMO DOC ANEXADO E DATA DE CADASTRO TER SIDO ANEXADO A MAIS DE 20 DIAS: log_entidade

##MOntagem do cenário: MOTIVO 1
- Qual o status hoje do cliente [cancelamento3]? - Aprovado
- Movimente um usuário pelo fluxo até ele chegar no status Aprovado (Onde deve ser enviado os documentos);
- Pegue o id na log_entidade pelo ultimo registro desse usuário:
	select * from mkr_log_entidade where id_usuario = 267 order by dh_registro desc
- Altere a dh_registro para 19 dias antes, ela está associada a mudança de status la no log_entidade_campo;
- Valide no próximo dia;



###Montagem do cenário: MOTIVO 2
- Qual o status hoje do cliente [cancelamento]? - Andamento
- Adicione um documento no seu usuário, salve e pegue o url do documento;
- select id_entidade from mkr_documento where caminho = <url>
- select * from mkr_log_entidade where id_usuario =  and id_entidade =  
- Altere a data de registro para 19 dias atrás;
- No próximo dia, verifique se o status está cancelado;