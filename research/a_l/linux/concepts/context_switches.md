# **[Context Switch](https://medium.com/@cstoppgmr/understanding-cpu-context-switching-in-linux-systems-59392606d191)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Understanding CPU Context Switching in Linux System

Linux is a multitasking operating system that supports far more tasks running simultaneously than the number of CPUs available. However, these tasks are not actually running at the same time; rather, the system switches the CPU between them very quickly, creating the illusion of multitasking.

Before each task runs, the CPU needs to know where the task is loaded from and where it should start running. This means that the system must set up the CPU registers and the Program Counter (PC) for it in advance.

CPU registers are small, fast memory units built into the CPU. The Program Counter is used to store the current instruction being executed by the CPU or the address of the next instruction to be executed. These are essential dependencies for the CPU to run any task and are therefore referred to as the CPU context.

![](https://miro.medium.com/v2/resize:fit:640/format:webp/1*mKyd8lk6GT1qfxdnzWjrXw.png)

Understanding what CPU context is, it’s easy to understand CPU context switching. CPU context switching involves saving the CPU context (CPU registers and Program Counter) of the previous task, loading the context of the new task into these registers and the Program Counter, and then jumping to the new location indicated by the…
