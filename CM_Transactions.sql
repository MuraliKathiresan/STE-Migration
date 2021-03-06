/****** Script for SelectTopNRows command from SSMS  ******/
SELECT BANK.AccountCode as 'Bank'
      ,[CBPostedAccountTranID] as 'ORIG_Trans_ID'
      ,'1' as 'Run'
      ,'0' as 'Sequence'
      ,CASE WHEN ([CBTranTypeID] = 1) THEN 'Adj'
			WHEN ([CBTranTypeID] = 2) THEN 'Dep'
			WHEN ([CBTranTypeID] = 3) THEN 'Chk'
			WHEN ([CBTranTypeID] = 6) THEN 'Chk'
			WHEN ([CBTranTypeID] = 8) THEN 'Wdl'
			WHEN ([CBTranTypeID] = 12) THEN 'Adj'
			WHEN ([CBTranTypeID] = 13) THEN 'Dep'
			WHEN ([CBTranTypeID] = 14) THEN 'Adj'
			WHEN ([CBTranTypeID] = 15) THEN 'Adj'
			END AS 'Type'
      ,[TransactionDescription] as 'Description'
      ,CONVERT  (VARCHAR (10),[AccountingDate],101) as 'Accounting_Date'
      ,CONVERT  (VARCHAR (10),[PostedDate],101) as 'Reference_Date'

      ,CASE WHEN ([CBTranTypeID] = 1) THEN isNull([TransactionValue]*-1,0)-- isNull is not working on these 
			WHEN ([CBTranTypeID] = 3) THEN isNull([TransactionValue]*-1,0)
			WHEN ([CBTranTypeID] = 6) THEN isNull([TransactionValue]*-1,0)
			WHEN ([CBTranTypeID] = 8) THEN isNull([TransactionValue]*-1,0)
			WHEN ([CBTranTypeID] = 12) THEN isNull([TransactionValue]*-1,0) -- Need to look at Adj entries - STO can't have negative subtractions or additions 
			WHEN ([CBTranTypeID] = 14) THEN isNull([TransactionValue]*-1,0) -- How to say if it's a negative amt put it in Subtraction and reverse the sign
			WHEN ([CBTranTypeID] = 15) THEN isNull([TransactionValue]*-1,0) -- 1, 12, 14, 15
			END AS 'Subtraction'
			
      ,CASE WHEN ([CBTranTypeID] = 2) THEN [TransactionValue]
			WHEN ([CBTranTypeID] = 13) THEN [TransactionValue]
			END AS 'Addition'
      ,'1' as 'Posted'			
	  ,'' as 'Check'
      ,CASE WHEN ([CBTranTypeID] = 1) THEN (isNull([TransactionReference],'')) -- isNull is not working on these 
			WHEN ([CBTranTypeID] = 3) THEN (isNull([TransactionReference],''))
			WHEN ([CBTranTypeID] = 6) THEN (isNull([TransactionReference],''))
			WHEN ([CBTranTypeID] = 8) THEN (isNull([TransactionReference],''))
			WHEN ([CBTranTypeID] = 14) THEN (isNull([TransactionReference],''))
			WHEN ([CBTranTypeID] = 15) THEN (isNull([TransactionReference],''))
			END AS 'Payee'
		,isNull(CMT.Reverses_CBPostedAccountTranID,'') as 'Voided_Trans_ID'
		,'CM' as 'Application_of_Origin'
		,'001' as 'Batch'
		,'' as 'Reconciliation_Status'
		,'0' as 'Cleared_Amount'
		,'' as 'Cleared_Date'
		,'0' as 'Voided'
		,'' as 'Void_Date'
		,'0' as 'Voided_Amount'	
		,CMT.Reverses_CBPostedAccountTranID

  FROM [Singleton].[Secured].[CBPostedAccountTran] CMT
  JOIN Singleton.Secured.CBAccount BANK on CMT.CBAccountID = BANK.CBAccountID