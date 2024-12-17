# **[using bc}(https://www.baeldung.com/linux/bc-vs-dc-calculators#bc-calculator)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../../research/research_list.md)**\
**[Back Main](../../../../../README.md)**

## Using bc

The basic calculator (**[bc}(https://www.baeldung.com/linux/bc-vs-dc-calculators#bc-calculator)**) is one of the most popular command-line calculators in Linux. It’s compliant with POSIX standards and required to build the Linux kernel.

In short, bc is a feature-rich arbitrary precision calculator that can handle complex mathematical operations.

## Basic Calculation

Let’s launch bc and perform basic arithmetic operations:

```bash
$ bc
bc 1.07.1
Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006, 2008, 2012-2017 Free Software Foundation, Inc.
This is free software with ABSOLUTELY NO WARRANTY.
For details type `warranty'.
x=7
y=3
z=5
(x+y)*z
50
```

Here, we define three variables: x, y, and z. Then, we input the expression (x+y)*z. After that, bc outputs 50 as the result from this computation.

## Shell Operation

Of course, bc also accepts arguments, so we can call it directly in the shell:

```bash
$ bc <<< "3 * 5"
15
```

In this instance, we use the Bash <<< here-string feature to pass the string “3 * 5” as input to the bc calculator. Then, bc computes the result of the multiplication operation, and 15 is shown in the output immediately below the command.

## Using Functions

We can also define our own functions for more complex calculations:

```bash
#!/bin/bash

function area() {
  echo "$1 + $1 * 3.14159" | bc
}

result=$(area 5)
echo "The area is: $result"



78.53975
```
