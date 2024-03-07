# Review Plex Views

select resource search from application setup screen.

## references

<https://tabletomarkdown.com/convert-spreadsheet-to-markdown/>

- inventory container list: detailed container search screen
- container trace by BOM
- container count by location
- container transaction report - shipped, recieved, adjusted
- container changes
part.dbo.Container_Change2_Report_Get
part_v_container_change2

| Location     | Serial No | Change Date    | Changed By      | Part No    | Revision | Operation              | Quantity | Last Action    |
| ------------ | --------- | -------------- | --------------- | ---------- | -------- | ---------------------- | -------- | -------------- |
| A LINE STAGE | FD4341432 | 3/6/24 8:33 AM | Taylor, Marquis | 1039 T-Bar |          | Receive Aluminum (lbs) | 1,503    | Container Move |
| A LINE STAGE | FD4341433 | 3/6/24 8:33 AM | Taylor, Marquis | 1039 T-Bar |          | Receive Aluminum (lbs) | 1,499    | Container Move |
| A LINE STAGE | FD4341434 | 3/6/24 8:32 AM | Taylor, Marquis | 1039 T-Bar |          | Receive Aluminum (lbs) | 1,500    | Container Move |

## questions

It looks like all the "Last Action" values of the "Container changes" report for Fruitport says "Container Move"

Is container_change2 location field reliably updated?


