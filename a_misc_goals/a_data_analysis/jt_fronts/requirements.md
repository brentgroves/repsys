# gage data analysis

## key

The last step of the Plex checksheet displays a 4 or 2-digit number for the operator to write on the part. This 4-digit number can be used to pull all of the information Mach2 has recorded in its database:

- CNC
- Station
- Operator
- Tool counts derived from tool changes
- Scrap tag number
- 9 dimension values

Since there is only 4 or 2-digits the report won't uniquely identify the part but it will give all the parts with that digit in date/time order. Another alternative is to make it a 6-digit number to uniquely identify the part but then it's more work for the operator.

## ToDo

- document gage process flow chart
- create the record format in excel
- review Ron's excel file
- review advanced feature request

## Reports

- Shift Bad Part
- Part Dimension Index, $TotalDimensions/TotalParts$

## Checksheet

Can we display the parameters and dimensions collected on checksheet?

## Parameter Controls

1. Please verify that parameters can not be selected from a **[radio button](https://formspree.io/blog/radio-button/#:~:text=Radio%20buttons%20are%20a%20type,is%20possible%20at%20a%20time.)** or a similar control.
2. Please verify that parameters can not select multiple items from a dropdown or similar control such as the HTML **[multi select tag](https://www.w3schools.com/tags/att_select_multiple.asp)**
