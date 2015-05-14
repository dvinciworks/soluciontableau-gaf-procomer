@ECHO OFF

:loop
IF NOT "%1"=="" (
    IF "%1"=="-a" (
        SET year=%2
        SHIFT
    )
    IF "%1"=="-m" (
        SET month=%2
        SHIFT
    )
    IF "%1"=="-t" (
        SET tipo_cambio=%2
        SHIFT
    )
    SHIFT
    GOTO :loop
)

ECHO Anio = %year%
ECHO Mes = %month%
ECHO Tipo Cambio Mes = %tipo_cambio%
ECHO 

ECHO Cargando tipo de cambio del mes ...
bcp "exec exactus.dbo.cargar_tipo_cambio %year%, %month%, %tipo_cambio%" queryout fout_tc.txt -c -t , -T -S JIMMYFIGUER7A21\SQLEXPRESS2
ECHO

ECHO Cargando tabla temporal activos fijos ...
bcp "exec exactus.dbo.cargar_fichero_activosfijos" queryout fout2.txt -c -t , -T -S JIMMYFIGUER7A21\SQLEXPRESS2
del fout2.txt
ECHO

ECHO Generando fichero presupuesto...
del fichero_gaf.csv
ECHO

ECHO Generando tabla temporal ...
bcp "exec exactus.dbo.generar_vista_presupuesto %year%, %month%" queryout fout.txt -c -t , -T -S JIMMYFIGUER7A21\SQLEXPRESS2

ECHO Generando fichero .csv
bcp "SELECT 'CentroCostoCodigo','CuentaContableCodigo','centro_costo_desc','cuenta_contable','moneda','tipo_cuenta','subtipo_cuenta','saldo_normal','fecha_saldo','mes_saldo','trimestre_saldo','ano_saldo','saldoIniFiscalLocal','debitoFiscLocal','creditoFiscLocal','saldoFiscLocal','saldoIniFiscalDolar','creditoFiscDolar','saldoFiscDolar','PARTIDA', 'CENTRO_COSTO', 'ANO_FECHA','MES_FECHA','NOMBRE_PRESUPUESTO','PRESUPUESTO','PERIODO','TRIMESTRE_FECHA','ANO_MES_FECHA','TIPO_CAMBIO','MONTO_LOCAL','AMPLIACION_LOCAL','REDUCCION_LOCAL','PRESUPUESTADO_MES','PRESUPUESTADO_ACUMULADO','DIFERENCIA_ACUMULADO','DIFERENCIA_MES','COMPR_LOCAL','EJEDEV_LOCAL','PAGCOB_LOCAL','GASTO_REAL_MES','REAL_ACUMULADO','DISPONIBLE','DESCRIPCION','PARTIDA_DESCRIPCION','CENTRO_COSTO_DESCRIPCION','AGRUPACION_1','AGRUPACION_2','AGRUPACION_3','MONTO_DOLAR','AMPLIACION_DOLAR','REDUCCION_DOLAR','PRESUPUESTADO_MES','PRESUPUESTADO_MES_DOLAR','PRESUPUESTADO_ACUMULADO_DOLAR','DIFERENCIA_ACUMULADO_DOLAR','DIFERENCIA_MES_DOLAR','COMPR_DOLAR','EJEDEV_DOLAR','PAGCOB_DOLAR','PAGCOB_DOLAR','GASTO_REAL_MES_DOLAR','REAL_ACUMULADO_DOLAR','DISPONIBLE_DOLAR' " queryout fichero_gaf_header.csv -c -t, -T -S JIMMYFIGUER7A21\SQLEXPRESS2
bcp "SELECT CentroCostoCodigo,CuentaContableCodigo,centro_costo_desc,cuenta_contable,moneda,tipo_cuenta,subtipo_cuenta,saldo_normal,fecha_saldo,mes_saldo,trimestre_saldo,ano_saldo,saldoIniFiscalLocal,debitoFiscLocal,creditoFiscLocal,saldoFiscLocal,saldoIniFiscalDolar,creditoFiscDolar,saldoFiscDolar,PARTIDA, CENTRO_COSTO, ANO_FECHA,MES_FECHA,NOMBRE_PRESUPUESTO,PRESUPUESTO,PERIODO,TRIMESTRE_FECHA,ANO_MES_FECHA,TIPO_CAMBIO,MONTO_LOCAL,AMPLIACION_LOCAL,REDUCCION_LOCAL,PRESUPUESTADO_MES,PRESUPUESTADO_ACUMULADO,DIFERENCIA_ACUMULADO,DIFERENCIA_MES,COMPR_LOCAL,EJEDEV_LOCAL,PAGCOB_LOCAL,GASTO_REAL_MES,REAL_ACUMULADO,DISPONIBLE,DESCRIPCION,PARTIDA_DESCRIPCION,CENTRO_COSTO_DESCRIPCION,AGRUPACION_1,AGRUPACION_2,AGRUPACION_3,MONTO_DOLAR,AMPLIACION_DOLAR,REDUCCION_DOLAR,PRESUPUESTADO_MES,PRESUPUESTADO_MES_DOLAR,PRESUPUESTADO_ACUMULADO_DOLAR,DIFERENCIA_ACUMULADO_DOLAR,DIFERENCIA_MES_DOLAR,COMPR_DOLAR,EJEDEV_DOLAR,PAGCOB_DOLAR,PAGCOB_DOLAR,GASTO_REAL_MES_DOLAR,REAL_ACUMULADO_DOLAR,DISPONIBLE_DOLAR FROM presup_and_real WHERE (ANO_FECHA>=%year% AND MES_FECHA<=%month%) or (ANO_SALDO>=%year% AND MES_SALDO <= %month%) UNION ALL SELECT centrocostocodigo, cuentacontablecodigo,  replace(centro_costo_desc,',','') as  centro_costo_desc, replace(cuenta_contable, ',','') as  cuenta_contable,  moneda,  max(tipo_cuenta) as tipo_cuenta,  max(subtipo_cuenta) as subtipo_cuenta,  max(saldo_normal) as saldo_normal,  max(fecha_saldo) as fecha_saldo,  max(12) as mes_saldo,  max(trimestre_saldo) as trimestre_saldo,  max(2014) as ano_saldo,  sum(saldoinifiscallocal) as saldoinifiscallocal,  sum(debitofisclocal) as debitofisclocal,  sum(creditofisclocal) as creditofisclocal,  sum(saldofisclocal) as saldofisclocal,  sum(saldoinifiscaldolar) as saldoinifiscaldolar,  sum(creditofiscdolar) as creditofiscdolar,  sum(saldofiscdolar) as saldofiscdolar,  null as partida,  null as centro_costo,  null as ano_fecha,  null as mes_fecha,  null as nombre_presupuesto,  null as presupuesto,  null as periodo,  null as trimestre_fecha,  null as ano_mes_fecha,  null as tipo_cambio,  null as monto_local,  null as ampliacion_local,  null as reduccion_local,  null as presupuestado_mes,  null as presupuestado_acumulado,  null as diferencia_acumulado,  null as diferencia_mes,  null as compr_local,  null as ejedev_local,  null as pagcob_local,  null as gasto_real_mes,  null as real_acumulado,  null as disponible,  null as descripcion,  null as partida_descripcion,  null as centro_costo_descripcion,  null as agrupacion_1,  null as agrupacion_2,  null as agrupacion_3,  null as monto_dolar,  null as ampliacion_dolar,  null as reduccion_dolar,  null as presupuestado_mes,  null as presupuestado_mes_dolar,  null as presupuestado_acumulado_dolar,  null as diferencia_acumulado_dolar,  null as diferencia_mes_dolar,  null as compr_dolar,  null as ejedev_dolar,  null as pagcob_dolar,  null as pagcob_dolar,  null as gasto_real_mes_dolar,  null as real_acumulado_dolar,  null as disponible_dolar FROM presup_and_real WHERE  ano_saldo <= %year% group by centrocostocodigo,  cuentacontablecodigo,  centro_costo_desc,  cuenta_contable,  moneda" queryout fichero_gaf_noheader.csv -c -t, -T -S JIMMYFIGUER7A21\SQLEXPRESS2
copy /b fichero_gaf_header.csv+fichero_gaf_noheader.csv fichero_gaf.csv

del fichero_gaf_noheader.csv
del fichero_gaf_header.csv
ECHO

:theend
