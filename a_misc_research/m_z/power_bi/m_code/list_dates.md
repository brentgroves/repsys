# **[](https://powerquery.how/list-dates/)**

List.Dates
Updated on
April 26, 2024
Rick de Groot
List.Dates is a Power Query M function that generates a list of date values with a specified size, starting point, and step increment. The function returns a list of date values incremented by the given duration value.

List.Dates(
   start as date,
   count as number,
   step as duration,
) as list

## Description

The List.Dates function generates a list of dates. To do that it requires a start date and a count value that specifies the number values to generate. The step argument is a duration value that specifies the size of each step in the list of dates. For instance, if you specify a duration of 5 days, each step will increment by 5 days. In most situations, you will use a step of a single day.

Examples
Let’s understand the functionality of the List.Dates function with some practical examples.

Generating Four Consecutive Days
The first example generates a sequence of 4 consecutive dates. When specifying the arguments of List.Dates, you will commonly find the #date function used to specify a date value, and the #duration function for specifying a duration of each step.

Here’s how:

List.Dates( #date( 2024, 1, 1 ), 4, #duration( 1, 0, 0, 0 ) )

 /*Output:
{   #date( 2024, 1, 1 ), #date( 2024, 1, 2 ),
    #date( 2024, 1, 3 ), #date( 2024, 1, 4 )  }
 */
In this example,

Start Date: The first argument, #date(2024, 1, 1), sets the start date as January 1, 2024.
Count: The second argument, 4, indicates that the function should generate a total of 4 dates.
Step: The third argument, #duration(1, 0, 0, 0), specifies the increment for each step in the sequence. Here, the duration is set to one day.
The output demonstrates that each date in the sequence increases by one day, beginning from January 1, 2024, and continuing daily until January 4, 2024.

You can see the three arguments of the function. A start date (as date), the number of intervals to add (as number) and the size of each interval (as duration).

Tip
If the #duration() syntax is new to you, it is good to know it takes 4 arguments as input: days, hours, minutes and seconds. The above formula, therefore, increments with 1-day intervals. Changing the duration from 1 day to 2 days, creates a list that increments with 2 days per step.

Next, you can try to make this formula more dynamic. Instead of hardcoding a start date, adjust the original formula and include the parameter called StartDate:

List.Dates(
     StartDate,               // Uses start date parameter
     5,
     #duration( 1, 0, 0, 0 )
  )
