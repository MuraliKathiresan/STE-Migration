/****** Script for SelectTopNRows command from SSMS  ******/
SELECT CUST.CustomerAccountNumber as 'Customer'
      ,CONVERT (VARCHAR (10),TRN.[DocumentDate],101) as 'Transaction_Date'
      ,'1' as 'Run'
      ,ROW_NUMBER() Over (Order By CUST.CustomerAccountNumber) as 'Sequence'
      ,'Invoice' as 'Transaction_Type'
      ,'Total billed' as 'Amount_Type'
      ,TRN.[InvoiceNumber] as 'Invoice'
      ,INV.DrawNumber as 'Draw'
      ,CONVERT (VARCHAR (10),TRN.[DueDate],101) as 'Due_Date'
      ,CNT.Code as 'Contract'
      ,CNT_ITEM.Code as 'Contract_Item'
      ,JOB.Code as 'Job' -- will need to be modified for other than job-level billing
      ,TaxGroup.Name as 'Tax_Group'
      ,TaxStatus.Name as 'Exempt_Status'
      ,TRN.[Description]
      ,[TRN].NominalCostCentre + '-' + [TRN].NominalDepartment +'-' + [CreditNominalAccountNumber] as 'Credit_Account__Accrual'
      ,[DebitNominalCostCentre] + '-' + [DebitNominalDepartment] + '-' + [DebitNominalAccountNumber] as 'Debit_Account__Accrual'
      ,[RetainageNominalCostCentre]+ '-' +[RetainageNominalDepartment]+ '-' +[RetainageNominalAccountNumber] as 'Retainage_Account'
      ,CONVERT (VARCHAR (10),ACCTG.EndDate,101) as 'Accounting_Date'
      ,[LineTotalValue] as 'Amount'
      ,TRN.[RetainageHeld]*-1 as 'Retainage'
      ,TRN.RetainageBilled as 'Retainage_Billed'
      ,TRN.RetainageReleased as 'Retainage_Released'
      ,TRN.LineTaxValue as 'Tax'
      ,'AR' as 'Application_of_Origin'
      ,'001' as 'Batch'
      ,'Invoice' as 'Status_Type'
      ,CONVERT (VARCHAR (10),TRN.[DocumentDate],101) as 'Status_Date'
      ,'1' as 'Status_Seq'
      ,'1' as 'Actvty_Seq'
      ,'0' as 'Dist_Seq'
      ,trn.ARInvoiceLineID as 'ORIG_Dist_Seq'

  
  FROM [Singleton].[dbo].[CREARPostedInvoiceLineView] TRN
  JOIN Singleton.Secured.SLCustomerAccount CUST on TRN.SLCustomerAccountID = CUST.SLCustomerAccountID
  JOIN Singleton.Secured.PCContractItem CNT_ITEM on TRN.PCContractItemID = CNT_ITEM.PCContractItemID
  JOIN Singleton.Secured.PCProjectItem JOB on TRN.PCProjectItemID = JOB.PCProjectItemID
  JOIN Singleton.Secured.CREARContractInvoice INV on TRN.ARInvoiceID = INV.CREARContractInvoiceID
  JOIN Singleton.Secured.SYSTaxGroup TaxGroup on TRN.SYSTaxGroupID = TaxGroup.SYSTaxGroupID
  JOIN Singleton.Secured.PCContract CNT on INV.PCContractID = CNT.PCContractID
  JOIN Singleton.Secured.SYSTaxStatus TaxStatus on TRN.SYSTaxStatusID = TaxStatus.SYSTaxStatusID
  JOIN Singleton.Secured.SYSAccountingPeriod ACCTG on TRN.NominalAccountingPeriodID = ACCTG.SYSAccountingPeriodID
   
 