/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Vendor]
      ,[VendorName] as 'Name'
      ,isNull([AddressLine1],'') as 'Address_1'
      ,isNull([AddressLine2],'') as 'Address_2'
      ,isNull([City],'') as 'City'
      ,isNull([StateCode],'') as 'State'
      ,isNull([PostalCode],'') as 'ZIP_Code'
      ,isNull([AddressPhoneNumber],'')as 'Telephone'
      ,isNull([ContactName],'') as 'Contact_1_Name'
      ,isNull([ContactEmailAddress],'')'Contact_1_Email_Address'
      ,isNull([EmailAddress],'')'Contact_2_Email_Address'
      ,isNull([ContactPhoneNumber],'')  'Contact_1_Telephone'    
      ,[VendorType] as 'Type'
      ,[CustomerAccount] as 'Customer_Number'
      ,[EarlySettlementDiscountPercent] as 'Discount_Percent'
      ,[DaysEarlySettlementDiscApplies] as 'Discount_Days'
      ,[DiscountDayOfTheMonth]
      ,[PLPaymentDiscountTypeID]
      ,[PaymentDiscountType]
      ,[PaymentTermsInDays] as 'Payment_Days'
      ,[PaymentTermsBasisID] -- "Day of next month" or "Number of days" in STO
      ,[MiscellaneousDeductionPercent] as 'Misc_Deduction_Rate'
      ,[DefaultCostCenter]+'-'+ [DefaultDepartment]+'-'+[DefaultGLAccount] as 'Expense_Account'
      ,isNull(TAX.Name,'') as 'Vendor_Tax_Group'
      ,CASE WHEN (VND.TaxTypeToPrefillTypeID = 1) THEN 'Actual tax'
			WHEN (VND.TaxTypeToPrefillTypeID = 2) THEN 'Tax liability'
	   END AS 'Prefilled_Tax_Amount'	
      --,[PCCostingSettingID] Defaul Cost Code and Category maybe??
      ,[Receives1099] as 'Receives_Form_1099'
      ,[Ten99RecipientIDNumber] as 'Recipient_ID'
      ,[Ten99RecipientName] as 'Recipient_Tax_ID_Name'
      ,CASE WHEN ([Ten99FormTypeID] = '0') THEN 'Non-employee comp' 
			WHEN ([Ten99FormTypeID] = '1') THEN 'Rent'
			WHEN ([Ten99FormTypeID] = '2') THEN 'Interest'
			WHEN ([Ten99FormTypeID] = '3') THEN 'Dividends'
			--WHEN ([Ten99FormTypeID] = '4') THEN 1099-R Retirement no STO equivalent
       END AS 'Form_Type_1099'
     -- ,[AccountTypeID] User defined?
     -- 1099 Amnts
      ,[AccountBalance] as 'Outstndg_Amount'
      ,'1' as 'Last_Auto_Number_Used'
      ,CONVERT (VARCHAR(10),[DateOfLastTransaction],101) as ' Last_Inv_Date' -- could be last check date though...
      ,[AccountIsOnHold] as 'Onhold_Status'
      -- Insurance is a spearate query


  FROM [Singleton].[Reports].[Vendor] VND
  LEFT JOIN Singleton.Secured.SYSTaxGroup TAX on VND.TaxGroupID = TAX.SYSTaxGroupID
 