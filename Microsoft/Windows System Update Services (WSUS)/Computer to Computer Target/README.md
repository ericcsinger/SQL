#SQL_microsoft_windows system update service_Computers to Compouter Target
This creates a report that shows the mapping of computers and thier respective target groups.  There is only one main value that may be of interest in tweaking, which is...

Where [SUSDB].[dbo].[tbExpandedTargetInTargetGroup].[IsExplicitMember] = 1 

The "1" implies that you want to see computers that a direct member of a group.  For example if you have a group structure such as "All Computers\Prod\SQL" this value will return the computers as belonging to "\SQL" not "\Prod" or "All Computers"


