/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [PCCommitmentChangeOrderItemID] as 'ORIG_Commit_CO_ITEM_ID'
      ,Commit_CO_ITEM.[PCCommitmentChangeOrderID]as 'ORIG_Commit_CO_ID'
      ,[PCSubcontractItemID] as 'ORIG_Commit_Item_ID'
      ,'' as 'Commitment'
      ,Commit_CO.Code as 'Commitment_CO'
      ,'' as 'Item_Number'
      ,JOB.PCProjectItemParentID as 'Job_ID'
      ,'' as 'Job'
      ,Job.Code as 'Cost_Code'
      --,[UnitID]
      --[UnitCostEnteredByUser] as 'Units'
      ,[TaxAmount] as 'Tax'
      ,[Amount] 
      --,[POCommittedAmount]
      --,[PCChangeRequestItemID]
      --,[POPCREOrderItemID]
      --,[StockItemID]
      --,[VendorItem]
      --,[VendorDescription]
      --,[BuyingPriceUnitID]
      --,Commit_CO_ITEM.[DeliveryDate]
      --,[SYSTaxGroupID]
      --,[OriginalTaxAmount]
      --,Commit_CO_ITEM.[WarehouseID]
      --,[POPAdditionalChargeID]
      --,[OriginalUnitCost]
      --,[Deleted]
      --,Commit_CO_ITEM.[PCPOChangeOrderStatusID]
      --,[POCommittedTaxAmount]
  FROM [Singleton].[Secured].[PCCommitmentChangeOrderItem] Commit_CO_ITEM
  JOIN Singleton.Secured.PCCommitmentChangeOrder Commit_CO on Commit_CO_ITEM.PCCommitmentChangeOrderID = Commit_CO.PCCommitmentChangeOrderID
  LEFT JOIN Singleton.Secured.PCProjectItem JOB on Commit_CO_ITEM.PCProjectItemID = JOB.PCProjectItemID
  