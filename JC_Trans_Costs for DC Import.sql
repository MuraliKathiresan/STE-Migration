/****** Script for SelectTopNRows command from SSMS  ******/
SELECT JOBCC.TopLevelParentID as 'Job_ID'
      ,'DC' as 'Record_ID'
      ,'' as 'Job'
      ,'' as 'Extra'
      ,[CostCode] as 'Cost_Code'
      ,'' as 'Category'
      --TRN.ProjectCode as 'Category' - Needed for other than Singleton
      ,CASE WHEN  ([PCProjectEntryDescriptorID]= '2') THEN '1'
           --WHEN ([PCProjectEntryDescriptorID]= '14') THEN 'Committed cost' Included in Commit Cost Query
			WHEN ([PCProjectEntryDescriptorID]= '8') THEN '2'
			WHEN ([PCProjectEntryDescriptorID]= '20') THEN '2'
			--WHEN ([PCProjectEntryDescriptorID]= '27') THEN 'Committed cost' 
			WHEN ([PCProjectEntryDescriptorID]= '28') THEN '3'   
			WHEN ([PCProjectEntryDescriptorID]= '30') THEN '2' 
			END as 'Transaction_Type'
			
      ,CONVERT (VARCHAR (10),[TransactionDate],101) as 'Transaction_Date'
      ,CONVERT (VARCHAR (10),ACCTG.EndDate,101) as 'Accounting_Date'
      ,'"'+[Narrative]+'"' as 'Description'  
      ,TRN.Quantity as 'Units' -- [Quantity] as 'Units' causing problems with the import    
      ,'' as 'Unit_Cost'      
      ,[GoodsAmountInBaseCurrency] + TRN.TaxAmountInBaseCurrency as 'Amount'
      --,[NominalAccountNumber] as 'Debit_Account'
      ,'' as 'Debit_Account' -- Import will build the account which doesn't matter since we're not posting to GL anyway
      ,'' as 'Credit_Account'
      ,CASE WHEN ([SupplierAccountNumber] <>'') THEN [SupplierAccountNumber] 
			WHEN ([Reference]<>'') THEN [Reference]
			END AS 'Ref_1' -- Needs to be trimmed to 10 digits in Access
      ,CASE WHEN ([SupplierAccountNumber] <>'') THEN [Reference] 
			WHEN ([PayrollEmployeeID] <>'') THEN [PayID]
			WHEN ([SecondReference] <>'') THEN [SecondReference]
			END AS 'Ref_2' -- Needs to be trimmed to 10 digits in Access
      
  FROM [Singleton].[Secured].[PCProjectEntry] TRN
  JOIN Singleton.Secured.PCProjectItem JOBCC on TRN.ProjectItemID = JOBCC.PCProjectItemID
  JOIN Singleton.Secured.SYSAccountingPeriod ACCTG on TRN.NominalAccountingPeriodID = ACCTG.SYSAccountingPeriodID
  WHERE TRN.PCProjectEntryDescriptorID = '28'   -- Payroll
  --= '2' -- AP Invoice
  --or TRN.PCProjectEntryDescriptorID ='8'     -- Cost Adj
  --or TRN.PCProjectEntryDescriptorID = '20'   -- Cost Opening Balance
  ----or TRN.PCProjectEntryDescriptorID = '27'   -- Subcontract
  --or TRN.PCProjectEntryDescriptorID = '28'   -- Payroll
  --or TRN.PCProjectEntryDescriptorID = '30'   -- SM Direct Cost
  ----or TRN.PCProjectEntryDescriptorID = '36'   -- Potential Future Costs ?

  
  