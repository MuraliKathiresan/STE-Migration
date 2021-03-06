/****** Script for SelectTopNRows command from SSMS  ******/
SELECT LEFT ([Project],5) as 'Job' --
      ,LEFT ([CostCodeTitle],3) as 'Cost_Code'
      --[Category]
      ,CASE WHEN ([PCBudgetChangeTypeID] = '1') THEN 'Original estimate' 
			WHEN ([PCBudgetChangeTypeID] = '0') THEN 'Original estimate'
			WHEN ([PCBudgetChangeTypeID] = '2') THEN 'Original estimate'  
			WHEN ([PCBudgetChangeTypeID] = '3') THEN 'Approved est changes'
			WHEN ([PCBudgetChangeTypeID] = '4') THEN 'Approved est changes'
			WHEN ([PCBudgetChangeTypeID] = '5') THEN 'Approved est changes'
			WHEN ([PCBudgetChangeTypeID] = '6') THEN 'Pending est changes'
			END AS 'Transaction_Type'
	  ,'2' as 'Run'
	  ,ROW_NUMBER() Over (Order By Project) as Sequence		
      ,CONVERT (VARCHAR,[DateOfChange],101) as'Transaction_Date'
      --,CONVERT (VARCHAR,[DateOfChange],101) as'Accounting_Date'
      ,[Description]
      ,[Quantity]
      ,[UnitCost]
      ,[CostValueChange] as 'Amount'
      ,'JC' as Application_of_Origin
      ,'002' as 'Batch'
   
      
      FROM Singleton.[Secured].[PCProjectItemBudgetHistory]
   
      