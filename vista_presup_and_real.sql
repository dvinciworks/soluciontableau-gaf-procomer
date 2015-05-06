CREATE VIEW presup_and_real 
AS 
  (SELECT r.centrocostocodigo, 
          r.cuentacontablecodigo, 
          r.centro_costo AS centro_costo_desc, 
          r.cuenta_contable, 
          r.tipo_cuenta, 
          r.subtipo_cuenta, 
          r.saldo_normal, 
          r.fecha_saldo, 
          r.mes_saldo, 
          r.trimestre_saldo, 
          r.ano_saldo, 
          r.saldoinifiscallocal, 
          r.debitofisclocal, 
          r.creditofisclocal, 
          r.saldofisclocal, 
          r.saldoinifiscaldolar, 
          r.creditofiscdolar, 
          r.saldofiscdolar, 
          p.partida, 
          p.centro_costo, 
          p.ano_fecha, 
          p.mes_fecha, 
          p.nombre_presupuesto, 
          p.presupuesto, 
          p.periodo, 
          p.trimestre_fecha, 
          p.ano_mes_fecha, 
          p.tipo_cambio, 
          p.monto_local, 
          p.ampliacion_local, 
          p.reduccion_local, 
          p.presupuestado_mes, 
          p.presupuestado_acumulado, 
          p.diferencia_acumulado, 
          p.diferencia_mes, 
          p.compr_local, 
          p.ejedev_local, 
          p.pagcob_local, 
          p.gasto_real_mes, 
          p.real_acumulado, 
          p.disponible, 
          p.descripcion, 
          p.partida_descripcion, 
          p.centro_costo_descripcion, 
          p.agrupacion_1, 
          p.agrupacion_2, 
          p.agrupacion_3, 
          p.monto_dolar, 
          p.ampliacion_dolar, 
          p.reduccion_dolar, 
          p.presupuestado_mes_dolar, 
          p.presupuestado_acumulado_dolar, 
          p.diferencia_acumulado_dolar, 
          p.diferencia_mes_dolar, 
          p.compr_dolar, 
          p.ejedev_dolar, 
          p.pagcob_dolar, 
          p.gasto_real_mes_dolar, 
          p.real_acumulado_dolar, 
          p.disponible_dolar 
   FROM   vistal_real r 
          FULL OUTER JOIN (SELECT * 
                           FROM   vista_presupuesto) p 
                       ON ( r.ano_saldo = p.ano_fecha 
                            AND r.mes_saldo = p.mes_fecha 
                            AND r.centrocostocodigo = p.centro_costo 
                            AND r.cuentacontablecodigo = p.partida )) 