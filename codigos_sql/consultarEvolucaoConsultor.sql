SELECT TRUE AS dados,
               p.pontos,
               coalesce(r.total > 0, FALSE) AS carta,
               coalesce(e.total > 0, FALSE) AS entrevista,
               coalesce(md.total > 0, FALSE) AS documentos
FROM MKR_CLIENTE c
LEFT JOIN LATERAL
  (SELECT a.pontos_individuais_realisado >= b.pontos_individuais
   AND a.pontos_requeridos_realisado >= b.pontos_requeridos
   AND b.rsa <= coalesce(ts.total, 0) AS pontos
   FROM
     (SELECT SUM(CASE
                     WHEN VV.id_consultor = :consultor THEN vv.pontos
                     ELSE 0
                 END) pontos_individuais_realisado,
             SUM(vv.pontos) pontos_requeridos_realisado
      FROM mkr_venda_vinculo VV
      LEFT JOIN
        (WITH RECURSIVE a AS
           (SELECT id_cliente,
                   ID_CLIENTE_PAI_EMPRESARIAL
            FROM MKR_CLIENTE_DADOS_COMERCIAIS
            WHERE ID_CLIENTE_PAI_EMPRESARIAL = :consultor
            UNION ALL SELECT d.id_cliente,
                             d.ID_CLIENTE_PAI_EMPRESARIAL
            FROM MKR_CLIENTE_DADOS_COMERCIAIS d
            JOIN a ON a.id_cliente = d.ID_CLIENTE_PAI_EMPRESARIAL) SELECT id_cliente,
                                                                          ID_CLIENTE_PAI_EMPRESARIAL
         FROM a) tr ON (vv.id_consultor = tr.id_cliente)
         where vv.id_consultor = :consultor or tr.id_cliente is not null
         ) a
   LEFT JOIN
     (SELECT sum(ra.pontos_individuais) pontos_individuais,
             sum(ra.pontos_requeridos) pontos_requeridos,
             sum(CASE
                     WHEN ra.requer_serial_ars = TRUE THEN 1
                     ELSE 0
                 END) rsa
      FROM mkr_regra_adesao ra left join mkr_cliente_dados_comerciais cdc on cdc.id_cliente = :consultor
      where cdc.PARTICIPOU_MMN = false or (cdc.PARTICIPOU_MMN = true and ra.fase > 1)
      ) b ON (1 = 1)
   LEFT JOIN
     (SELECT count(1) total
      FROM mkr_cliente c
      WHERE c.id = :consultor) ts ON 1 = 1) p ON 1 = 1
LEFT JOIN
  (SELECT count(*) total,
          mcdc.id_consultor,
          mcdc.id_cliente
   FROM mkr_cliente_dados_comerciais mcdc
   GROUP BY mcdc.id_consultor,
            mcdc.id_cliente) r ON c.id = r.id_consultor
LEFT JOIN
  (SELECT count(*) total,
          e.id_consultor
   FROM mkr_entrevista e
   WHERE e.dh_entrevista IS NOT NULL
   GROUP BY e.id_consultor) e ON c.id = e.id_consultor
LEFT JOIN
  (SELECT count(*) total,
          mc.id id_cliente
   FROM mkr_pessoa_documento mpd,
        mkr_cliente mc
   WHERE mc.id_pessoa = mpd.id_pessoa
   GROUP BY mc.id) md ON md.id_cliente = r.id_cliente
WHERE c.id = :consultor