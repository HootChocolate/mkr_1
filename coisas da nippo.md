## Tarefas de graduação:
https://makertec.atlassian.net/browse/INT-662
  (30% Herança, 1 vez errado)
https://makertec.atlassian.net/browse/INT-633 
  (Filho Suspenso)

# Ordem das entrevistas: https://makertec.atlassian.net/browse/IF-1353
======== Lateralidade ================ Aproveitando pontos da rede
**
Realizar 30% dos pontos no restante da sua rede;
Tem umas regras no documento de Rotina de Graduação;
**
# Se eu sou executive tenho dois filhos, um Rubi e um Safira.. quem cede a lateralidade é o Safira, e se no mês que ele for ceder a lateralidade ele tiver graduando para Rubi, muda alguma coisa?
# Se eu não tenho graduação e tenho dois filhos Executive, eu posso pegar a lateralidade? Se sim, nesse caso eu tenho que fazer 2 cotas de 12, 6 pontos individuais e os 6 da lateralidade?
# Criar um cenário em que o filho cede a lateralidade de Safira pro Pai, mas o pai já é Safira(ter um irmão Rubi);
# Ter um maior na lateral;
# Duas  graduações superior
# Soma dos pesos das graduações inferiores;

================================
# Cenários com cotas do documento "Processo de graduaçao de um usuário DI (Adesão)...";

# Equivalência - Peso de cada graduação: * Soma o maior peso nos braços;
- Considerar cenário em que o filho cumpriu a cota 1, considera o peso da graduação que ele ta tentando, (tentando cota 1 de Safira);
- Pontuação lateral com safira;
- Soma os pesos e ver se é maior ou igual que o peso requerido pra graduação;
- Caso tenha mais de um filho com o mesmo peso no braço, considerar apenas um peso;
- Testar equivalência onde os pesos não somam, e tem mais graduados abaixo do que será pego o peso(rede Maria aparecida Soares);

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Automatizar:
## Colocar waitLoading nos relatórios;
## Relatorio pontuacao rede;
## Limpar dados de inserção do crud antes de inserir,,, endereço e banco
## Testar sttus suspenso;
Ver se tem como não bloquear a tela do selenium;
# Verificar se existe mais de um componente na tela quando for usar o select;

12# No teste que preenche os dados de entrega, validar que os dados foram preenchidos;
# PE - Validar preenchimento do nome com as dimensoes escolhidas;
## Trocar senha pelo meus_dados;
## pegarInformacoesSobreOProduto adecionar desconto


### API - Estratégia para testes de API
consultarEvolucaoConsultor
/api/salvarDocumentosConsultor/22797
/api/ContratoCliente?query=&lazy=true&size=10&page=1&field=contratos&parentClass=GestaoContratoCliente&gestaoContratoCliente=23&language=1& - GET
/api/view/GestaoContratoCliente?name=&parent=&language=1& - GET
listarClientesFluxo?status=19 - Evoluir para DI
  - Riscos da aplicação, impactos e ver o que vai ser testado de fato;
  - Mind map com um tópico central, puxando uns balaozinhos puxando riscos, ferramentas que serão utilizadas, riscos, pessoas do time, se vai ser funcional ou não funcional (Quais tipos serão feitos);
  - Riscos podem estar relacionados a algum caso de uso
  - Integração e mocs que serão precisos;
  - Ver prioridades para automatização;
  api/cart/annotate
  Acessar dados de cartão de crédito;
  salvarEntrevista            
  listarAcoesClientes

# Se editar um CNPJ, gera outro contato, ao tentar remover o contato anterior, duplica o ultimo. Quando tenta salvar, remove todos os contatos e mostra mensagem de campo vazio;
# Desabilitar lupa de pedido na Venda Vinculo;
# Ver spv do dash e comparar com relatório de bônus por período;
# Ver pontuação na minha rede e quantidade de filhos, depois ver o mesmo dado no relatório de pontuação em rede;
# Dá pra testar mais de um cliente associado a um usuário? * Iria estar entrando no negócio de internacionalização dai.
# Pontuação deve ser considerada na data de pagamento. Qualificação parece estar computando corretamente. aNÁLITIV
# Filtro com datas repetidas;
# Rever git pipeline https://gitlab.conecte.com.vc/makertec/nipponflex-test/-/blob/182b93c3ed90ef66cb59e9ad457510bc2bc4fd9d/.gitlab-ci.yml
# Quando entro na tela de eventos é pra listar os eventos de todo mundo? listarEventos e listarTodosEventos
# Consultar CNPJ no cadastro de conta bancária, e consultar CEP ao alterar endereço de um pedido no menu Pedido;
================================================
# usuario&admin senha;
# Aba de documentos pessoais apenas no cadastro de sócio;

================================================
## Listando recomendação no card de pontos;
## Graduação foi errada do NIPPON II, disse que ia falar com o Fefe
<!-- https://makertec.atlassian.net/browse/IF-1466 - Ver nota fiscal -->
## Backup thingsboard;
## filialManaus não consigo cancelar o pedido, foi trocado o cliente depois de selecionar uma entrega por pac
## A rotina de cancelamento cancela algfuem que esteja no fluxo de clientes?
## Ver estratégias da blacklist se tá certo;
# Se editar um socio e colocar um cpf de outro socio, mostra que o cpf ja existe, mas se atualizar a tela o cpf é alterado;
# Sumiu a opção 'Ver entrevista' da aba de Recomendação;
# Venda vinculo tinha observação?
# Adicionar ação de clique no confirmar senha do primeiro acesso;
================================================

## Pegar XML de um pedido com frete e chave de pagamento.. um com dados de retirada por terceiro e chave de integração;Eu retiro, PED0000017004 MKR_17117, 123321 Chave, 112233 Conta
https://makertec.atlassian.net/browse/IF-1227 - RMA
https://makertec.atlassian.net/browse/IF-1228 - BuscarPontucaoRede
https://makertec.atlassian.net/browse/IF-1428 - Integração SPV prévia;
https://makertec.atlassian.net/browse/IF-1406 - Pagamento com Previa de SPV.. História concluida;
https://makertec.atlassian.net/browse/IF-1408 - Integração de Liquidacao e liberacao de Credito de SPV, ta em andamento;
https://makertec.atlassian.net/browse/IF-1409 - Solicitação de reenbolso, pode ter mais de uma?
https://makertec.atlassian.net/browse/IF-1395 - Conceito do Ciclo SPV(Chave integração);
https://makertec.atlassian.net/browse/IF-1463 - Relacionado com a de cima?
https://makertec.atlassian.net/browse/INT-584 - Tarefa finalizado, sobre lentidão;*
https://makertec.atlassian.net/browse/IF-1497 - Não permitir repetição da chave de pagamento;
Falar com DAniel;
Onix: https://produto.mercadolivre.com.br/MLB-1458009164-cordo-colar-avano-w-130-pingente-coraco-pedra-onix-_JM?searchVariation=51723512858#searchVariation=51723512858&position=46&search_layout=grid&type=item&tracking_id=02c3ec14-23be-4bc7-a399-e58dd0e7c846
Mouse: https://produto.mercadolivre.com.br/MLB-1532404354-mouse-sem-fio-wireless-24ghz-usb-notebook-pc-alcance-10m-_JM?searchVariation=56732059015#searchVariation=56732059015&position=48&search_layout=grid&type=item&tracking_id=77b2f993-6b35-4e4a-8ac3-c39627c76a6f
Capa Sapato: https://produto.mercadolivre.com.br/MLB-1708906118-capa-chuva-sapato-tenis-moto-protetor-silicone-calcadobrind-_JM?searchVariation=67535210386#searchVariation=67535210386&position=16&search_layout=grid&type=item&tracking_id=cfe8c149-bc9c-4e77-8f8f-efbbabafe797
Capa: https://produto.mercadolivre.com.br/MLB-1166544924-capa-de-chuva-motoqueiro-nylon-pantaneiro-com-gola-_JM?searchVariation=32000740765#searchVariation=32000740765&position=20&search_layout=grid&type=item&tracking_id=cfe8c149-bc9c-4e77-8f8f-efbbabafe797
===============================================
## Graduação:
# Marcado como Concluido: 
  - https://makertec.atlassian.net/browse/INT-662
    - Depois esse: https://makertec.atlassian.net/browse/INT-628
  - https://makertec.atlassian.net/browse/INT-633 - Falta validar;
  - https://makertec.atlassian.net/browse/INT-634 - Ainda errado;


======== Herança ================
#{inativo} A recuperação de inativos, pode ser feita para DI Executive? ...numa documentação eu encontrei dizendo que é do DI Executive pra cima, se sim ele puder, então ele deve fazer 30% dos 40 de rede, mas os pontos individuais continua 6, não 30 % de 6;
# Listar na minha rede clientes inativos?
# Desfazer a sociedade com cota 1 cumprida;
## Click no enter do login, set loading true no botão entrar;
# Não permitir cadastrar uma graduação do tssipo herdada se o status penn do cara estiver inativo;
# Montar cenário de Separação com documento complementar v5,
  primeiro com herança de Executive e depois herança de Safira;
  - Sugestão.. Conta os filhos mas não conta o filho;
---------
# Na guia de SPV e estornos, o SPV Pago são somente os apurados?
## Excluir cadastros Cancelado;
  select * from mkr_pessoa_fisica mpf where cpf_conjuge = '06038906797'
  Remover socios;
=======
# Uma vez apareceu na produção o alert 'No message available'
# Video: Brasilia secreta
# A lateralidade é somente pra graduação efetivada, ou uma graduação graduando tb serve?
# Onix: https://produto.mercadolivre.com.br/MLB-1458009164-cordo-colar-avano-w-130-pingente-coraco-pedra-onix-_JM?searchVariation=51723512858#searchVariation=51723512858&position=46&search_layout=grid&type=item&tracking_id=02c3ec14-23be-4bc7-a399-e58dd0e7c846
# Mouse: https://produto.mercadolivre.com.br/MLB-1532404354-mouse-sem-fio-wireless-24ghz-usb-notebook-pc-alcance-10m-_JM?searchVariation=56732059015#searchVariation=56732059015&position=48&search_layout=grid&type=item&tracking_id=77b2f993-6b35-4e4a-8ac3-c39627c76a6f
# Capa Sapato: https://produto.mercadolivre.com.br/MLB-1708906118-capa-chuva-sapato-tenis-moto-protetor-silicone-calcadobrind-_JM?searchVariation=67535210386#searchVariation=67535210386&position=16&search_layout=grid&type=item&tracking_id=cfe8c149-bc9c-4e77-8f8f-efbbabafe797
# Capa: https://produto.mercadolivre.com.br/MLB-1166544924-capa-de-chuva-motoqueiro-nylon-pantaneiro-com-gola-_JM?searchVariation=32000740765#searchVariation=32000740765&position=20&search_layout=grid&type=item&tracking_id=cfe8c149-bc9c-4e77-8f8f-efbbabafe797
# Contratos email:
https://ngs.nipponflex.com/public/contracts?token=eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJpbnRlcnBlbm4iLCJleHAiOjE2MjcxMzIwNTMsImlhdCI6MTYyNzA0NTY1M30.AJkOUzTdzDxKznpJiVY21_Ivs2JglyWAbRRvwIxT1EC3vmloPrT2O8T0v8PoehocP7ukF8wLxxxiaLoaY-F3nA

## Juarez: Envio de contratos;
  - Erro esporádico ao salvar cadastro(foto whats cadastro, favoritos)
  - Data Registro Penn: tirar do Contrato e do sql dados_clientes?
  - Assinatura do contrato;
  - Está sendo validado Lote Ars na produção?
  - Botão Gerar Espelho Nota em produção;
  - Coluna Tipo;
=======

clicado no pac e almentado qtde no carrinho
Adicionado pelo carrinho | sedex;
Adicionado data de retirada, aumentado quantidade, troca filial, adicionado anotação;
Mudado modelo, aumentado quantidade no carrinho, pac, adicionado outro produto com pac e com quantidade, opção de pagamento ja adicionada;
Trocado filial no link transparente, clicado nos 3 tipos de entrega selecionado sedex;
Seleciona cliente, adicionad rápido, aumenta quantidade, clica venda futura duas vezes, depois clica pac;
Seleciona venda futura, depois selecina cliente, 
compra da energy, favorito, troca modelo, remove venda futura, entrega pac

## Pendente integração: Combinações para alteração de cliente;
## Pendente integração: Fazer um teste mandando um CPF repetido;
## Pendente integração: Ver alterção sem tipo de conta bancária;
## Adicionar totalizador no Venda Vinculo;
## Especificação de subtarefas do backlog do jira;
## Paulo: Treta da data de assinaturo do contrato;

## Erro no processo permissão e na listagem da fonte de dados;
=======
# cadastraDa da Bianca mandou zerado as informações sobre contratos;
# [Cadastro] Ele pode ter acesso até na pontuação, depois que o pai começar a evoluir ele pra DI o avo nao pode ter mais acesso.
# [Cadastro] Ver aquele problema que aparecia o ver entrevista pra cadastro que não tinha entrevista;
# Ver se o último entrevistador será notificado na realocação da entrevista;
# Criar status de cliente, Inativo;
# otimizar listarEntrevistadores
# Paulo: O que seria a Cota sequêncial?
# Paulo: "Mas podemos colocar o 30% correto!"
# Paulo: Faltando CNPJ nos cadastros da diretoria;
# Ascendência Genealógica > Data 2001, não foi possivel conclu... 
# Pedido PED0000043710 ISABELLY CARVALHO DE MATOS ME (aprovar Tef na prod);
# Juarez: Teria como deixar a impressão dos contratos em branco, se a consulta não retornar todos os dados, como o campo de assinatura?
# Adicionar opção select no filtro de usuario
# por isso é importante liberar pra pesquisar por email
# cadastraDa da Bianca mandou zerado as informações sobre contratos;
# tipo data no filtro relatorio rma;
# Permissão de duplicar CPF na produção;
# Permissões de processos Prod;
# https://makertec.atlassian.net/browse/IF-1594 - ainda listando duas pasrcela

## Bitrix;
## Tentar fazer sumir complemento com mensagem de endereço/

## [Pendente - Ajuste]Remover cadastros que duplicaram
## [Pendente - Ajuste] Continuar verificação de quando duplica cadastro;
## Marcara do telefone de consultor;
## Ver diferença de SPV lucas;

## Sobmedida no favoritos não habilita botão comprar;
## https://makertec.atlassian.net/browse/IF-1566 - Novos membros - Dash;
## Ajuste 34 e 35;
## Alterar um cadastro inativo que já tenha usuario
### Ver pedidos sem complemento;
## Procurar um pedido que tenha iten sobMedida e ver se foi como venda futura
### Pagamento acima de 7500, distribuindo SPV;
### Rever cadastro consultor - Apagar algumas sequences - Lote ars é obrigatório quando não tem kithash;


