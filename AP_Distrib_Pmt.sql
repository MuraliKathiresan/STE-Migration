/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
VND.SupplierAccountNumber AS 'Vendor' 
,INV.InvoiceNo AS 'Long Invoice'
,RIGHT(INV.[InvoiceNo],15) as 'Invoice'
,BANK.AccountCode AS 'Bank_Account'
,RIGHT(CHK.CheckNumber,9) AS 'Check' 
,DIST_PMT.[INVPurchaseInvoiceLineID]AS 'ORIG_Dist_Seq'
,'' as 'Dist_Seq'
,'Check' as 'Payment_Type'
,DIST_PMT.[PaymentAmount]+ DIST_PMT.[DiscountAmount] AS 'Amount_Paid'
,DIST_PMT.[DiscountAmount] as 'Discount_Taken'
-- Discount Lost
,DISTPMT_DET.RetainageAllocationAmount as 'Retainage_Paid'
-- Retianage Held
,DISTPMT_DET.TaxAllocationAmount as 'Tax_Paid'
-- Misc_Deduction Applied
-- Misc Deduction 2 Deducted
-- Cash_Account, Discount_Account, Misc_Deduction2_Account, ICR, ICP
   
      
  FROM [Singleton].[Secured].[PLSupplierPaymentDetail] DIST_PMT
  JOIN Singleton.Secured.INVPurchaseInvoiceLine DIST on DIST_PMT.INVPurchaseInvoiceLineID = DIST.INVPurchaseInvoiceLineID
  JOIN Singleton.Secured.INVPurchaseInvoice INV on DIST.INVPurchaseInvoiceID = INV.INVPurchaseInvoiceID
  JOIN Singleton.Secured.PLSupplierAccount VND on INV.PLSupplierAccountID = VND.PLSupplierAccountID
  JOIN Singleton.Secured.PLSupplierCheck CHK on DIST_PMT.PLSupplierPaymentID = CHK.PLSupplierPaymentID
  JOIN Singleton.Secured.CBAccount BANK on CHK.CBAccountID = BANK.CBAccountID
  JOIN Singleton.Secured.PLPaymentAllocation DISTPMT_DET on DIST_PMT.PLPaymentAllocationID =  DISTPMT_DET.PLPaymentAllocationID
  WHERE DIST_PMT.[PaymentAmount] + DIST_PMT.[DiscountAmount] <>0
  Order by VND.SupplierAccountNumber , INV.InvoiceNo
  
  
  
  
  