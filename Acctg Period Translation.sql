/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [SYSAccountingPeriodID]
      ,[SYSFinancialYearID]
      ,[PeriodNumber]
      ,CONVERT (VARCHAR (10),[StartDate],101) as 'Start_Date'
      ,CONVERT (VARCHAR (10),[EndDate],101) as 'End_Date'
  FROM [Singleton].[Secured].[SYSAccountingPeriod]