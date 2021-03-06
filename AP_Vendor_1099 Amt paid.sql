/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Vendor]
      ,CASE WHEN ([CalendarYear]= '2013') THEN [Ten99AmountPaid] END AS Amt_Paid_Last_Yr_1099
      ,CASE WHEN ([CalendarYear]= '2014') THEN [Ten99AmountPaid] END AS Amt_Paid_This_Yr_1099
      ,CASE WHEN ([CalendarYear]= '2015') THEN [Ten99AmountPaid] END AS Amt_Paid_Next_Yr_1099

  FROM [Singleton].[Reports].[AP1099VendorTotals]
  WHERE [CalendarYear] >= 2013	