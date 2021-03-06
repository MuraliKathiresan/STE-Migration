/****** Script for SelectTopNRows command from SSMS  ******/
SELECT '0' as 'Change_Request_Detail_Index'
      ,ROW_NUMBER() Over (Order By CHNG_REQ.PCChangeRequestID) as Change_Request_Index
      ,CHNG_REQ_ITEM.PCChangeRequestID as 'ORIG_Change_Req_ID'
      ,CHNG_REQ_ITEM.PCChangeRequestItemID as 'ORIG_Change_Req_Item_ID'
      ,[SequenceNumber] as 'Sequence'
      ,'0' as 'Job_Index'
      ,CNTRCT.Code as'Contract'
      ,RIGHT(CNTRCT_ITEM.Code,10) as 'Contract_Item'
      ,CNTRCT_ITEM.Code as 'ORIG_Contract_Item'
      ,JOB.PCProjectItemParentID as 'Job_ID'
      ,JOB.Code as 'Cost_Code'
      ,CHNG_REQ_ITEM.PCProjectItemID as 'WTF'
      ,CHNG_REQ.Description
      ,Convert (VARCHAR(10),CHNG_REQ.Date,101) as 'Date'
      ,[Quantity]
      ,CHNG_REQ_ITEM.[UnitCost]     
      ,isNull(UNT.Name,'') as 'Unit_of_Measure'
      --,[ProductionUnitID] -- can't find the translation table
      --,[ProductionUnitEstimateUnits]       
      ,CASE WHEN (JOB.Code = 'LAB') THEN isNull([CostEstimateAmount],'0') END AS 'Labor_Cost' -- these will need to change based on customer's cost codes or categories
      ,CASE WHEN (JOB.Code = 'LAB') THEN [ChangeToContractAmount] END AS 'Labor_Price'
      ,CASE WHEN (JOB.Code = 'MAT') THEN [CostEstimateAmount] END AS 'Material_Cost'
      ,CASE WHEN (JOB.Code = 'MAT') THEN [ChangeToContractAmount] END AS 'Material_Price'
      ,CASE WHEN (JOB.Code = 'BUR') THEN [CostEstimateAmount] END AS 'Other_Cost'
      ,CASE WHEN (JOB.Code = 'BUR') THEN [ChangeToContractAmount] END AS 'Other_Price' -- more total types - not used in Singleton
      ,[CostEstimateAmount] as 'Total_Cost'
      ,[ChangeToContractAmount]as 'Total_Price'
      ,Convert (VARCHAR(10),CHNG_REQ.ResponseDueDate,101) as 'Response_Due_Date'
      ,Convert (VARCHAR(10),CHNG_REQ.EstimateApprovedDate,101) as 'Price_Date' 
      ,[SupplierPrice] as 'Vendor_Price'
      ,CHNG_REQ.ScheduleImpactDays as 'Schedule_Impact'
      ,isNull([PLSupplierAccountID],'') as 'Vendor' 
      ,isNull([POPCREOrderID],'') as 'PO_ID'-- Not sure where this translates to STO
      ,isNull([PCSubcontractID],'') as 'Commitment'
      ,CASE WHEN (JOB.Code = 'LAB') THEN '1' END AS 'User_La_Amt'
      ,CASE WHEN (JOB.Code = 'LAB') THEN '1' END AS 'User_La_Cost_Amt'
      ,CASE WHEN (JOB.Code = 'MAT') THEN '1' END AS 'User_Ma_Amt'
      ,CASE WHEN (JOB.Code = 'MAT') THEN '1' END AS 'User_Ma_Cost_Amt'
      ,CASE WHEN (JOB.Code = 'BUR') THEN '1' END AS 'User_Ot_Amt'
      ,CASE WHEN (JOB.Code = 'BUR') THEN '1' END AS 'User_Cost_Ot_Amt'
      
FROM [Singleton].[Secured].[PCChangeRequestItem] CHNG_REQ_ITEM
  JOIN Singleton.Secured.PCChangeRequest CHNG_REQ on CHNG_REQ_ITEM.PCChangeRequestID = CHNG_REQ.PCChangeRequestID
  LEFT JOIN Singleton.Secured.PCContractItem CNTRCT_ITEM on CHNG_REQ_ITEM.PCContractItemID = CNTRCT_ITEM.PCContractItemID
  LEFT JOIN Singleton.Secured.PCContract CNTRCT on CNTRCT_ITEM.PCContractID = CNTRCT.PCContractID
  LEFT JOIN Singleton.Secured.PCProjectItem JOB on  CHNG_REQ_ITEM.PCProjectItemID = JOB.PCProjectItemID
  LEFT JOIN Singleton.Secured.Unit UNT on CHNG_REQ_ITEM.UnitID = UNT.UnitID
  ORDER BY CHNG_REQ_ITEM.PCChangeRequestID
