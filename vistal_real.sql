DROP VIEW vistal_real 

CREATE VIEW vistal_real 
AS 
  (SELECT centrocostocodigo, 
          cuentacontablecodigo, 
          mes_saldo, 
          ano_saldo, 
          centro_costo, 
          Replace(cuenta_contable, ',', '') AS cuenta_contable, 
          tipo_cuenta, 
          subtipo_cuenta, 
          saldo_normal, 
          fecha_saldo, 
          trimestre_saldo, 
          saldoinifiscallocal, 
          debitofisclocal, 
          creditofisclocal, 
          saldofisclocal, 
          saldoinifiscaldolar, 
          creditofiscdolar, 
          saldofiscdolar 
   FROM   exactus.procomer.softlandbi_cg_saldcuencontable 
   WHERE  cuentacontablecodigo <> '205-007-000-000' 
   UNION ALL 
   SELECT centro_costo_codigo        AS centrocostocodigo, 
          cuenta_contable_codigo     AS cuentacontablecodigo, 
          mes_saldo, 
          ano_saldo, 
          Max(ccosto.descripcion)    AS centro_costo, 
          Max(ccontable.descripcion) AS cuenta_contable, 
          Max('')                    AS tipo_cuenta, 
          Max('')                    AS subtipo_cuenta, 
          Max('')                    AS saldo_normal, 
          Max('')                    AS fecha_saldo, 
          Max('')                    AS trimestre_saldo, 
          Sum(0)                     AS saldoinifiscallocal, 
          Sum(debito_fisc_local)     AS debitofisclocal, 
          Sum(0)                     AS creditofisclocal, 
          Sum(0)                     AS saldofisclocal, 
          Sum(0)                     AS saldoinifiscaldolar, 
          Sum(0)                     AS creditofiscdolar, 
          Sum(0)                     AS saldofiscdolar 
   FROM   exactus.dbo.activosfijos_temp 
          JOIN exactus.procomer.centro_costo ccosto 
            ON exactus.dbo.activosfijos_temp.centro_costo_codigo = 
               ccosto.centro_costo 
          JOIN exactus.procomer.cuenta_contable ccontable 
            ON exactus.dbo.activosfijos_temp.cuenta_contable_codigo = 
               ccontable.cuenta_contable 
   GROUP  BY centro_costo_codigo, 
             cuenta_contable_codigo, 
             mes_saldo, 
             ano_saldo) 