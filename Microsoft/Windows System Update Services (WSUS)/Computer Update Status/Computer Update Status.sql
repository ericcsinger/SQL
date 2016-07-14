--Author: Eric C. Singer
--Version 0.0
--Web Site: http://ericcsinger.com

use [SUSDB]
SELECT [SUSDB].[PUBLIC_VIEWS].[vUpdateInstallationInfo].[UpdateId]
      ,[SUSDB].[PUBLIC_VIEWS].[vUpdateInstallationInfo].[ComputerTargetId]
	  ,[SUSDB].[PUBLIC_VIEWS].[vComputerTarget].[Name] as ComputerName
	  ,[SUSDB].[PUBLIC_VIEWS].[vComputerTarget].[OSMajorVersion]
	  ,[SUSDB].[PUBLIC_VIEWS].[vComputerTarget].[OSMinorVersion]
	  ,[SUSDB].[PUBLIC_VIEWS].[vComputerTarget].[LastSyncTime]
	  ,[SUSDB].[PUBLIC_VIEWS].[vComputerTarget].[LastSyncResult]
      ,[SUSDB].[PUBLIC_VIEWS].[vUpdateInstallationInfo].[State]
	  ,sv.Name as FriendlyState
	  ,[SUSDB].[PUBLIC_VIEWS].[vUpdateEffectiveApprovalPerComputer].[UpdateApprovalId]
	  ,[SUSDB].[PUBLIC_VIEWS].[vUpdateApproval].[Action]
	  ,[SUSDB].[PUBLIC_VIEWS].[vUpdate].[DefaultDescription]
	  ,[SUSDB].[PUBLIC_VIEWS].[vUpdate].[DefaultTitle]
	  ,[SUSDB].[PUBLIC_VIEWS].[vUpdate].[KnowledgebaseArticle]
	  ,[SUSDB].[PUBLIC_VIEWS].[vUpdate].[RevisionNumber]
	  ,[SUSDB].[PUBLIC_VIEWS].[vUpdate].[UpdateType]
	  ,[SUSDB].[PUBLIC_VIEWS].[vClassification].[DefaultTitle] as ClassifacationTitle
	  ,[SUSDB].[PUBLIC_VIEWS].[vUpdate].[IsDeclined]
	  ,[SUSDB].[dbo].[tbTargetGroup].[Name] as TargetGroupName
  FROM [SUSDB].[PUBLIC_VIEWS].[vUpdateInstallationInfo]

INNER JOIN [SUSDB].[PUBLIC_VIEWS].[vComputerTarget] ON 
	(
	[SUSDB].[PUBLIC_VIEWS].[vUpdateInstallationInfo].[ComputerTargetId] = [SUSDB].[PUBLIC_VIEWS].[vComputerTarget].[ComputerTargetId]
	)

Full Outer JOIN [SUSDB].[PUBLIC_VIEWS].[vUpdateEffectiveApprovalPerComputer] ON
	(
	[SUSDB].[PUBLIC_VIEWS].[vUpdateEffectiveApprovalPerComputer].[ComputerTargetId] = [SUSDB].[PUBLIC_VIEWS].[vUpdateInstallationInfo].[ComputerTargetId] 
	and	
	[SUSDB].[PUBLIC_VIEWS].[vUpdateEffectiveApprovalPerComputer].[UpdateId] = [SUSDB].[PUBLIC_VIEWS].[vUpdateInstallationInfo].[UpdateId]

	)

Full Outer JOIN [SUSDB].[PUBLIC_VIEWS].[vUpdateApproval] ON 
	(
	[SUSDB].[PUBLIC_VIEWS].[vUpdateApproval].[UpdateApprovalId] = [SUSDB].[PUBLIC_VIEWS].[vUpdateEffectiveApprovalPerComputer].UpdateApprovalId 
	)

Full Outer JOIN [SUSDB].[PUBLIC_VIEWS].[vUpdate] ON 
	(
	[SUSDB].[PUBLIC_VIEWS].[vUpdate].[UpdateId] = [SUSDB].[PUBLIC_VIEWS].[vUpdateInstallationInfo].[UpdateId]
	)

Full Outer JOIN [SUSDB].[dbo].[tbTargetGroup] ON [SUSDB].[PUBLIC_VIEWS].[vUpdateApproval].[ComputerTargetGroupId]=[SUSDB].[dbo].[tbTargetGroup].[TargetGroupID]

Inner Join PUBLIC_VIEWS.fnUpdateInstallationStateMap() as sv on [SUSDB].[PUBLIC_VIEWS].[vUpdateInstallationInfo].[State] = sv.Id

Inner Join [SUSDB].[PUBLIC_VIEWS].[vClassification] on [SUSDB].[PUBLIC_VIEWS].[vUpdate].[ClassificationId] = [SUSDB].[PUBLIC_VIEWS].[vClassification].[ClassificationId]

Where Action = 'Install' and [SUSDB].[PUBLIC_VIEWS].[vComputerTarget].[Name] like 'computername%' and state != 1 