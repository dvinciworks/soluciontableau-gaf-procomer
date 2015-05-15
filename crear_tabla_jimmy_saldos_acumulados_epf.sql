USE [EXACTUS]
GO

/****** Object:  Table [dbo].[jimmy_saldos_acumulados_epf]    Script Date: 5/14/2015 9:27:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[jimmy_saldos_acumulados_epf](
	[cuentacontablecodigo] [nvarchar](50) NULL,
	[moneda] [nvarchar](10) NULL,
	[mes_saldo] [int] NULL,
	[ano_saldo] [int] NULL,
	[debitofisclocal] [real] NULL,
	[creditofisclocal] [real] NULL
) ON [PRIMARY]

GO


