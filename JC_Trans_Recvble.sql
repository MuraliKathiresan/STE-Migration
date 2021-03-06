/****** Script for SelectTopNRows command from SSMS  ******/
SELECT Left(JOB.Code,2)+'-'+ Right(JOB.Code,3) as 'Job'
      --[CostCode] as 'Cost_Code' Will need to be changed for other than Job level billing
      --TRN.ProjectCode as 'Category'
      ,CASE WHEN ([PCProjectEntryDescriptorID] = '0') THEN 'Work billed'
			WHEN ([PCProjectEntryDescriptorID] = '1') THEN 'Cash receipt'
			WHEN ([PCProjectEntryDescriptorID] = '29') THEN 'Receivable Adjstment'
			END as 'Transaction_Type'
      ,'4' as 'Run'
      ,ROW_NUMBER() Over (Order By Job.Code) as Sequence
      ,CONVERT (VARCHAR,[TransactionDate],101) as 'Transaction_Date'
      ,CONVERT (VARCHAR, ACCTG.EndDate,101) as 'Accounting_Date'
      ,[Narrative] as 'Description'      
      ,[GoodsAmountInBaseCurrency] + TRN.TaxAmountInBaseCurrency  as 'Amount'
      ,TRN.Retainage
      ,TRN.RetainageBilled 
      ,TRN.NominalCostCentre + '-' + TRN.NominalDepartment + '-' + TRN.NominalAccountNumber as 'Credit_Account'
	  ,'JC' as 'Application_of_Origin'
	  ,'004' as 'Batch'
	  ,CASE WHEN ([PCProjectEntryDescriptorID] = '0') THEN [Reference] END as 'Invoice'
	  ,'' as 'Draw'
	  ,CASE WHEN ([PCProjectEntryDescriptorID] = '1') THEN [Reference] END as 'Cash_Receipt_ID'
	  ,[Reference] as 'Ref_1'
      ,[SecondReference] as 'Ref_2'
      ,Left(CNT.Code,2)+'-'+Right(CNT.Code,3) as 'Contract'
      ,CNT_ITEM.Code as 'Item'
   

  FROM Singleton.[Secured].[PCProjectEntry] TRN
  JOIN Singleton.Secured.PCProjectItem JOB on TRN.ProjectItemID = JOB.PCProjectItemID
  JOIN Singleton.Secured.PCContractItem CNT_ITEM on TRN.ContractItemID = CNT_ITEM.PCContractItemID
  JOIN Singleton.Secured.PCContract CNT on CNT_ITEM.PCContractID = CNT.PCContractID
  JOIN Singleton.Secured.SYSAccountingPeriod ACCTG on TRN.NominalAccountingPeriodID = ACCTG.SYSAccountingPeriodID
  WHERE TRN.PCProjectEntryDescriptorID = '0' -- AR Invoice Sent
  or TRN.PCProjectEntryDescriptorID ='1'     -- AR Payment Received
  or TRN.PCProjectEntryDescriptorID ='29'    -- AR Invoice Write Off

  ORDER BY JOB.Code

  
  