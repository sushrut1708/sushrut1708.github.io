USE [TestDB]
GO
IF  EXISTS (SELECT 'b' FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateComment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateComment]
GO
/****** Object:  StoredProcedure [dbo].[UpdateComment]    Script Date: 08/11/2010 01:53:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		BT
-- Create date: <Create Date,,>
-- Description:	Update comment
-- =============================================
CREATE PROCEDURE [dbo].[UpdateComment]
(
	@UpdateMethod varchar(25),
	@Name varchar(50),
	@Website varchar(50),
	@Comment varchar(500),
	@ID varchar(2)
)
AS
BEGIN

	IF (@UpdateMethod ='dynamic')
		BEGIN
				-- dynamic query	
			DECLARE @strSQL varchar(1000)

			SET @strSQL = '
			UPDATE dbo.MyCommentS SET Name ='''+ @Name+''', Website='''+@Website+''', Comment = '''+@Comment+''' WHERE id = '+  @ID+''	
			exec(@strSQL) 
			print @strSQL
		END
	ELSE
		BEGIN
			UPDATE dbo.MyComments SET Name = @Name,
				Website=@Website, Comment = @Comment
				WHERE id = @ID 
		END
END
GO
/****** Object:  Table [dbo].[MyComments]    Script Date: 08/11/2010 01:53:21 ******/
IF  EXISTS (SELECT 'b' FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MyComments]') AND type in (N'U'))
DROP TABLE [dbo].[MyComments]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MyComments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NULL,
	[Email] [varchar](50) NULL,
	[Website] [varchar](50) NULL,
	[Comment] [varchar](5555) NULL,
	[LastUpdate] [datetime] NULL,
	[test] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_users]    Script Date: 08/11/2010 01:53:21 ******/
IF  EXISTS (SELECT 'b' FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_users]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_users]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_users](
	[username] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[secret] [varchar](50) NULL,
	[secret2] [varchar](50) NULL,
	[phone] [varchar](50) NULL,
	[address] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TestTable]    Script Date: 08/11/2010 01:53:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TestTable]') AND type in (N'U'))
DROP TABLE [dbo].[TestTable]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestTable](
	[ID] [int] NOT NULL,
	[Date] [datetime] NULL
) 
GO

/*populate tbl_users table*/
INSERT INTO dbo.tbl_users
	SELECT 'test@test.com', 'test1', 'secret1', 'secret2', '1234567890', '123 Sesame Street'
INSERT INTO dbo.tbl_users
	SELECT 'test2@test.com', 'test2', 'test2 secret', 'test2 secret2', '999999999', '999 MsDonald St.'
INSERT INTO dbo.tbl_users
	SELECT 'test3@test.com', 'test3', 'test3 secret', 'my secret', '1111111111', '222 hunter ridge'
INSERT INTO dbo.tbl_users
	SELECT 'test4@test.com', 'test4', 'test4 ...', 'test4 secret2', '888888888', '2498 East prat st'
	
/* Populate MyComments table*/
INSERT INTO dbo.MyComments
	SELECT 'test1', 'test1@test.com', 'http://www.google.com', 'test1 comment', getdate(), null

INSERT INTO dbo.MyComments
	SELECT 'test2', 'test2@test.com', 'http://www.google.com', 'test2 comment', getdate(), null
	
INSERT INTO dbo.MyComments
	SELECT 'test3', 'test3@test.com', 'http://www.google.com', 'test3 comment', getdate(), null
	
INSERT INTO dbo.MyComments
	SELECT 'test4', 'test4@test.com', 'http://www.google.com', 'test4 comment', getdate(), null
	