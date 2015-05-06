drop view vistal_real 

create view vistal_real as (
SELECT centrocostocodigo, 
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
WHERE cuentacontablecodigo <> '205-007-000-000' 
UNION ALL 
SELECT centro_costo_codigo as centrocostocodigo, 
       cuenta_contable_codigo as cuentacontablecodigo, 
	   mes_saldo, 
       ano_saldo, 
       max('') as centro_costo, 
       max('') AS cuenta_contable, 
       max('') as tipo_cuenta, 
       max('') as subtipo_cuenta, 
       max('') as saldo_normal, 
       max('') as fecha_saldo, 
       max('') as trimestre_saldo, 
       sum(0) as saldoinifiscallocal, 
       sum(debito_fisc_local) as debitofisclocal, 
       sum(0) as creditofisclocal, 
       sum(0) as saldofisclocal, 
       sum(0) as saldoinifiscaldolar, 
       sum(0) as creditofiscdolar, 
       sum(0) as saldofiscdolar 
FROM   exactus.dbo.activosfijos_temp  
group by 
       centro_costo_codigo,
       cuenta_contable_codigo,
	   mes_saldo, 
       ano_saldo
)