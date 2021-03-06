/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [AccountCostCentre] +'-'+[AccountDepartment]+'-'+[AccountNumber] as 'Account'
      ,[AccountName] as 'Account_Title'
      ,CASE WHEN ([AccountCategory]='0') THEN 'Current assets' 
			WHEN ([AccountCategory]='1') THEN 'Noncurrent assets'
			WHEN ([AccountCategory]='2') THEN 'Current liab'
			WHEN ([AccountCategory]='3') THEN 'Noncurrent liab'
			WHEN ([AccountCategory]='4') THEN 'Equity'
			WHEN ([AccountCategory]='5') THEN 'Retained earnings'
			WHEN ([AccountCategory]='6') THEN 'Units'
			WHEN ([AccountCategory]='7') THEN 'Income'
			WHEN ([AccountCategory]='8') THEN 'Other income'
			WHEN ([AccountCategory]='9') THEN 'Cost'
			WHEN ([AccountCategory]='10') THEN 'Expense'
			WHEN ([AccountCategory]='11') THEN 'Suspense'
			END AS 'Account_Type'
      ,[StoreBudgets]

  FROM [Singleton].[Secured].[NLNominalAccount]