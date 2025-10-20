# **[Lists in Power Query M / List Functions (200+ Examples)](https://gorilla.bi/power-query/list-functions/)**

Unlock the power of data transformations with List Functions in Power Query. From basic to advanced challenges, the versatile list functions take your skills to the next level. Understand lists, apply logic, and access values with ease and start mastering the M-language today.
Whether you’re a beginner or an expert, this guide offers practical examples and tips to help you succeed. Buckle up for an in-depth journey!

## What is a List?

A list is a series of values. They are required to make use of the most powerful Power Query functions. You can visualize a list as a single column of data, whereas a table is a combination of many columns of data.

To create a list manually, you write comma-separated values and surround them with curly brackets { }. The curly brackets indicate the start and end of a list. The following list contains three values, and 8 is the second value.

```m
= { 4, 8, 12 }
```

Just like a Record and Table, a List is a so-called structured data value. The list can contain any M value, including the list itself. It is possible to have an empty list, a list with text or numbers, but you can also mix different data types together.

So far the values in the list were primitive values. Yet Power Query lists can also contain more advanced data types. It is perfectly valid to mix numbers, letters, records, table objects and list objects within a single list. Meaning that an item in a list can also be a list, creating a list with nested lists.

```m
= { { 1, 2 }, { 8, 9 } }                // Returns list containing 2 lists
 
=  { [ Name = "Bob", Age = 29 ],        // Returns list containing 2 records
     [ Name = "Ava", Age = 44 ] }
 
= #table( {"a"}, { { 1 }, { 2 } } )     // Creates table of 1 column 2 rows
 
= { #table( {"a"}, { { 1 }, { 2 } } ),  // Creates a list
    #table( {"a"}, { { 1 }, { 2 } } ) } // Containing 2 table objects
```

## Generate Lists

The Power Query M-language supports different ways to create lists. This chapter shows you how to leverage constructs and list functions to create lists from scratch.

## Consecutive Numbers

There is an easy way to generate a series of consecutive numbers. You can create a list by using curly brackets and then input a starting value and ending value while separating the values by the two dots operator (..). This generates a list between two numbers.

= { 1 .. 6 }         // Equals { 1, 2, 3, 4, 5, 6 }  
= { 1..3, 7..9 }     // Equals { 1, 2, 3, 7, 8, 9 }
= { -2 .. 3 }        // Equals { -2, -1, 0, 1, 2, 3 }
The before examples create lists of numbers but only for increasing sequences. Trying this with a decreasing sequence results in an empty list.

To generate a decreasing sequence you can use several other list functions. For example, one way to generate a list of incremental numbers is by using the List.Numbers function. This function returns a list of numbers starting from a value and by default adds increments of 1. You can adjust this increment to get a list of decimal numbers, or even negative numbers.

= List.Numbers( 1, 5 )      // Equals { 1, 2, 3, 4, 5 }
= List.Numbers( 1, 5, 1 )   // Equals { 1, 2, 3, 4, 5 }
= List.Numbers( 1, 5, -1 )  // Equals { 1, 0, -1, -2, -3 }
= List.Numbers( 1, 5, 0.1 ) // Equals { 1, 1.1, 1.2, 1.3, 1.4 }
Another way to generate a decreasing sequence is by using the List.Reverse and List.Generate functions. The List.Reverse function takes an increasing series and reverses it. Whereas the List.Generate function applies a function for an indicated amount of steps.

= { 5 .. 1 } // Equals {}, does not work

// The following statements return { 5, 4, 3, 2, 1 }
= List.Reverse( { 1 .. 5 } )
= List.Numbers( 5, 5, -1 )
= List.Generate( ( ) => 5, each _>= 1, each_ - 1 )
Power Query can generate any consecutive list as long as it fits within a 32-bit integer value. This means you can only create a continuous list that is smaller than 232 or 2^32. The result of this is 2.147.483.648.

= { 1.. 2147483647 }  // starting from 1 this is the longest list
                      // of Numbers Power Query can create

## Consecutive Letters

In a similar way, you can create a sequence of continuous letters. The only difference is that you surround each text value with quotations.

= { "a", "b", "c", "d" }    // List from a to d
= { "a" .. "d" }            // Similar list as above

= { "A", "B", "C", "D" }    // List with Capitals A to D
= { "A" .. "D" }            // Similar list as above

## Consecutive Dates

You can use several list functions to generate a list of dates. The most obvious function to use is the List.Dates function. The List.Dates function generates a list that begins with a starting date and increments with a specified value.

= List.Dates(   #date( 2021, 10, 15 ),    // Start list at this date
                5,                        // Adding 5 increments
                #duration( 1, 0, 0, 0 ) ) // Of a single day
Alternatively, you can generate a list of numbers that represent your date range. You can then turn those numbers into a continuous list of dates by transforming the data type. The following examples use the parameters StartDate and EndDate to create a list of dates between two dates:

Alternatively, you can generate a list of numbers that represent your date range. You can then turn those numbers into a continuous list of dates by transforming the data type. The following examples use the parameters StartDate and EndDate to create a list of dates between two dates:

= { Number.From( StartDate ) .. Number.From( EndDate ) }

= List.Numbers( Number.From( StartDate ),
                Duration.Days( EndDate - StartDate ) + 1 )

= List.Generate(  () => Number.From( StartDate ),
                  each _<= Number.From( EndDate ),
                  each_ + 1 )
After you enter the before code, you can change the data type to date. This results in a list of consecutive days. You can find a more elaborate explanation on the previous examples in this article on **[creating the ultimate date table](https://gorilla.bi/power-query/date-table/#create-date-series)**.

Special Characters
A special way to create a list is by using characters. Power Query allows you to create a consecutive list of special characters using a similar syntax as before. The bigger question is, how do they decide the right order?

In reality, Power Query treats all characters the same. Under the hood it uses Unicode. To make it easy for you as a user, you can simply put in the character you wish.

= { "!", """", "#", "$", "%", "&" }  // Special characters
= { "!" .. "&" }                     // Similar list
If instead, you want to reference Unicode values, you can make use of the Character.FromNumber function. This function translates the Unicode to the corresponding special character. Since most people do not know these by heart, the regular characters do make your life easier. If you want to retrieve the corresponding Unicode value of a character, you can find it by using Character.ToNumber.

= { Character.FromNumber( 33 ) .. Character.FromNumber( 38 ) }  //  Output: ! to &

= { Character.FromNumber( 48 ) .. Character.FromNumber( 57 ) }  // Output: 1 to 10

= { Character.FromNumber( 65 ) .. Character.FromNumber( 90 ) }  // Output: A to Z

= { Character.FromNumber( 97 ) .. Character.FromNumber( 122 ) } // Output: a to z

Custom Series
You can find different list functions to generate lists with custom series. For example, if you want to show numbers that increase with a step of 2, you can try use List.Alternate.

The List.Alternate function takes the original list as input, and needs a count to specify how many steps to skip. Optionally you can add an interval and offset. The interval shows the amount of values to return before skipping values and the offset tells how many values to pass before skipping values.

= List.Alternate(
      list,
      count,           // number of values to skip each time  
      repeatInterval,  // num values added between skipped values
      offset           // offset before skipping values
)

= List.Alternate( { 1..10 }, 0 )       // Equals { 1..10 } skip no value
= List.Alternate( { 1..10 }, 3 )       // Equals { 4..10 } skip 3 values

= List.Alternate( { 1..10 }, 0, 1 )    // Equals { 1..10 }
= List.Alternate( { 1..10 }, 1, 1 )    // Equals { 2, 4, 6, 8, 10 }
= List.Alternate( { 1..12 }, 2, 1 )    // Equals { 3, 6, 9, 12 }
= List.Alternate( { 1..8 },  1, 2 )    // Equals { 2, 3, 5, 6, 8 }
= List.Alternate( { 1..12 }, 3, 3 )    // Equals { 4, 5, 6, 10, 11, 12 }
                                 // Skip 3 values before step, Add 3 values each step

= List.Alternate( { 1..10 }, 0, 1, 0 ) // Equals { 1..10 }
= List.Alternate( { 1..10 }, 1, 1, 0 ) // Equals { 2, 4, 6, 8, 10 }
= List.Alternate( { 1..10 }, 1, 1, 1 ) // Equals { 1, 3, 5, 7, 9 }
                                 // Skip 1 value before step Add 1 value each step
                                 // Skip values at offset 1
A more advanced way of generating custom lists is by using the List.Generate function. You can build a series using logic. As long as the given condition is true, the series values increment.
