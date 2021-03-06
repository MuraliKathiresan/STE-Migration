/****** Script for SelectTopNRows command from SSMS  ******/
SELECT Bank.AccountCode as 'Bank_Account' 
      ,CONVERT (VARCHAR (10),Dep.DepositDate,101) as 'Deposit_date'
      ,RIGHT(DEP.DepositID,10) as 'Deposit_ID'
      ,'' as 'Deposit_Item'
      ,'1'as 'Dep_Item_Type_Number'
      ,'Check' as 'Dep_Item_Type'
      ,'' as 'Customer'
      ,[ItemID] as 'Cash_Receipt_ID'
      ,CONVERT (VARCHAR (10),[ReceiptDate],101) as 'Reference'
      ,[Amount]
      ,Dep.CREARDepositID as 'Deposit_Seq_ID'
      ,DEP.DepositID as 'ORIG_Dep_ID'
      ,DepItem.CREARDepositItemID  as 'ORIG_Dep_Item'
     
  FROM [Singleton].[Secured].[CREARDepositItem] DepItem
  JOIN [Singleton].[Secured].CREARDeposit Dep on DepItem.CREARDepositID = Dep.CREARDepositID
  JOIN [Singleton].[Secured].CBAccount Bank on Dep.CBAccountID = Bank.CBAccountID
  WHERE [CREARDepositItemStatusID]='3'
  ORDER BY Bank.AccountCode,Dep.DepositDate
  