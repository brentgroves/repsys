# **[date table](https://gorilla.bi/power-query/date-table/)**

Purpose of a Date Table
So why use a date table in Power BI? Data models often require a way to analyze data over time. This is where a date table comes in. A date table is a specialized table that contains a continuous and comprehensive range of dates, which can be used to perform time-based analysis.

Each row in the table includes information about the date, such as the day, month, year, quarter, and even fiscal periods. The table can also include other relevant information, such as holidays or business days.

The primary purpose of a date table is to provide a way to group and filter data based on dates. With a date table, you can create time-based calculations and analysis, such as year-to-date (YTD) calculations, comparison of data between two different periods, and running totals. Without a date table, it can be challenging to perform such analyses.

## Add Parameters

Let’s talk about how to create parameters for your date table. This will help you make your calendar table more flexible and dynamic. To get started, open Power Query and go to Manage Parameters.

Once you’re there, you’ll want to create a parameter for both the start and end dates of your calendar table. Click on the “New” button and then add the following information:

- For the start date, enter the name “StartDate“, choose the type “Date“, and set the current value to “01-01-2021“.
- For the end date, enter the name “EndDate“, choose the type “Date“, and set the current value to “31-12-2022“.

![i1](https://gorilla.bi/wp-content/uploads/2021/10/0.5-Manage-Parameters.png)

Now, you have two parameters that you can reference in the following chapters. These parameters allow you to easily change the start and end dates of your calendar table without having to modify your queries every time.

With just a few clicks, you can update your calendar table to include data for any date range you choose. Pretty cool, right?

![i1](https://gorilla.bi/wp-content/uploads/2021/10/0.-Two-parameters-for-calendar.png)

## Create a List of Dates

When building your Power BI calendar table, the first thing you need is a list of dates to use as the foundation. DAX time intelligence functions require a consecutive list of dates, so it’s important to avoid any gaps in your date dimension. But how can you generate this list of dates?

To start, create a blank query by right-clicking in the queries pane and selecting New Query -> Blank Query. This will give you a clean slate to work with.

From here, the next step is to create a list of consecutive dates using M, which will serve as the basis for your date column. If you’re new to working with lists, you can check out the **[complete guide to lists in Power Query](https://gorilla.bi/power-query/list-functions/)** for more information.

There are several ways to create a list of dates, as outlined below.

## List.Dates

The easiest way to create a date table in Power Query is:

use the List.Dates function and enter a start date.
indicate the number of steps in your calendar.
specify a single day as duration

An example is the following expression that creates a list with 5 consecutive dates. To see this in action, add the below code in the formula bar of your blank query:

List.Dates(                      // Creates a list of dates
     #date( 2021, 10, 15 ),        // Starting from Oct 15th 2021
     5,                            // Creating 5 steps
     #duration( 1, 0, 0, 0 )       // Of 1 Day
 )

You can see the three arguments of the function. A start date (as date), the number of intervals to add (as number) and the size of each interval (as duration).

Tip
If the **[#duration()](https://powerquery.how/sharpduration/)** syntax is new to you, it is good to know it takes 4 arguments as input: days, hours, minutes and seconds. The above formula, therefore, increments with 1-day intervals. Changing the duration from 1 day to 2 days, creates a list that increments with 2 days per step.

Next, you can try to make this formula more dynamic. Instead of hardcoding a start date, adjust the original formula and include the parameter called StartDate:

List.Dates(
     StartDate,               // Uses start date parameter
     5,
     #duration( 1, 0, 0, 0 )
  )

To also make the total amount of intervals dynamic, you can retrieve the number of days between the end date and the start date.

Function argument 2 requires a number as input, and one way to the difference in days is by using the Duration.Days function. Just make sure to add +1 at the end, or your date table will miss a day.

= List.Dates(
     StartDate,
     Duration.Days( EndDate - StartDate ) + 1, // Number of steps
     #duration( 1, 0, 0, 0 )
  )

The code now generates a date series formatted as a list. The last step is to convert this list to a table for the start of your calendar table. You can do that by selecting To Table in the Transform tab. This generates the code:

Table.FromList(
     Source,
     Splitter.SplitByNothing(),
     null,
     null,
     ExtraValues.Error
  )

To save yourself the step of renaming the new column (Column1) and defining the data type later, you can make an adjustment to the previous formula. You can do this by defining the table syntax in the argument. Lastly, arguments 4 and 5 are optional, you can remove them

Table.FromList(
     Source,
     Splitter.SplitByNothing(),
     type table[ Date = Date.Type ], // Adds Column Name and Data Type
  )

Autofill Dates in List
Another way to create a consecutive series of dates is to use the auto-fill functionality for lists in Power Query. To see how this works, inspect the following examples that generate a list:

{ 1..10 }      // Creates list: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
{ "a" .. "k" } // Create list: a, b, c, d, e, f, g, h, i, j, k

You can use this functionality to create a list that starts at the StartDate and reaches up to the EndDate.

Yet because this functionality does not work with dates, you can first transform the dates to their corresponding numbers using the function Number.From. The following is a completely valid syntax:

You can use this functionality to create a list that starts at the StartDate and reaches up to the EndDate.

Yet because this functionality does not work with dates, you can first transform the dates to their corresponding numbers using the function Number.From. The following is a completely valid syntax:

{ Number.From( StartDate ) .. Number.From( EndDate ) }

The number 44197 here relates to the date January 1st 2021. Once you have this list, you can transform it into a table, as shown in method 1.

You are now left with a column with numbers. The last thing to do is to change the column Type to Date. And with that, your calendar table gets a list of consecutive dates.

## List.Numbers

The third method creates a list of dates in a similar way as method 2. Yet, instead of using the autofill functionality, you use the List.Numbers function.

List.Numbers(
     Number.From( StartDate ),
     Duration.Days( EndDate - StartDate   ) + 1
  )
The first argument shows the starting number corresponding to the StartDate. The second argument provides the number of increments to add to the list in steps of 1.

Turn that list into a table and transform the column type to date.

The first argument shows the starting number corresponding to the StartDate. The second argument provides the number of increments to add to the list in steps of 1.

Turn that list into a table and transform the column type to date.

## List.Generate

The List.Generate function is effective for creating lists, which is a great starting point for a calendar table.

An effective way to create a Calendar table is:

1. Create a blank query.
2. Type = List.Generate( () => StartDate, each _<= EndDate, each Date.AddDays(_, 1 ) )
3. Convert the list of dates into a table.
4. Rename the column to “Date” and the data type to ‘Date‘.
Voila, now you have your very own Date Table.

## example

```powerbi
let
    StartDate = #date(2020, 1, 1), // Define your start date here
    EndDate = #date(2023, 12, 31), // Define your end date here
    DateList = List.Dates(StartDate, Duration.Days(EndDate - StartDate) + 1, #duration(1, 0, 0, 0)),
    ConvertToDateTable = Table.FromList(DateList, Splitter.SplitByNothing(), {"Date"}, null, ExtraValues.Error),
    ChangeType = Table.TransformColumnTypes(ConvertToDateTable, {"Date", type date}),
    AddYear = Table.AddColumn(ChangeType, "Year", each Date.Year([Date]), Int64.Type),
    AddQuarter = Table.AddColumn(AddYear, "Quarter", each "Q" & Text.From(Date.QuarterOfYear([Date])), type text),
    AddMonthNumber = Table.AddColumn(AddQuarter, "Month Number", each Date.Month([Date]), Int64.Type),
    AddMonthName = Table.AddColumn(AddMonthNumber, "Month Name", each Date.MonthName([Date]), type text),
    AddMonthShortName = Table.AddColumn(AddMonthName, "Month Short Name", each Date.ToText([Date], "MMM"), type text),
    AddWeekOfYear = Table.AddColumn(AddMonthShortName, "Week Of Year", each Date.WeekOfYear([Date]), Int64.Type),
    AddDayOfMonth = Table.AddColumn(AddWeekOfYear, "Day Of Month", each Date.Day([Date]), Int64.Type),
    AddDayOfWeekName = Table.AddColumn(AddDayOfMonth, "Day Of Week Name", each Date.DayOfWeekName([Date]), type text),
    AddDayOfWeekNumber = Table.AddColumn(AddDayOfWeekName, "Day Of Week Number", each Date.DayOfWeek([Date], Day.Monday) + 1, Int64.Type) // +1 to make Monday=1, Sunday=7
in
    AddDayOfWeekNumber
```
