/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Customer]
      ,[AccountBalance] as 'Current_Amount'
      ,CONVERT (VARCHAR (10),[DateOfLastTransaction],101) as 'Last_Invoice_Date' -- Could be Last CR date though
     
  FROM [Singleton].[Reports].[Customer]