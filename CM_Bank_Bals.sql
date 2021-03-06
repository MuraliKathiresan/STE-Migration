/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [AccountCode] as 'Bank'
      ,BANK.AccountDescription as 'Description'
      ,[CurrentBalanceInAccntCurrency] as 'Register_Balance'
      ,AcctNo.AccountNumber as 'Account_Number'
      ,BANK.BankAccountNominalCostCentre + '-'+ BANK.BankAccountNominalDepartment +'-'+ BANK.BankAccountNominalNumber as 'General_Cash_Account'
      ,'' as 'AP_Check_Format' -- Customer needs to setup ?
      ,isNull(BANK.PRCheckFormat,'') as 'PR_Check_Format'

  FROM [Singleton].[Secured].[CBAccount] BANK
  JOIN [Singleton].[Secured].[CBAccountPriv] AcctNo on BANK.CBAccountID = AcctNo.CBAccountID