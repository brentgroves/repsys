# **[Command Line Flags](https://gobyexample.com/command-line-flags)**

## Creating the project

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/flags
mkdir command-line-flags
cd command-line-flags
go mod init github.com/brentgroves/command-line-flags.git 
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/flags/command-line-flags
dirs -v
pushd +X # where X is 0 based number from the bottom of dirs -v entries
go mod tidy
```

| To experiment with the command-line flags program it’s best to first compile it and then run the resulting binary directly.                            | $ go build command-line-flags.go                                                                                                                      |
|--------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| Try out the built program by first giving it values for all flags.                                                                                     | $ ./command-line-flags -word=opt -numb=7 -fork -svar=flag                      |
| Note that if you omit flags they automatically take their default values.                                                                              | $ ./command-line-flags -word=opt                                                                |
| Trailing positional arguments can be provided after any flags.                                                                                         | $ ./command-line-flags -word=opt a1 a2 a3                     |
| Note that the flag package requires all flags to appear before positional arguments (otherwise the flags will be interpreted as positional arguments). | $ ./command-line-flags -word=opt a1 a2 a3 -numb=7                   |
| Use -h or --help flags to get automatically generated help text for the command-line program.                                                          | $ ./command-line-flags -h |
| If you provide a flag that wasn’t specified to the flag package, the program will print an error message and show the help text again.                 | $ ./command-line-flags -wat                                      |
