/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [PCChangeOrderID] as 'ORIG_CO_ID'
      ,'' as 'Change_Order_Index'
      ,'' as 'Job_Index'
      ,JOB.Code as 'Job'
      ,CO.[Code] as 'Number'
      ,CO.[Description]
      ,CONVERT (VARCHAR (10),[Date],101) as 'Date'
      ,CNT.Code as 'Contract'
      ,CASE WHEN ([PCChangeStatusID]='0') THEN 'Not issued'
			WHEN ([PCChangeStatusID]='1') THEN 'Potential'
			WHEN ([PCChangeStatusID]='2') THEN 'Approved'
			WHEN ([PCChangeStatusID]='3') THEN 'Denied'
			WHEN ([PCChangeStatusID]='4') THEN 'Void' 
			END AS 'Status'
      ,CONVERT (VARCHAR (10),CO.[ApprovedDate],101) as 'Approved_Date'


  FROM [Singleton].[Secured].[PCChangeOrder]CO
  JOIN Singleton.Secured.PCProjectItem JOB on CO.PCProjectItemID = JOB.PCProjectItemID
  LEFT JOIN Singleton.Secured.PCContract CNT on CO.PCContractID = CNT.PCContractID
 