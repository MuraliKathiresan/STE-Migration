
SELECT 
       BANK.AccountCode AS 'Bank_Account'
      ,[CheckNumber] AS 'Check'
      ,CONVERT  (VARCHAR (10),[CheckDate],101) as 'Check_Date' 
      ,[CheckAmount]as 'Amount'
      ,VND.SupplierAccountNumber as 'Vendor'
      ,'AP' as Appl_of_Origin 
      ,'001' as Batch
      ,'1' as Run
      ,ROW_NUMBER() Over (Order By CheckNumber) as Sequence
            
  FROM [Singleton].[Secured].[PLSupplierCheck] CHK
  JOIN Singleton.Secured.CBAccount BANK on  CHK.CBAccountID = BANK.CBAccountID
  JOIN Singleton.Secured.PLSupplierPayment PMT on CHK.PLSupplierPaymentID = PMT.PLSupplierPaymentID
  JOIN Singleton.Secured.PLSupplierAccount VND on PMT.PLSupplierAccountID = VND.PLSupplierAccountID
  
  WHERE CHK.IsVoided = 0
  