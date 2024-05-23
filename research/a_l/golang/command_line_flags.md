# **[Command Line Flags](https://gobyexample.com/command-line-flags)**

## Go by Example: Command-Line Flags

Command-line flags are a common way to specify options for command-line programs. For example, in wc -l the -l is a command-line flag.

Go provides a flag package supporting basic command-line flag parsing. We’ll use this package to implement our example command-line program.

Basic flag declarations are available for string, integer, and boolean options. Here we declare a string flag word with a default value "foo" and a short description. This flag.String function returns a string pointer (not a string value); we’ll see how to use this pointer below.

**[Flag Tutorial](../../../volumes/go/tutorials/flags/command-line-flags/flags.md)**
