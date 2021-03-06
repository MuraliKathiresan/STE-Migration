/****** Script for SelectTopNRows command from SSMS  ******/
SELECT Commt.OrderNo as 'Commitment'
	  ,Commit_Item.[PCSubcontractItemID] as 'ORIG_Commit_Item_ID'
      ,Commit_Item.[PCSubcontractID] as 'ORIG_Commit_ID'
      ,[SequenceNumber] as 'Item_Number'
      ,Commit_Item.[Description]
      ,JOB.PCProjectItemParentID as 'Job_ID'
      ,'' as 'Job'
      ,JOB.Code as 'Cost_Code'
      ,Commit_Item.[Quantity] as 'Units'
      ,Commit_Item.[UnitCost] as 'Unit_Cost'
      ,Commit_Item.OriginalTaxAmount as 'Tax'
      ,Commit_Item.OriginalAmount as 'Amount'
      ,(Commit_Item.OriginalAmount - TotalAmount) *-1 as 'Approved_Commitment_CO_Amount'
      ,Commit_Item.[TaxAmount] as 'Approved_Commitment_CO_Tax_Amount'
      ,Commit_Item.TotalAmount as 'Revised_Amount'
      ,'0' as 'Pending_Commitment_CO_Amount'  -- get this amt from commit change orders (?)
      ,[AmountInvoicedWithTax]as 'Amount_Invoiced'
      ,[RetainageAmountInvoiced] as 'Amount_Being_Retained'


  FROM [Singleton].[Secured].[PCSubcontractItem] Commit_Item
  JOIN Singleton.Secured.PCSubcontract COMMT on Commit_Item.PCSubcontractID = COMMT.PCSubcontractID
  LEFT JOIN Singleton.Secured.PCProjectItem JOB on Commit_Item.PCProjectItemID = JOB.PCProjectItemID
  ORDER BY Commt.OrderNo 
  
 
  