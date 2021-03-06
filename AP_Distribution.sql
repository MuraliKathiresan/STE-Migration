/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  VND.SupplierAccountNumber as 'Vendor'
,INV.[InvoiceNo] as 'Long Invoice'
,RIGHT(INV.[InvoiceNo],15) as 'Invoice'
,[INVPurchaseInvoiceLineID] AS 'ORIG_Dist_Seq'
,'' as 'Dist_Seq'
,DIST.[Description]
,[LinePreTaxAmount] + [LineTaxValue] AS 'Amount'
,TAXGrp.Name as 'Tax_Group'
,[LineTaxValue] AS 'Tax Amt'
,[LineTaxLiability] as 'Tax_Liability'
,[LineDiscountAmount] AS 'Discount_Offered'
,[LineRetainage] AS 'Retainage'
,DIST.[MiscellaneousDeduction1] AS 'Misc_Deduction'
,DIST.[MiscellaneousDeduction1Percentage] AS 'Misc_Deduction2_Percent'
,[Exempt] AS 'Excempt_1099'
,([NominalCostCentre] + '-' + [NominalDepartment] +'-' +  [NominalAccountNumber]) AS 'Expense_Account'
,isNull(JOB.Code,'') as 'Job'
,isNull(Cost_Code.Code,'') as 'Cost_Code'
--,CASE WHEN Cost_Code.PCProjectItemTypeID = '5' then Cost_Code.Code END AS 'Category'   Will need to add for other customers
-- Category 
,isNull(PO.OrderNo,'') as Commitment
,isNull(POI.SequenceNumber,'') as Commitment_Item
,DIST.BuyingPrice as 'Unit_Cost'
-- ?? as 'Units'


  FROM [Singleton].[Secured].[INVPurchaseInvoiceLine] DIST 
  JOIN [Singleton].[Secured].[INVPurchaseInvoice] INV ON DIST.[INVPurchaseInvoiceID] = INV.[INVPurchaseInvoiceID]
  JOIN [Singleton].[Secured].[PLSupplierAccount] VND on INV.[PLSupplierAccountID] = VND.[PLSupplierAccountID]
  JOIN [Singleton].[Secured].[SYSTaxGroup] TAXGrp on DIST.[SYSTaxGroupID] = TAXGrp.[SYSTaxGroupID]
  LEFT JOIN [Singleton].[Secured].[PCProjectItem] JOB  on DIST.[PCProjectItemID] = JOB.[PCProjectItemID]
  LEFT JOIN [Singleton].[Secured].[PCProjectItem] Cost_Code on DIST.[PCProjectCostItemID] = Cost_Code.[PCProjectItemID]
  LEFT JOIN Singleton.Secured.PCSubcontractItem POI on DIST.PCSubcontractItemID = POI.PCSubcontractItemID
  LEFT JOIN Singleton.Secured.PCSubcontract PO on POI.PCSubcontractID = PO.PCSubcontractID
  WHERE VND.SupplierAccountNumber = 'MAURICE' and INV.[InvoiceNo] = 'S1000001207.077CR'
  
   
