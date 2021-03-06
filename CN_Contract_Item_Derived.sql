/****** Script for SelectTopNRows command from SSMS  ******/
SELECT CNT.Code as 'Contract'
      ,'' as 'Contract_Item'
      ,CNT_ITEM.Code as 'ORIG_Contract_Item' 
      ,[ScheduledValue]+[ScheduledValueRevision] as 'Revised_Contract'
      ,[ScheduledValueRevision] as 'Approved_Contract_Changes'

  FROM [Singleton].[Secured].[PCContractItem]CNT_ITEM
  JOIN Singleton.Secured.PCContract CNT on CNT_ITEM.PCContractID = CNT.PCContractID
  LEFT JOIN Singleton.Secured.PCProjectItem JOB on CNT_ITEM.PCProjectItemID = JOB.PCProjectItemID
  LEFT JOIN Singleton.Secured.SLCustomerAccount CUST on CNT.CustomerID = CUST.SLCustomerAccountID
  WHERE CNT_ITEM.[Deleted] <> '1'