https://wiki.freepascal.org/Installing_the_Free_Pascal_Compiler#Testing_the_FPC_Install

Testing the FPC Install
You might like to try a simple and quick test of FPC at this stage. From the command line (Mac - Open an Application > Utilities > Terminal) start an editor (e.g. pico or nano), paste this very short program and save it as the file helloworld.pas (using the WriteOut command in GNU nano):

```pascal
program helloworld;
begin
	writeln('hello world !');
end.
```

Now exit the editor and compile this simple code by typing this command, before pressing ↵ Enter:

```bash
pushd .
cd ~/src/repsys/volumes/pascal
fpc helloworld.pas
Free Pascal Compiler version 3.2.0 [2020/06/14] for x86_64
Copyright (c) 1993-2020 by Florian Klaempfl and others
Target OS: Linux for x86-64
Compiling helloworld.pas
Linking helloworld
3 lines compiled, 0.1 sec

It should very quickly make an executable called, you guessed it, "helloworld". Run this executable by typing this command and then pressing ↵ Enter:



./helloworld
If that worked, well done!
```