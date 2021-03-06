/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Code] as 'Job'
      ,[Title] as 'Description'
      ,isNull(AB.AddressLine1,'') as 'Address_1'
      ,isNull(AB.AddressLine2,'') as 'Address_2'
      ,AB.City
      ,ST.StateCode as 'State'
      ,AB.PostalCode as 'ZIP_Code'
      ,[ProjectSize] as 'Size'
      ,isNull([ProjectSizeUnitOfMeasure],'') as 'Unit_Description'
      ,isNull(PHN.OfficePhone,'') as 'Site_Phone' 
      ,isNull(PHN.FaxNumber,'') as 'Fax_Phone'
      ,'' as 'Status'
      ,isNull([Default_ContactID], '')as 'Contract'
      ,'1' as 'Use_PJ_Change_Management'
      ,CONVERT (VARCHAR (10), [EstimatedStartDate],101) as 'Estimated_Start_date'
      ,CONVERT (VARCHAR (10), [EstimatedCompletionDate],101) as 'Estimated_Completion_date'
      ,CONVERT (VARCHAR (10), [RevisedStartDate],101) as 'Revised_Start_Date'
      ,CONVERT (VARCHAR (10), [RevisedCompletionDate],101) as 'Revised_Completeion_date'
      ,CONVERT (VARCHAR (10), [ActualStartDate],101) as 'Actual_Start_date'
      ,CONVERT (VARCHAR (10), [ActualCompletionDate],101) as 'Actual_Completion_date'
      ,'2' as 'Billing_Method' -- Need to change for customer setup
      ,'1' as 'Billing_Level'
      ,isNull(BANK.AccountCode,'') as 'Bank_Account'
      ,[DefaultRevenueAccountNumber] as 'Revenue_Account'
      ,[RetainagePercent] as 'Retainage_Percent'
      ,isNull(JOB.[Description],'') as 'Scope'
      ,[Company] +'-'+[Department] as 'Cost_Account_Prefix'
      ,[DefaultExpenseAccountNumber] as 'Cost_Account'
      ,[ProduceLienWaiver] as 'Produce_Lien_Waiver'
      ,[LienWaiverMinimum] as 'Lien_Waiver_Minimum'
      ,[PercentageComplete] as 'Percent_complete'

 
  FROM [Singleton].[Reports].[JMJob] JOB
  LEFT JOIN Singleton.dbo.Address AB on JOB.AddressBookID = AB.OwnedBy_AddressBookID
  LEFT JOIN Singleton.dbo.AddressBookTelephoneView PHN on AB.AddressBookID = PHN.AddressBookID
  LEFT JOIN Singleton.Secured.CBAccount BANK on JOB.CBAccountID = BANK.CBAccountID
  LEFT JOIN Singleton.Secured.SYSStateCode ST on AB.SYSStateCodeID = ST.SYSStateCodeID