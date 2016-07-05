--Auther: Eric C. Singer
--Website: http://ericcsinger.com
--version: 0.0

SELECT 
      [ComputerID]
      ,[SID]
      ,[LastSyncTime]
      ,[LastReportedStatusTime]
      ,[LastReportedRebootTime]
      ,[IPAddress]
      ,[FullDomainName]
      ,[IsRegistered]
      ,[LastInventoryTime]
      ,[LastNameChangeTime]
      ,[EffectiveLastDetectionTime]
      ,[ParentServerTargetID]
      ,[LastSyncResult]
	  ,[SUSDB].[dbo].[tbExpandedTargetInTargetGroup].TargetGroupID
	  ,[SUSDB].[PUBLIC_VIEWS].[vComputerTargetGroup].[Name]
	  
  FROM [SUSDB].[dbo].[tbComputerTarget]

  INNER JOIN [SUSDB].[dbo].[tbExpandedTargetInTargetGroup] ON 
	(
	[SUSDB].[dbo].[tbComputerTarget].[TargetID] = [SUSDB].[dbo].[tbExpandedTargetInTargetGroup].[TargetID]
	)

	INNER JOIN [SUSDB].[PUBLIC_VIEWS].[vComputerTargetGroup] ON 
	(
	[SUSDB].[PUBLIC_VIEWS].[vComputerTargetGroup].[ComputerTargetGroupId] = [SUSDB].[dbo].[tbExpandedTargetInTargetGroup].[TargetGroupID]
	)


Where [SUSDB].[dbo].[tbExpandedTargetInTargetGroup].[IsExplicitMember] = 1 