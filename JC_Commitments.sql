/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [OrderNo] as 'Commitment'
	  ,[PCSubcontractID] as 'ORIG_ID'
	  ,'Purchase order' as 'Commitment_Type'
      --,[OrderNoTypeID] as 'Commitment_Type' I can't find the OrderNoType table to get the translation...
      ,COMMT.[Description]
      ,VENDOR.SupplierAccountNumber as 'Vendor'
      ,CONVERT (VARCHAR (10),[OrderDate],101) as 'Date'
      ,isNull(JOB.Code,'') as 'Job'
      ,COMMT.OriginalGrossValue as 'Amount'
      ,COMMT.OriginalTaxValue as 'Tax'
      ,COMMT.TotalNetValue - COMMT.OriginalGrossValue as 'Approved_Commitment_CO_Amount'
      ,[TotalTaxValue] - COMMT.OriginalTaxValue as 'Approved_Commitment_CO_Tax_Amount'
      ,'1' as 'Release_to_Accounting'
      ,'1' as 'Committed_to_JC'     
      ,[InvoicedAmountWithTax] as 'Amount_Invoiced'
      ,COMMT.ActualCompletionDate
       
      

  FROM [Singleton].[Secured].[PCSubcontract] COMMT
  JOIN Singleton.Secured.PLSupplierAccount VENDOR on COMMT.PLSupplierAccountID = VENDOR.PLSupplierAccountID
  LEFT JOIN Singleton.Secured.PCProjectItem JOB on Commt.PCProjectItemID = JOB.PCProjectItemID

 
 