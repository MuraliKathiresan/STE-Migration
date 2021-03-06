/****** Script for SelectTopNRows command from SSMS  ******/
SELECT VND.SupplierAccountNumber as 'Vendor'
      ,[InvoiceNo] as 'Long Invoice'
      ,RIGHT ([InvoiceNo],15) as 'Invoice' 
      ,isNull([Description],'') as 'Description' -- Quotes and commas in Desc Causing Probs
      ,[InvoicedChargesValue] + [InvoicedTaxValue] as 'Amount' 
      ,INV.SettlementDiscValue as 'Discount'
      ,[InvoicedTaxValue] as 'Tax'
      ,'0' as 'Retainage' --Retainage Summed from Distribs
      ,[MiscellaneousDeduction1] as 'Misc_Deduction'
      ,CONVERT (VARCHAR (10),Acctg.EndDate,101) as 'Accounting_Date'
      ,CONVERT (VARCHAR (10),[DocumentDate],101) as 'Invoice_Date' 
      ,CONVERT (VARCHAR (10),[DueDate],101) as 'Payment_Date' 
      ,'AP' as Appl_of_Origin 
      ,'001' as Batch
      ,'1' as Run
      ,ROW_NUMBER() Over (Order By VND.SupplierAccountNumber, InvoiceNo) as Sequence
           
      
  FROM [Singleton].[Secured].[INVPurchaseInvoice]INV
  JOIN [Singleton].[Secured].PLSupplierAccount VND on vnd.PLSupplierAccountID = inv.PLSupplierAccountID
  JOIN [Singleton].[Secured].SYSAccountingPeriod ACCTG on INV.PostingPeriodDbKey = ACCTG.SYSAccountingPeriodID
  WHERE INV.DocumentStatusID <> 5
  Order by VND.SupplierAccountNumber, INV.InvoiceNo
  