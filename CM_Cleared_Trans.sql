/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [CBClearedAccountTranID]
      ,[CBPostedAccountTranID] as 'ORIG_Tran_ID'
      ,CASE WHEN ([IsCleared] = '1') THEN 'C' 
		END AS 'Reconciliation_Status'
      ,[ClearedTransactionValue] as 'Cleared_Amount'
      ,CONVERT  (VARCHAR (10),[ClearedBankDate],101) as 'Cleared_Date'

  FROM [Singleton].[Secured].[CBClearedAccountTran]