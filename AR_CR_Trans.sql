/****** Script for SelectTopNRows command from SSMS  ******/
SELECT CUST.CustomerAccountNumber as'Customer' 
      ,CONVERT (VARCHAR (10),DepItem.[DocumentDate],101) as 'Transaction_Date'
      ,'2' as 'Run'
      ,ROW_NUMBER() Over (Order By CUST.CustomerAccountNumber) as 'Sequence'
      ,'Cash receipt' as 'Transaction_Type'
      ,'Total billed' as 'Amount_Type'
      ,INV.InvoiceNumber as 'Invoice'
      ,INV.[DrawNumber] as 'Draw'
      -- Reference_Date
      ,CONVERT (VARCHAR (10),DepItem.[DueDate],101) as 'Due_Date'  
      ,'1' as 'Dep_Item_Type_Number'
      ,'Check' as 'Dep_Item_Type'
      ,'Invoice cash receipt' as 'Cash_Receipt_Type'
      ,BANK.AccountCode as 'Bank_Account'
      ,CONVERT (VARCHAR (10),Deposit.[DepositDate],101) as 'Deposit_Date'
      ,Deposit.CREARDepositID as 'ORIG_Deposit_ID'
      ,[ARDepositItemID] as 'ORIG_Deposit_Item' 
      ,'' as 'Deposit_ID'
      ,'' as 'Deposit_Item'
      --[ARDepositItemDetailID]
      ,CNTRCT.Code as 'Contract'
      -- Contract_Item NEED FROM INVOICE LINE 
      ,[JMContractItemID]as 'Contract Item ID'
      ,isnull(Job.Code,'') as 'Job'
      ,[TaxGroupID]
      ,[TaxStatusID]      
      ,[DebitCompany] + '-' +[DebitDepartment] + '-' + [DebitAccount] as 'Debit_Account__Accrual'
      ,[CreditCompany]+ '-' + [CreditDepartment] + '-' + [CreditAccount] as 'Credit_Account__Accrual'
      --[DiscountAccount]
      ,CONVERT (VARCHAR (10),Deposit.[DepositDate],101) as 'Accounting_Date'
      ,DepItem.[LineTotalValue] as 'Amount'
      --[LineTaxValue]
      --[Discount]
      --[DiscountTax]
      ,[DepositItemDetailType] as 'Status_Type'
      ,CONVERT (VARCHAR (10),INV.[DocumentDate],101) as 'Status_Date'
      ,'1' as 'Status_Seq'
      ,'2' as 'Actvty_Seq'
      ,[ARInvoiceLineID] as 'Invoice Line Reference'
      ,'' as 'Dist_Seq'
      ,'AR' as 'Application_of_Origin'
      ,'002' as 'Batch'
      
  FROM [Singleton].[Reports].[ARPostedDepositDetails] DepItem
  JOIN Singleton.Secured.CREARContractInvoice INV on DepItem.ARInvoiceID = INV.CREARContractInvoiceID
  JOIN Singleton.Secured.SLCustomerAccount CUST on DepItem.CustomerID = CUST.SLCustomerAccountID
  JOIN Singleton.Secured.PCProjectItem JOB on DepItem.JMProjectItemID = JOB.PCProjectItemID
  JOIN Singleton.Secured.CREARDepositItemDetail DepItemDet on DepItem.ARDepositItemDetailID = DepItemDet.CREARDepositItemDetailID
  JOIN Singleton.Secured.CREARDepositItem DepositItem on DepItemDet.CREARDepositItemID = DepositItem.CREARDepositItemID
  JOIN Singleton.Secured.CREARDeposit Deposit on DepositItem.CREARDepositID = Deposit.CREARDepositID
  JOIN Singleton.Secured.CBAccount BANK on Deposit.CBAccountID = BANK.CBAccountID
  JOIN Singleton.Secured.PCContract CNTRCT on INV.PCContractID = CNTRCT.PCContractID
   
   
  
  