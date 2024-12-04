# INC0417507 "ppar excel macro file error message" 

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

## Suggest

Find a **[VBA Excel](https://www.datacamp.com/tutorial/vba-excel)** programmer to work on this for the immediate future.  For the long-term solution, I suggest we migrate this VBA Excel program to a Web App, SQL database, and Power BI. The downside to this suggestion is that it would take some time. The upside is that the Web App can perform validation on the dates and other information before being saved to the database. Using VBA it is easy to create complex programs to solve business needs quickly, but it is difficult to make these programs robust. 

## Summary

Talked to Elden and Vladimir. It works now but they don't want it resolved so I didn't. The reason is that Vlad knows how to resolve this issue but he would like to make the VBA Excel program more robust so it doesn't happen again.  The long explanation: The image shows the error with a trim function on sheet2.cells(18,10). The issue was resolved by removing the worksheet and starting from scratch using the template file. I am guessing this trim function error was not the root cause but the result of trying to fix the initial problem a date that was either entered incorrectly or somehow became corrupted.  The next time any error occurs with this worksheet delete the dates and reenter them one at a time.  If this does not work save the worksheet so the error can be debugged before any other changes are made.

## Important **[VBA Excel](https://www.datacamp.com/tutorial/vba-excel)** Terms

Before working with VBA, you must understand its key terms and concepts. So, here’s a list of some of the most used terms you'll encounter as you start automating tasks and building custom solutions in Excel.

- **Modules** are the containers for VBA code, where procedures and functions are stored.

- **Objects** are the building blocks of VBA. They represent elements like workbooks, worksheets, and cells.

- **Procedures** are the blocks of code that perform specific tasks, often categorized as sub-procedures or functions.

- **Statements** are the instructions within a procedure that tell Excel (or Word or Access) what actions to perform.

- **Variables* store data that can be used and manipulated within your code.

- **Logical operators** compare values and make decisions based on the results. They include operators like And, Or, and Not.
