/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [PCSubcontractID] as 'ORIG_Commitment_ID'
      ,'' as 'Commitment'
      ,[PCCommitmentChangeOrderID] as 'ORIG_Commit_CO_ID'
      ,Commit_CO.[Code] as 'Commitment_CO'
      ,Commit_CO.Description
      ,'1' as 'Printed'
      ,CONVERT (VARCHAR (10),Commit_CO.Date,101)as 'Date'
      ,isNull([Scope],'') as 'Scope'
      ,'1' as 'Release_to_Accounting'
      ,CASE WHEN([PCChangeStatusID]='2')THEN'Approved' 
			WHEN([PCChangeStatusID]='1')THEN'Pending'
			WHEN([PCChangeStatusID]='0')THEN'Not issued'
			WHEN([PCChangeStatusID]='3')THEN'Denied'
			WHEN([PCChangeStatusID]='4')THEN'Void'END as 'Status'
			
      ,'0' as 'Tax' -- from Commit CO Item ?
      ,'0' as 'Amount' 	-- from Commit CO Item ?		
      ,JOB.Code as 'Job'
      			
     
  FROM [Singleton].[Secured].[PCCommitmentChangeOrder] Commit_CO
  JOIN Singleton.Secured.PCProjectItem JOB on Commit_CO.PCProjectItemID = JOB.PCProjectItemID
