/****** Script for SelectTopNRows command from SSMS  ******/
SELECT JOB.Code as 'Job'
      --[CostCode] as 'Cost_Code' Will need to be changed for other than Job level billing
      --TRN.ProjectCode as 'Category'
      ,CASE WHEN ([PCProjectEntryDescriptorID] = '46') THEN 'Scheduled value'
			WHEN ([PCProjectEntryDescriptorID] = '47') THEN 'Pndng schdl val chng'
			WHEN ([PCProjectEntryDescriptorID] = '48') THEN 'Aprvd schdl val chng'   
			END as 'Transaction_Type'
      ,'3' as 'Run'
      ,ROW_NUMBER() Over (Order By Job.code) as Sequence
      ,CONVERT (VARCHAR,[TransactionDate],101) as 'Transaction_Date'
      ,[Narrative] as 'Description'      
      ,[GoodsAmountInBaseCurrency] + TRN.TaxAmountInBaseCurrency  as 'Amount'
      ,TRN.ValueToBillInBaseCurrency
      --,CR_Item.ChangeToContractAmount 
	  ,'JC' as 'Application_of_Origin'
	  ,'003' as 'Batch'
      ,[Reference] as 'Ref_1'
      ,[SecondReference] as 'Ref_2'
      ,TRN.ContractItemID
      ,left(CNT.Code,2)+'-'+ Right(CNT.Code,3)as 'Contract'
      ,CNT_ITEM.Code as 'Item'


  FROM Singleton.[Secured].[PCProjectEntry] TRN
  LEFT JOIN Singleton.Secured.PCProjectItem JOB on TRN.ProjectItemID = JOB.PCProjectItemID
  LEFT JOIN Singleton.Secured.PCContractItem CNT_ITEM on TRN.ContractItemID = CNT_ITEM.PCContractItemID
  LEFT JOIN Singleton.Secured.PCContract CNT on CNT_ITEM.PCContractID = CNT.PCContractID
  -- LEFT JOIN Vital.Secured.PCChangeRequestItem CR_Item on TRN.ContractItemID = CR_ITem.PCContractItemID
  
  WHERE TRN.PCProjectEntryDescriptorID = '46' -- Approved SOV
     or TRN.PCProjectEntryDescriptorID = '47' -- Pending SOV Changes
     or TRN.PCProjectEntryDescriptorID = '48' -- Approved SOV Changes
  ORDER BY JOB.Code

  
  