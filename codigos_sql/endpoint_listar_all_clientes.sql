select cliente.id,     
        coalesce(pessoa.avatar, '/static/img/avatar.jpg') avatar,
        pessoa.codigo as codigo,      
        pessoa.nome,
        status.id status,
        filial.nome as filial_nome,     
        tipo.constante as tipo_constante,     
        tipo.descricao as tipo_descricao 
from mkr_cliente cliente 
    inner join mkr_pessoa pessoa on pessoa.id = cliente.id_pessoa  
    left join mkr_filial filial on filial.id = cliente.id_filial
    left join mkr_status_cliente status on status.id = cliente.id_status 
    left join mkr_tipo_cliente tipo on tipo.id = cliente.id_tipo 
where 1 = 1
order by cliente.id desc 
