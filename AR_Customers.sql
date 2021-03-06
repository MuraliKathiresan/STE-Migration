/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Customer]
      ,[CustomerName] as 'Name'
      ,isNull([AddressLine1],'') as 'Address_1'
      ,isNull([AddressLine2],'') as 'Address_2'
      ,isNull([AddressLine3],'') as 'Address_3'
      ,isNull([City],'') as 'City'
      ,isNull([StateCode],'') as 'State'
      ,isNull([PostalCode],'') as 'ZIP_Code'
      ,isNull([CompanyPhoneNumber],'') as 'Telephone'
      ,isNull([EmailAddress],'') as 'E-mail_Address'
      ,CONVERT (VARCHAR (10),[AccountOpened],101) as 'Date_Established' 
      , CASE WHEN ([AccountIsOnHold]='1') THEN 'On hold' 
			 WHEN ([AccountIsOnHold]='0') THEN 'Active'
			 END AS 'Status'
      ,[DefaultNominalCostCentre] + '-' + [DefaultNominalDepartment] as 'GL_Prefix'
      ,[PaymentTermsInDays] as 'Days_Before_Due'
      ,[CreditLimit] as 'Credit_Limit'
      ,isNull([ContactName],'') as 'Contact_1'     
      
      
  FROM [Singleton].[Reports].[Customer] CUST

  