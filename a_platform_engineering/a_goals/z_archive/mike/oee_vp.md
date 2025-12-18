# OEE VP

- Make a SPROC that calculates OEE the same way Plex does.
- Show Mike the calculation
- If Mike had Plex SQL writes he could look at the SPROC.

## Text from OEE VP Wiki

```text
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
```
