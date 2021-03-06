/****** Script for SelectTopNRows command from SSMS  ******/
SELECT JOBCC.TopLevelParentID as 'Job_ID'
      ,'' as 'Job'
      ,[CostCode] as 'Cost_Code'
      --TRN.ProjectCode as 'Category' - Needed for other than Singleton
      ,'5' as 'Run'
      ,ROW_NUMBER() Over (Order By JOBCC.TopLevelParentID) as Sequence
      ,CASE WHEN ([PCProjectEntryDescriptorID]= '14') THEN 'Committed cost' 
			WHEN ([PCProjectEntryDescriptorID]= '26') THEN 'Aprvd cmmtt cst chng'
			WHEN ([PCProjectEntryDescriptorID]= '27') THEN 'Committed cost'
			WHEN ([PCProjectEntryDescriptorID]= '31') THEN 'Aprvd cmmtt cst chng'
			WHEN ([PCProjectEntryDescriptorID]= '32') THEN 'Pndng cmmtt cst chng'
			WHEN ([PCProjectEntryDescriptorID]= '33') THEN 'Pndng cmmtt cst chng'   
			WHEN ([PCProjectEntryDescriptorID]= '49') THEN '??' 
			WHEN ([PCProjectEntryDescriptorID]= '50') THEN '??' 
			END as 'Transaction_Type'
			
      ,CONVERT (VARCHAR,[TransactionDate],101) as 'Transaction_Date'
      --,CONVERT (VARCHAR,[TransactionDate],101) as 'Accounting_Date'
            
      ,[GoodsAmountInBaseCurrency] + TRN.TaxAmountInBaseCurrency as 'Amount'
      ,[Quantity] as 'Units'
      ,[SupplierAccountNumber] as 'Vendor'
      ,'Purchase order' as 'Commitment_Type'
      ,[Reference] as 'Commitment'
      ,[SecondReference] as 'Commitment_Line_Item'
      ,[Narrative] as 'Description'

      ,'JC' as 'Application_of_Origin'
      ,'005' as 'Batch'

  FROM [Singleton].[Secured].[PCProjectEntry] TRN
  JOIN Singleton.Secured.PCProjectItem JOBCC on TRN.ProjectItemID = JOBCC.PCProjectItemID
  WHERE TRN.PCProjectEntryDescriptorID = '14' -- Purchase Order
  or TRN.PCProjectEntryDescriptorID = '26'    -- Approved Sub Change Order
  or TRN.PCProjectEntryDescriptorID = '27'	  -- Subcontract
  or TRN.PCProjectEntryDescriptorID = '31'    -- Approved PO Change Order
  or TRN.PCProjectEntryDescriptorID = '32'    -- Pending Sub Change Order
  or TRN.PCProjectEntryDescriptorID = '33'    -- Pending PO Change Order
  or TRN.PCProjectEntryDescriptorID = '49'    -- Subcontract Revision Commit
  or TRN.PCProjectEntryDescriptorID = '50'    -- PO Revision Commit
  
  