SELECT pd.nome,
       pj.cnpj,
       pm.nome adminstrador,
       pf.cpf,
       pse.logradouro endereco,
       pse.cidade,
       pp.codigo codigo_pai,
       pp.nome nome_pai,
       e.id id_entrevista,
       ce.codigo_referencia codigo_entrevistador,
       ee.nome nome_entrevistador,
       e.id id_entrevista,
       mpe.email,
       concat ('(',pc.ddd, ')', pc.telefone ) as telefone
FROM mkr_cliente_dados_comerciais cdc,
     mkr_cliente cm,
     mkr_pessoa pm,
     mkr_pessoa pd,
     mkr_cliente cd,
     mkr_pessoa_juridica pj,
     mkr_pessoa_fisica pf,
     mkr_cliente cp,
     mkr_pessoa pp,
     mkr_entrevista e,
     mkr_cliente ce,
     mkr_pessoa_email mpe,
     mkr_pessoa ee,
     mkr_pessoa_telefone pc,
     (select pse.*,cc.descricao cidade from mkr_pessoa_endereco pse left join mkr_cidade cc on cc.id = pse.id_cidade) pse
WHERE cdc.id_cliente = cd.id
  AND cdc.id_consultor = cm.id
  AND cm.id_pessoa = pm.id
  AND cd.id_pessoa = pd.id
  AND cdc.id_consultor = e.id_consultor
  AND pd.id = pj.id_pessoa
  AND pm.id = pf.id_pessoa
  and mpe.id_pessoa = pd.id
  AND cdc.id_cliente_pai_empresarial = cp.id
  AND cp.id_pessoa = pp.id
  AND e.id = :id_entrevista
  AND pse.id_pessoa = pm.id
  AND ce.id = e.id_entrevistador
  AND ee.id = ce.id_pessoa
  limit 1
