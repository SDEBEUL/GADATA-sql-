CREATE Procedure sp_SMTPMail

	@SenderName varchar(100),
	@SenderAddress varchar(100),
	@RecipientName varchar(100),
	@RecipientAddress varchar(100),
	@Subject varchar(200),
	@Body varchar(8000),
	@MailServer varchar(100) = 'mailrelay.volvocars.net'
AS	
SET nocount on
declare @oMail int --Object reference
declare @resultcode int
	
EXEC @resultcode = sp_OACreate 'SMTPsvg.Mailer', @oMail OUT

 if @resultcode = 0
	BEGIN
		EXEC @resultcode = sp_OASetProperty @oMail, 'RemoteHost',  @mailserver
		EXEC @resultcode = sp_OASetProperty @oMail, 'FromName', @SenderName
		EXEC @resultcode = sp_OASetProperty @oMail, 'FromAddress',  @SenderAddress
		EXEC @resultcode = sp_OAMethod @oMail, 'AddRecipient', NULL, @RecipientName,  @RecipientAddress
		EXEC @resultcode = sp_OASetProperty @oMail, 'Subject', @Subject
		EXEC @resultcode = sp_OASetProperty @oMail, 'BodyText', @Body
		EXEC @resultcode = sp_OAMethod @oMail, 'SendMail', NULL
        EXEC sp_OADestroy @oMail
	END	
SET nocount off

/*
exec sp_SMTPMail 
@SenderName='me', 
@SenderAddress='SDEBEUL@volvocars.com', 
@RecipientName = 'me', 
@RecipientAddress = 'SDEBEUL@volvocars.com', 
@Subject='SQL Test', 
@body='Hello, this is a test email from SQL Server'*/