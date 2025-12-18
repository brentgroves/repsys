# Goal Category

Financial

Goal / Objective
Financial – Investment of Choice
SMART OBJECTIVE (Specific, Measurable, Attainable, Results-Oriented, Time-Bound)
Migrate off the Mobex Azure tenant fully into the Linamar tenant to allow the Mobex Azure tenant to be shut down.

Target Completion Date
12/31/2025

Last Update
Christian Trujillo 09/26/2025

Q1 Status
GREEN - On Track, On Time
Q1 % Complete
25
Q2 Status
GREEN - On Track, On Time
Q2 % Complete
25
Q3 Status
GREEN - On Track, On Time
Q3 % Complete
50
Q4 Status
Final Goal Completion Date
09/30/2025
Final % Complete
100%

Comments:

Structures Information System resources moved from the Mobex to Linamar tenant in the "Structures-SP-repsys-CC-RG" resource group.

Azure SQL database:

SUBSCRIPTION="6fdb2836-d884-43d9-806d-78e653dbe236"
LOCATION=centralus
RESOURCE_GROUP="Structures-SP-repsys-CC-RG"
SERVER="repsys1"
DATABASE="repsys1"
LOGIN="repsys1"

Microsoft Entra authentication has been enabled.
admin: "Brent Groves"
Microsoft Entra Users:
Sam Jackson, Kevin Young

Access to this resource has been restricted using server firewall rules to a list of public IPs .

The sqlpackage utility is used to backup the Azure SQL database.

Azure AKS:
This resource has not been created.  I am waiting for Structures MicroCloud to be completed first. Then will use Charmed K8s to create identical clusters on-prem and in our Azure AKS.
