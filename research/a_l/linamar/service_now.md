# **[Service Now](https://linamar.service-now.com/sp)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## INC0417507 - ppar excel macro file error message

12/2/2024
The image shows the error with a trim function on sheet2.cells(18,10). The issue was resolved by removing the worksheet and starting from scratch using the template file. I am guessing this trim function error was not the root cause but the result of trying to fix the initial problem a date that was either entered incorrectly or somehow became corrupted.  The next time any error occurs with this worksheet delete the dates and reenter them one at a time.  If this does not work save the worksheet so the error can be debugged before any other changes are made.
