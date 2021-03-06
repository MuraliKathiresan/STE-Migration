/****** Script for SelectTopNRows command from SSMS  ******/
SELECT CNT.[Code] as 'Contract' -- needs to be converted in Access to correct format
      ,CNT_ITEM.Code as 'Contract_Item' -- needs to be converted in Access to correct format
      ,CNT_ITEM.[Description]
      ,Job.Code as 'Job'
      ,CUST.CustomerAccountNumber as 'Customer'
      ,CASE WHEN (CNT_ITEM.[PCContractStatusID] = '0') THEN 'Proposed'
			WHEN (CNT_ITEM.[PCContractStatusID] = '1') THEN 'Approved'
			END AS 'Status'
      ,[ScheduledValue] as 'Original_Contract_Total'
      ,[NominalCostCentre] +'-'+[NominalDepartment] as 'Account_Prefix'
      ,[NominalAccountNumber] as 'Default_Revenue_Account'
   

  FROM [Singleton].[Secured].[PCContractItem] CNT_ITEM
  JOIN Singleton.Secured.PCContract CNT on CNT_ITEM.PCContractID = CNT.PCContractID
  LEFT JOIN Singleton.Secured.PCProjectItem JOB on CNT_ITEM.PCProjectItemID = JOB.PCProjectItemID
  LEFT JOIN Singleton.Secured.SLCustomerAccount CUST on CNT.CustomerID = CUST.SLCustomerAccountID
  WHERE CNT_ITEM.[Deleted] <> '1'