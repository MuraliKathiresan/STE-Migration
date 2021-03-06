/****** Script for SelectTopNRows command from SSMS  ******/
SELECT BANK.AccountCode as 'Bank'
      ,CONVERT  (VARCHAR (10),[ReconciliationDate],101) as 'Statement_Date'
      ,[OpeningBalance] as 'Opening_Balance'
      ,[ClosingBalance] as 'Ending_Balance'
      ,[CBAccountBalance] as 'Account_Balance'


  FROM [Singleton].[Secured].[CBReconciliation] REC
  JOIN Singleton.Secured.CBAccount BANK on REC.CBAccountID = BANK.CBAccountID
  ORDER BY BANK.AccountCode, [ReconciliationDate] 