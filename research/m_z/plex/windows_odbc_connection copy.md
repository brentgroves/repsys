# Plex OEE VP

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

## Wiki

OEE uses the report server instead of the production server.  This means that the report will not include any data from the current day, but will have data as of previous day.

OEE stands for Overall Equipment Effectiveness, which is an industry-standardized measurement methodology for tracking a manufacturing plant.

The Plex OEE Report lists the production Workcenters down the left-hand side, then shows the production summary broken down by part for the specified date range, then shows the results of the OEE calculations, and then a cross-tab of Downtime reasons. (Note that the Downtime Reasons are grouped by the Workcenter_Event.Group field).

Vision Plex Version of OEE Report Notes:

The VisionPlex version of the OEE Report uses some different datasources and may not be exactly the same as the classic version.

The Performance Date is calculated:
((1/Production Rate)*(Good Qty+Rejected Qty+Scrap Qty))/(Plan Hrs - Downtime Hrs)

Daily Shift Report is a good alternative to the OEE Report and it can be  utilized immediately.

OEE Calculation
OEE
OEE is calculated as the product of its three contributing factors:
        OEE = Availability x Performance x Quality

Availability
Availability takes into account Down Time Loss, and is calculated as:
       Availability = Operating Time / Planned Production Time

Planned Production Time
Planned Production time is by definition calculated as:
        Planned Production Time = Shift Length - Breaks

In Plex, Planned Production Time can be calculated from either the
       - Workcenter Calendar (Shift Cycle + Shift Overrides)
       - Workcenter Log hours of a Workcenter Status with the flag "Planned Production Time" checked.

Which calculation is used is determined by setting "Workcenter Calendar Hours".

Operating Time
        Operating Time = Planned Production Time - Down Time

Downtime Hours are recorded in the Workcenter Log. They are hours associated with a Workcenter Status that has the checkbox "Downtime Status" checked.  Any Status with the Downtime Status flag checked MUST also have the "Planned Production Time" flag checked or the results will not be accurate.

Downtime Hours can also be recorded using the "Crew Sheet".

Performance
Performance takes into account Speed Loss, and is calculated as:
       Performance = Ideal Cycle Time / (Operating Time / Pieces Produced)

Ideal Cycle Time is the reciprocal of the Ideal Rate (1 / Ideal Rate). This is the maximum production rate that your process can be expected to achieve in optimal circumstances. In Plex, Ideal Rate field is located on the Approved Workcenter in the Process Routing of the Part.

Since Run Rate is the reciprocal of Cycle Time, Performance can also be calculated as:
       Performance = (Total Pieces / Operating Time) / Ideal Rate

Performance is capped at 100%, to ensure that if an error is made in specifying the Ideal Cycle Time the effect on OEE will be limited.

When multiple parts are ran on a workcenter over a time period, the calculation in Plex becomes more complex, like this:
       Performance = ([1 / Ideal Rate Part 1 x Pieces Produced Part 1] + [1 / Ideal Rate Part 2 x Pieces Produced Part 2]) / Total Operating Time

Quality
Quality takes into account Quality Loss, and is calculated as:
       Quality = Good Pieces / Total Pieces

In Plex terminology, we are calculating this as:
       Quality = Good Production Quantity / (Good Production Quantity + Rejected Production Quantity + Scrap Quantity)

Source Reject Quantity (aka Throwouts, Reheats, etc) does not effect the OEE calculation and is provided for reference purposes only.

Other Notes
Totaling/Averaging
The Availability, Performance, Quality and OEE are calculated for each workcenter.
Total Line at the bottom of the report is based on calculating the Availability, Performance, Quality, and OEE on the sum/total of all the numbers as if it were one large workcenter. It is NOT based on averaging the Workcenter subtotals in the column above.

Reject/Qty Column
Any production record marked as rejected. Usually production placed on a hold status would populate this column.
Downtime columns
The columns shown on the OEE downtime are the Event groups , groups can be used to organize reasons other than the statuses:

Event Groups currently have the following Reasons/Events.

1 - Change-over (Tools): Change-over /Set-up,Consumable Tool/Blade Change,Weld nozzle change,Weld tip change BUT DOES NOT INCLUDE FIRST OFF INSPECTION

2- Equipment Issues : Equipment Failure ,Equipment runnability,Feeder Issue,Transfer issue

3 -Tool/Die Issues:

Setup Notes
Configuration
Turn on setting "Ideal Rate Display" to see this field in the Process Routing. Enter values.
 Review your downtime "Workcenter statuses" to determine which need Operating Time and Planned Production Time turned on.
Make sure that each "downtime" workcenter status has at least one "event" linked to it. These events are listed as downtime reasons on the OEE report.
In order to see an event it has to be linked to a Workcenter Status, and the "Production" Workcenter Status must have the Job Cost flag set to on in order for activities to display on OEE and to pull the data from the Workcenter Log records.
Determine where your "planned production time" will come from. (see Workcenter Calendar)
If the Workcenter Event is linked to a Workcenter Event Group on the Workcenter Event table, the Group will appear on the OEE report rather than the Event description.

Date Filter
OEE uses the previous business day as defined by the shipping days calender. If the calendar is not up to date, it uses the last "shipping day" it finds. The Executive Summary Report also relies on this information for accuracy.
<http://en.wikipedia.org/wiki/Oee>

Error
If downtime statuses are renamed on the production server, they won't be matching between the servers until the report server refreshes. If a change is made on the test database, same rules will apply. Change needs to be made in the Report database in order to see the change immediatly.

Filter Restrictions
If the user does not enter a Workcenter or Workcenter Type, you can only retrieve at max a week's worth of data. If they do use either of those filters you can retrieve at max a month's worth of data at a time.

Scrap
Criteria for scrap to show on OEE:
Record has to have a scrap reason, or it won't show up
Has to be linked to a workcenter & part that was running at that time
Scrap reason must have the scrap checkbox checked
Check to see what 'scrap' button or screen user used when recording scrap, some of them don't hit OEE (for example if they scrap from the 'load' screen in cntrl panel it will scrap from the source & not be included on OEE)
*Plex Online is not affiliated with Wikipedia and does not guarantee that any information in Wikipedia is accurate. This link is provided for informational purposes only.
