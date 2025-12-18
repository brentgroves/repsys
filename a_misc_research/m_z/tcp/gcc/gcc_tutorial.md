# **[GCC tutorial](https://www.geeksforgeeks.org/gcc-command-in-linux-with-examples/#)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Tasks](../../../a_status/current_tasks.md)**\
**[Back to Main](../../../README.md)**

## gcc command in Linux with examples

GCC stands for GNU Compiler Collections which is used to compile mainly C and C++ language. It can also be used to compile Objective C and Objective C++. The most important option required while compiling a source code file is the name of the source program, rest every argument is optional like a warning, debugging, linking libraries, object file etc. The different options of gcc command allow the user to stop the compilation process at different stages.

## **[Comparison](https://pierre.chachatelier.fr/programmation/fichiers/cpp-objc-en.pdf)**

Objective C was developed in early 1980s by Brad Cox and Tom Love. It is an object-oriented, general purpose language and was created with the vision of providing small talk-style messaging to the C programming language. This language allows the users to define a protocol by declaring the classes and the data members can be made public, private and protected. This language was used at Apple for iOS and OS X operating systems. Swift language was developed at Apple in 2014 to replace this language. But still there are plenty of companies that are maintaining their legacy apps which are written in objective C.

## Compiler in Linux Kernel

The Linux kernel is primarily compiled using the GCC (GNU Compiler Collection) compiler, specifically the GNU C compiler, often referred to as "gcc" or "cc". However, Clang/LLVM toolchains are also supported. The kernel is written in C and typically compiled with GCC under -std=gnu89, which is the GNU dialect of ISO C90. While GCC is the traditional and preferred compiler, **[Clang/LLVM](https://clang.llvm.org/)** is also a viable option, with some distributions like Android and ChromeOS using it.

Syntax:  

`gcc [-c|-S|-E] [-std=standard]`

Example: This will compile the source.c file and give the output file as a.out file which is default name of output file given by gcc compiler, which can be executed using ./a.out

`gcc source.c`

![ao](https://media.geeksforgeeks.org/wp-content/uploads/20190227213651/source_direct.png)

Most Useful Options with Examples: Here source.c is the C program code file.

-o opt: This will compile the source.c file but instead of giving default name hence executed using ./opt, it will give output file as opt. -o is for output file option.

`gcc source.c -o opt`

![i2](https://media.geeksforgeeks.org/wp-content/uploads/20190227213945/source_with_output.png)

-Werror: This will compile the source and show the warning if any error is there in the program, -W is for giving warnings.
gcc source.c -Werror -o opt

-Wall: This will check not only for errors but also for all kinds warning like unused variables errors, it is good practice to use this flag while compiling the code.
`gcc source.c -Wall -o opt`

![i3](https://media.geeksforgeeks.org/wp-content/uploads/20190227215503/source_warning_all2.png)

-ggdb3: This command give us permissions to debug the program using gdb which will be described later, -g option is for debugging.
gcc -ggdb3 source.c -Wall -o opt

-lm : This command link math.h library to our source file, -l option is used for linking particular library, for math.h we use -lm.
gcc -Wall source.c -o opt -lm

![i4](https://media.geeksforgeeks.org/wp-content/uploads/20190227215807/source_linking_library.png)

-std=c11 :This command will use the c11 version of standards for compiling the source.c program, which allows to define variable under loop initializations also using newer standards version is preferred.
gcc -Wall -std=c11 source.c -o opt

![i5](https://media.geeksforgeeks.org/wp-content/uploads/20190227215941/source_with_standards.png)

-c : This command compile the program and give the object file as output, which is used to make libraries.

-v : This option is used for the verbose purpose.

![i6](https://media.geeksforgeeks.org/wp-content/uploads/20190227220059/source_verbose.png)
