# Marposs Visit

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

## Meeting summary

- meet again on 23rd
- larry can modify the program to collect traceability paramaters
- parameters
Are entered once at the beginning of the 18 measurement gage cycle.
  - scrap tag number
  - cnc station
    - required
    - scan from a lamenated sheet
    - Verify that there exists no controls similar to the HTML radio button.
  - operator id
  There can be a lookup table tying the CNC operators badge number to there initials.
    - required
    - initial or badge number
  - tool change list
    - optional
    - Use a control similar to an HTML radio button or have the operator type a comma separated list of tool numbers for tools that have just been changed.
  Tools

## Advanced Features

- conveyer selector for good/bad parts

Record Format: Excel

Larry:

1. Please verify that parameters can not be selected from a **[radio button](https://formspree.io/blog/radio-button/#:~:text=Radio%20buttons%20are%20a%20type,is%20possible%20at%20a%20time.)** or a similar control.
2. Please verify that parameters can not select multiple items from a dropdown or similar control such as the HTML **[multi select tag](https://www.w3schools.com/tags/att_select_multiple.asp)**
