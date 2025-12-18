# **[C vs Rust](https://arstechnica.com/gadgets/2021/03/linus-torvalds-weighs-in-on-rust-language-in-the-linux-kernel/#:~:text=C%20versus%20Rust,buffer%2C%20thereby%20avoiding%20buffer%20overflows.)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Tasks](../../../a_status/current_tasks.md)**\
**[Back to Main](../../../README.md)**

C versus Rust
As of now, the Linux kernel is written in the C programming language—essentially, the same language used to write kernels for Unix and Unix-like operating systems since the 1970s. The great thing about C is that it's not assembly language—it's considerably easier to read and write, and it's generally much closer to directly portable between hardware architectures. However, C still opens you up to nearly the entire range of catastrophic errors possible in assembly.

In particular, as a nonmemory-managed language, C opens the programmer up to memory leaks and buffer overflows. When you're done with a variable you've created, you must explicitly destroy it—otherwise, old orphaned variables accumulate until the system crashes. Similarly, you must allocate memory to store data in—and if your attempt to put too much data into too-small an area of RAM, you'll end up overwriting locations you shouldn't.

High-level languages—such as PHP, Python, or Java—aim to be both easier to read and write and safer to write code in. A large part of the additional safety they offer comes from implicit memory management—the language itself will refuse to allow you to stuff 16K of data into a 2K buffer, thereby avoiding buffer overflows. Similarly, high-level languages automatically reclaim "orphaned" RAM via garbage collection—if a function creates a variable which can only be read by that function, then the function terminates, the language will reclaim the variable once it's no longer accessible.

Rust, like Google's Go, is one of a new generation of languages which aims to hit somewhere in between—it provides the raw speed, flexibility, and most of the direct mapping to hardware functionality that C would while offering a memory-safe environment.

Linux Plumbers 2020
At the Linux Plumbers conference in 2020, kernel developers began seriously discussing the idea of using Rust language inside the kernel. To be clear, the idea isn't an entire, ground-up rewrite of the kernel in Rust—merely the addition of new code, written in Rust, which interfaces cleanly with existing kernel infrastructure.

Torvalds didn't seem horrified at the idea—in fact, he requested that Rust compiler availability be enabled by default in the kernel-build environment. This didn't mean that Rust-code submissions would be accepted into the kernel willy-nilly. Enabling automatic checks for Rust-compiler presence simply meant that it should be as easy as possible to get any potential submissions built (and automatically tested) properly like any other kernel code would.

Fast forward to 2021
A significant amount of work has been done on Rust in the kernel since the 2020 Linux Plumber's Conference, including on a Rust-language port of GNU Coreutils. The port's author, Sylvestre Ledru—a Mozilla director and Debian developer—describes it as being in working condition, though not yet production ready. Eventually, the Rust port might replace the original GNU Coreutils in some environments—offering built-in thread safety and immunity to memory management errors such as buffer overflows.

Torvalds says he's in the "wait and see" camp about all this:

I'm interested in the project, but I think it's driven by people who are very excited about Rust, and I want to see how it actually then ends up working in practice.

Torvalds goes on to describe device drivers as obvious low-hanging fruit for potential new work to be done in Rust. He says that because there are tons of them, and they're relatively small and independent of other code.

Kernel maintainer Greg Kroah-Hartman agrees:

... drivers are probably the first place for an attempt like this as they are the "end leafs" of the tree of dependencies in the kernel source. They depend on core kernel functionality, but nothing depends on them.

Kroah-Hartman goes on to describe the difficulties which must be overcome for successful production integration of Rust code into a primarily C-language kernel:

It will all come down to how well the interaction between the kernel core structures and lifetime rules that are written in C can be mapped into Rust structures and lifetime rules... That's going to take a lot of careful work by the developers wanting to hook this all up, and I wish them the best of luck.
