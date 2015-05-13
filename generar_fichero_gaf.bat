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
bcp "SELECT CentroCostoCodigo,CuentaContableCodigo,centro_costo_desc,cuenta_contable,moneda,tipo_cuenta,subtipo_cuenta,saldo_normal,fecha_saldo,mes_saldo,trimestre_saldo,ano_saldo,saldoIniFiscalLocal,debitoFiscLocal,creditoFiscLocal,saldoFiscLocal,saldoIniFiscalDolar,creditoFiscDolar,saldoFiscDolar,PARTIDA, CENTRO_COSTO, ANO_FECHA,MES_FECHA,NOMBRE_PRESUPUESTO,PRESUPUESTO,PERIODO,TRIMESTRE_FECHA,ANO_MES_FECHA,TIPO_CAMBIO,MONTO_LOCAL,AMPLIACION_LOCAL,REDUCCION_LOCAL,PRESUPUESTADO_MES,PRESUPUESTADO_ACUMULADO,DIFERENCIA_ACUMULADO,DIFERENCIA_MES,COMPR_LOCAL,EJEDEV_LOCAL,PAGCOB_LOCAL,GASTO_REAL_MES,REAL_ACUMULADO,DISPONIBLE,DESCRIPCION,PARTIDA_DESCRIPCION,CENTRO_COSTO_DESCRIPCION,AGRUPACION_1,AGRUPACION_2,AGRUPACION_3,MONTO_DOLAR,AMPLIACION_DOLAR,REDUCCION_DOLAR,PRESUPUESTADO_MES,PRESUPUESTADO_MES_DOLAR,PRESUPUESTADO_ACUMULADO_DOLAR,DIFERENCIA_ACUMULADO_DOLAR,DIFERENCIA_MES_DOLAR,COMPR_DOLAR,EJEDEV_DOLAR,PAGCOB_DOLAR,PAGCOB_DOLAR,GASTO_REAL_MES_DOLAR,REAL_ACUMULADO_DOLAR,DISPONIBLE_DOLAR FROM presup_and_real WHERE (ANO_FECHA>=%year% AND MES_FECHA<=%month%) or (ANO_SALDO>=%year% AND MES_SALDO <= %month%) or (ANO_SALDO=%year% AND MES_SALDO=12)" queryout fichero_gaf_noheader.csv -c -t, -T -S JIMMYFIGUER7A21\SQLEXPRESS2
copy /b fichero_gaf_header.csv+fichero_gaf_noheader.csv fichero_gaf.csv

del fichero_gaf_noheader.csv
del fichero_gaf_header.csv
ECHO

:theend
