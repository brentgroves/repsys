# subshells

```bash
# !/bin/bash

LOGFILE=/some/path/mylogfile

(

# here go my commands which produce some stdout

# and, if something goes wrong, also some stderr

) 1>>${LOGFILE} 2> >( tee -a ${LOGFILE} >&2 )
```

In Bash, expressions enclosed in parentheses serve multiple purposes, impacting how commands are grouped, executed, and evaluated. The behavior depends on the type and context of the parentheses used.

## Subshells: (command)

Enclosing commands in single parentheses creates a subshell. This means the commands inside the parentheses are executed in a separate, independent environment. Changes made within the subshell, such as variable assignments or directory changes, do not affect the current shell.

```bash
(cd /tmp; touch example.txt)
ls /tmp # example.txt may or may not be present, depending on timing
```

## Command Substitution: $(command)

The $(command) syntax performs command substitution. The command inside the parentheses is executed, and its output is substituted into the current command line.
Code

```bash
date_output=$(date +%Y-%m-%d)
echo "Today is $date_output"
```

## Arithmetic Expansion: $((expression))

Double parentheses preceded by a dollar sign are used for arithmetic expansion. This allows for evaluating arithmetic expressions within the shell.
Code

```bash
result=$((5 + 3 * 2))
echo $result # Output: 11
```

## Grouping Commands: (command1; command2)

Parentheses can group multiple commands, allowing redirection to apply to the entire group.
Code

```bash
(ls -l; pwd) > output.txt
```

## Function Definitions: function_name () (commands)

While less common, parentheses can be used instead of curly braces to define a function body. However, this creates a subshell for the function's execution, which might not always be desired.
Code

```bash
my_function () ( echo "This is a function"; )
my_function
```

## Arrays: array=(element1 element2 element3)

Parentheses are used to define arrays in Bash.
Code

```bash
my_array=(apple banana cherry)
echo ${my_array[1]} # Output: banana
```

## Regular Expressions: [[ string =~ regex ]]

Double square brackets with the =~ operator are used for regular expression matching. Parentheses within the regex can capture groups.
Code

```bash
if [[ "filename.txt" =~ ^(.*)\.txt$ ]]; then
  echo "Filename: ${BASH_REMATCH[1]}" # Output: filename
fi
```

## Order of Operations

Parentheses can clarify or change the order of operations in arithmetic expressions or compound commands.
Code

`result=$(((5 + 3) * 2)) # Result: 16`
