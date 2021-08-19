select c.*,ds.dados_socios from view_dados_pessoa c
left join lateral (select trim(string_agg( distinct ds.nome || coalesce(', RG ' || ds.rg,'') || 
	coalesce( ', CPF ' || ds.cpf,'') || ', empresário(a), ' || coalesce(ds.nacionalidade,'Brasileiro')
	|| coalesce(', ' || ds.estado_civil,'') || ' ' || coalesce('com regime de ' || ds.regime_bens,'') 
	|| coalesce(', natural de ' || ds.naturalidade,'') 
	|| coalesce(', domicílio residencial na ' || ds.endereco,'') 
	|| coalesce(', Nº ' || trim(ds.numero),'') 
	|| coalesce(', ' || ds.bairro,'') 
	|| coalesce(', ' || ds.complemento, '')
	|| coalesce(', cep ' || ds.cep,'') 
	|| coalesce(', ' || ds.cidade || ' - ' || ds.estado,''), ' e por ')) dados_socios,ps.id_pessoa 
	from 
	view_dados_pessoa ds,mkr_pessoa_socio ps 
	where ds.id_pessoa = ps.id_socio and ps.qualificado = true
	group by ps.id_pessoa) ds on ds.id_pessoa = c.id_pessoa
where 1 = 1 
and c.id_cliente = :id_cliente