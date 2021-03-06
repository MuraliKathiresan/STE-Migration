/****** Script for SelectTopNRows command from SSMS  ******/
SELECT VND.SupplierAccountNumber as 'Vendor'
      ,CASE WHEN ([SYSInsuranceTypeID] = '1') THEN [CompanyName]END AS 'GL_Ins_Company'
      ,CASE WHEN ([SYSInsuranceTypeID] = '1') THEN [PolicyNumber] END AS 'GL_Ins_Policy_Number'
      ,CASE WHEN ([SYSInsuranceTypeID] = '1') THEN CONVERT (VARCHAR (10),[EffectiveDateStart],101) END AS 'GL_Ins_Effective_Dt'
      ,CASE WHEN ([SYSInsuranceTypeID] = '1') THEN CONVERT (VARCHAR (10),[EffectiveDateEnd],101)END AS 'GL_Ins_Expiration_Dt'
      ,CASE WHEN ([SYSInsuranceTypeID] = '1') THEN [Limit]END AS 'GL_Ins_Limit'
      ,CASE WHEN ([SYSInsuranceTypeID] = '1') THEN [IsProofRequired] END AS 'Gen_Liab_Ins_Proof_Req'
      
      ,CASE WHEN ([SYSInsuranceTypeID] = '2') THEN [CompanyName]END AS 'Work_Comp_Ins_Cmpany'
      ,CASE WHEN ([SYSInsuranceTypeID] = '2') THEN [PolicyNumber] END AS 'Work_Comp_Policy_Num'
      ,CASE WHEN ([SYSInsuranceTypeID] = '2') THEN CONVERT (VARCHAR (10),[EffectiveDateStart],101) END AS 'Work_Comp_Effect_Dt'
      ,CASE WHEN ([SYSInsuranceTypeID] = '2') THEN CONVERT (VARCHAR (10),[EffectiveDateEnd],101)END AS 'Work_Comp_Expir_Dt'
      ,CASE WHEN ([SYSInsuranceTypeID] = '2') THEN [Limit]END AS 'Work_Comp_Ins_Limit'
      ,CASE WHEN ([SYSInsuranceTypeID] = '2') THEN [IsProofRequired] END AS 'Work_Comp_Ins_Proof_Req'
      
      ,CASE WHEN ([SYSInsuranceTypeID] = '3') THEN [CompanyName]END AS 'Auto_Ins_Company'
      ,CASE WHEN ([SYSInsuranceTypeID] = '3') THEN [PolicyNumber] END AS 'Auto_Ins_Policy_Num'
      ,CASE WHEN ([SYSInsuranceTypeID] = '3') THEN CONVERT (VARCHAR (10),[EffectiveDateStart],101) END AS 'Auto_Ins_Effect_Dt'
      ,CASE WHEN ([SYSInsuranceTypeID] = '3') THEN CONVERT (VARCHAR (10),[EffectiveDateEnd],101)END AS 'Auto_Ins_Expir_Dt'
      ,CASE WHEN ([SYSInsuranceTypeID] = '3') THEN [Limit]END AS 'Auto_Ins_Limit'
      ,CASE WHEN ([SYSInsuranceTypeID] = '3') THEN [IsProofRequired] END AS 'Auto_Ins_Proof_Req'  
      
      ,CASE WHEN ([SYSInsuranceTypeID] = '4') THEN [CompanyName]END AS 'Umbrella_Ins_Company'
      ,CASE WHEN ([SYSInsuranceTypeID] = '4') THEN [PolicyNumber] END AS 'Umb_Ins_Policy_Num'
      ,CASE WHEN ([SYSInsuranceTypeID] = '4') THEN CONVERT (VARCHAR (10),[EffectiveDateStart],101) END AS 'Umb_Ins_Effective_Dt'
      ,CASE WHEN ([SYSInsuranceTypeID] = '4') THEN CONVERT (VARCHAR (10),[EffectiveDateEnd],101)END AS 'Umb_Ins_Expir_Dt'
      ,CASE WHEN ([SYSInsuranceTypeID] = '4') THEN [Limit]END AS 'Umbrella_Ins_Limit'
      ,CASE WHEN ([SYSInsuranceTypeID] = '4') THEN [IsProofRequired] END AS 'Umbrella_Ins_Proof_Req' 
               
  FROM [Singleton].[Secured].[PLSupplierInsurance] INS
  JOIN Singleton.Secured.PLSupplierAccount VND on INS.PLSupplierAccountID = VND.PLSupplierAccountID
  
  
  