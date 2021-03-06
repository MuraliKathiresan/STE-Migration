/****** Script for SelectTopNRows command from SSMS  ******/
SELECT ROW_NUMBER() Over (Order By CHNG_REQ.PCChangeRequestID) as 'Change_Request_Index'
	  ,CHNG_REQ.PCChangeRequestID as 'ORIG_ID'
      ,'Change request' as 'Type'
      ,'0' as 'Job_Index'
      ,CNT.Code as 'Contract'
      --CNT_ITEM.Code as 'Contract_Item'
      --CHNG_REQ_ITEM.PCContractItemID
      ,JOB.Code as 'Job'
      ,isNull([PCChangeOrderID],'') as 'Change_Order_Index'
      ,CHNG_REQ.[Code] as 'Number' 
      ,'0' as 'Sequence'
      ,CHNG_REQ.[Description]
      ,CONVERT (VARCHAR (10),[Date],101) as 'Date'
      ,isNull([Scope],'') as 'Scope'
      ,CASE WHEN ([PCChangeStatusID]='0') THEN 'Not issued' 
			WHEN ([PCChangeStatusID]='1') THEN 'Potential'
			WHEN ([PCChangeStatusID]='2') THEN 'Approved'
            WHEN ([PCChangeStatusID]='3') THEN 'Denied'
            WHEN ([PCChangeStatusID]='4') THEN 'Voided'
            END AS 'Status'

      ,CASE WHEN ([PCChangeEstimateStatusID]=0) THEN 'Not issued'
			WHEN ([PCChangeEstimateStatusID]=1) THEN 'Pending'
			WHEN ([PCChangeEstimateStatusID]=2) THEN 'Approved'
			END AS 'Actual_Revenue_Status'
	  ,'0' as 'Total_Estimate'	-- Sum from Change Request Detail
	  ,'0' as 'Total_Price'	-- Sum from Change Request Detail
	  ,'0' as 'Approved_Price'	-- Sum from Change Request Detail
      ,CONVERT (VARCHAR (10),[ResponseDueDate],101) as 'Response_Due_Date'
      ,CONVERT (VARCHAR (10),[NoticeToProceedDate],101) as 'Proceed_or_Approval_Date'
      ,CONVERT (VARCHAR (10),[EstimateApprovedDate],101) as 'Estimate_Send_Date'     

  FROM [Singleton].[Secured].[PCChangeRequest] CHNG_REQ
  LEFT JOIN Singleton.Secured.PCChangeRequestItem CHNG_REQ_ITEM on CHNG_REQ.PCChangeOrderID = CHNG_REQ_ITEM.PCChangeRequestID
  LEFT JOIN Singleton.Secured.PCProjectItem JOB on CHNG_REQ.PCProjectItemID = JOB.PCProjectItemID
  LEFT JOIN Singleton.Secured.PCContract CNT on CHNG_REQ.PCContractID = CNT.PCContractID
  LEFT JOIN Singleton.Secured.PCContractItem CNT_ITEM on CHNG_REQ_ITEM.PCContractItemID = CNT_ITEM.PCContractItemID
  ORDER BY CHNG_REQ.PCChangeRequestID 
  
 