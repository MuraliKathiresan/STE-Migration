/****** Script for SelectTopNRows command from SSMS  ******/
SELECT ROW_NUMBER() Over (Order By [Code]) as 'Job_Index'
      ,[Code] as 'Job'
      ,[Title] as 'Description'
      ,[Title] +' '+'(' + [Code] +')' as 'Job_Name'
      ,CASE WHEN ([ActualCompletionDate]is null)THEN 'In Progress'
			WHEN ([ActualCompletionDate]is not null)THEN 'Closed'
		END as 'Status'
      ,[ProjectSize] as 'Size'
      ,CONVERT (VARCHAR (10), [EstimatedStartDate],101) as 'Estimated_Start_date'
      ,CONVERT (VARCHAR (10), [EstimatedCompletionDate],101) as 'Estimated_Completion_date'
      ,CONVERT (VARCHAR (10), [RevisedStartDate],101) as 'Revised_Start_Date'
      ,CONVERT (VARCHAR (10), [RevisedCompletionDate],101) as 'Revised_Completeion_date'
      ,CONVERT (VARCHAR (10), [ActualStartDate],101) as 'Actual_Start_date'
      ,CONVERT (VARCHAR (10), [ActualCompletionDate],101) as 'Actual_Completion_date'
      ,isNull(AB.AddressLine1,'') as 'Address_1'
      ,isNull(AB.AddressLine2,'') as 'Address_2'
      ,isnull(AB.City,'') as 'City'
      ,isNull(ST.StateCode,'') as 'State'
      ,AB.PostalCode as 'ZIP_Code'
      ,isNull(PHN.OfficePhone,'') as 'Phone' 
      ,isNull(PHN.FaxNumber,'') as 'Fax'
      ,isNull(JOB.[Description],'') as 'Scope_of_Work'
      ,'1' as 'Dual_Job'
      ,'1' as 'Use_PJ_Change_Management'
  

 
  FROM [Singleton].[Reports].[JMJob] JOB
  LEFT JOIN Singleton.dbo.Address AB on JOB.AddressBookID = AB.OwnedBy_AddressBookID
  LEFT JOIN Singleton.dbo.AddressBookTelephoneView PHN on AB.AddressBookID = PHN.AddressBookID
  LEFT JOIN Singleton.Secured.SYSStateCode ST on AB.SYSStateCodeID = ST.SYSStateCodeID