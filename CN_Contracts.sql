/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Code] as 'Contract' -- Needs to be converted in Access to correct format
      ,[Description]
      ,Convert (VARCHAR(10),[ContractDate],101) as 'Contract_Date'
      ,CASE WHEN ([PCContractStatusID] = '0') THEN 'Proposed'
			WHEN ([PCContractStatusID] = '1') THEN 'Approved'
			END AS 'Status'
      ,'1' as 'Use_PJ_Change_Management'
      --,[PCContractOverbillOptionID]
      --,[CustomerID]
      --,[DefaultInvoiceFormat]
      --,[DistributeToOwner]
      --,[DistributeToArchitect]
      --,[DistributeToContractor]
      --,[DistributeToField]
      --,[DistributeToOther]
      --,[Notes]
      --,[CREARRateTableID]
      --,CNT.[Deleted]
      --,[CustomerSYSTaxStatusID]
      --,[AIAAddressBookID]

  FROM [Singleton].[Secured].[PCContract] CNT
  