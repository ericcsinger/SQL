#SQL_microsoft_windows system update service_Computers Update Status
This query can be used in multiple ways to show the update status of a computer or computers.  

All of the magic in this query is in the where statement.  That will determine which updates you're concerned about, which computers, which computer target groups, etc.

To begin with, even with lots of specifics in the where statement, this is a heavy query.  I would suggest starting with your PC or a specific PC, before using this to run a full report.  It can easily take in excess of 30 minutes to an hour to run this report if you do NOT use any filters, and you have a resonably large WSUS environment.  I've also run into out of memory / temp db issues, so you may need to do this in batches in a large enviornment.

Let's go over a few way's to filter data.  First, the computer name column would be best served by using a wildcard at the end of the computer name.  Unless you're going to use the FQDN of the computer name.

Right now, I'm only showing updates that are approved to be installed.  That is accomplished by the Where Action = 'Install' statement.  

The "state" column is one that can quicly let you get down to the the update status you care about.  In the case of the one below, we're showing the update status for a computer called "computername", but not showing non-applicable updates.  
Where Action = 'Install' and [SUSDB].[PUBLIC_VIEWS].[vComputerTarget].[Name] like 'computername%' and state != 1 

if we only wanted to see which updates were not installed, all we'd need to do is the following.  By adding "state !=4" we're saying only show updates that are applicable, and not currently installed.
Where Action = 'Install' and [SUSDB].[PUBLIC_VIEWS].[vComputerTarget].[Name] like 'computername%' and state != 1 and state != 4





