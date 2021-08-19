Rotina de cancelamento de cliente por inatividade de 20 dias;

##Regras:
#01 - Depois de iniciado o cadastro de um cliente, a partir da data de início do cadastro, se não houver nenhuma alteração no período de 20 dias, o status do cadastro passa a ser cancelado.

#02 -  Após a solicitação da assinatura, se não foi realizado durante um período de 20 dias, deverá ocorrer o cancelamento do cadastro.

===================================================
# Cenário 01:
update mkr_log_entidade set dh_registro = '2021-03-09 00:00:00' where id = 2071447
- Iniciei o cadastro de um cliente pelo Filial - inativa1 - Status: andamento
- Acessei o banco e mudei a data do dhinclusao e dhalteracao para mais de 20 dias;
- ficou com dia 14/10/2020: deve cancelar*
- foi adicionado um documento, não foi mudado a data então nao deve cancelar;

# Cenário 02:
- Tinha um cadastro simples de um cliente do dia 19 (INATIVA2 ), o status tava como correções, mudei para andamento e alterei a dhinclusao e dhalteracao para 19 dias. Não deve cancelar;

# Cenário 03:
- Iniciei o cadastro do INATIVA4, deixa o status como pendente e altera a dhinclusao e dhalteracao para dia 15/10 o que da 19 dias. Não deve cancelar.

# Cenário 04:
- iniciei o cadastro do inativa3, deixei o status pendente alterei a dhinclusao e dhalteracao para 

Data de adicionar o documento no cadastro

2: 14/10 - 20 dias - Deve cancelar
3: 14/10 - 20 dias - Deve cancelar
4: 15/10 - 19 dias - Não Deve cancelar

