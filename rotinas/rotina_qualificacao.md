=========================================================
ANTOLAK:

	QUA1: (Pedido pago)
		PED00552 | R$ 6.636,99

		QUA2: (Pedido não pago)
		PED00553 | R$ 6.636,99


	QUA3: (Pedido pago)
		PED00554 | R$ 3.618,49

		QUA4: (Pedido nao pago) 
		PED00555 | R$ 3.618,49

=========================================================
##Regras:
Estão qualificados todos os clientes que fizerem 1 ( ponto) dentro de 1 (mês);

##Montagem do Cenário:
- Remova os numeros dos pedidos acima;
- Certifique-se que os usuários QUA1, QUA2, QUA3 e QUA4 não está qualificado e não está cancelado;
- Faça uma compra com o usuário QUA1 e pegue essa compra (Maior que R$ 4800,00);
- Faça uma compra com o usuário QUA2 e não pegue essa compra (Maior que R$ 4800,00);
- Caso o usuário QUA3 tenha alguma compra no mês, mude a data para só ter uma. Faça uma compra com o usuário e pegue essa compra (Menor que R$ 4800,00);
- Faça uma compra com o usuário QUA4 e não pegue essa compra (Menor que R$ 4800,00);
- Adicione os numeros dos pedidos em cada usuário;

#Validações:
- O usuário QUA1 deve estar qualificado;
- O usuário QUA2 não deve estar qualificado;
- O usuário QUA3 não deve estar qualificado;
- O usuário QUA4 não deve estar qualificado.

Se todos os testes passaram, altere a data da compra dos usuários QUA1 e QUA3.
Verifica no relatório de qualificação;