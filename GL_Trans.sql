/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 'GLT' as 'Record_ID'
      ,ACCT.AccountCostCentre + '-' + ACCT.AccountDepartment +'-'+ACCT.AccountNumber as 'Account'
      ,CONVERT (VARCHAR (10),[AccountingDate],101) as 'Accounting_Date'
      ,'' as 'Journal'
      ,Right([Reference1],10) as 'Reference_1'
      ,Right([SubledgerAccountNumber],10) as 'Reference_2'
      ,Right([Description],30) as 'Transaction_Desc'
      ,[GoodsValueInBaseCurrency] as 'Debit'
      ,'' as 'Credit'
      ,'Accrual' as 'Accrual_or_Cash' 
      


  FROM [Singleton].[Secured].[NLPostedNominalTran] TRN
  JOIN Singleton.Secured.NLNominalAccount ACCT on TRN.NLNominalAccountID = ACCT.NLNominalAccountID
  Where [AccountingDate] >='10/01/2009' and [AccountingDate] <= '09/30/2010' and TRN.SourceTranTypeID <>'10' -- Excludes YE entries.
  -- Singleton is not on a calendar year