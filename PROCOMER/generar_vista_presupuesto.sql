USE [EXACTUS]
GO

/****** Object:  StoredProcedure [dbo].[generar_vista_presupuesto]    Script Date: 5/9/2015 5:49:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[generar_vista_presupuesto]
(
    @year       varchar(100),
    @month      varchar(100)
)
as

declare @sql nvarchar(4000)

--Generate column names in the passed EXCEL file
set @sql='drop table exactus.dbo.vista_presup_temp'
--exec(@sql)
EXEC Sp_executesql @sql; 

set @sql='select * into exactus.dbo.vista_presup_temp from exactus.procomer.detalle_presupuesto where ano_fecha >='+@year+' and mes_fecha <='+@month
--exec(@sql)
EXEC Sp_executesql @sql; 

set @sql='select count(*) from exactus.dbo.vista_presup_temp'
EXEC Sp_executesql @sql; 
GO


