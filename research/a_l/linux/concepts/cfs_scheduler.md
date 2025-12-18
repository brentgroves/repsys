# **[CFS Scheduler](https://docs.kernel.org/scheduler/sched-design-CFS.html)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

CFS stands for “Completely Fair Scheduler,” and is the new “desktop” process scheduler implemented by Ingo Molnar and merged in Linux 2.6.23. It is the replacement for the previous vanilla scheduler’s SCHED_OTHER interactivity code.

80% of CFS’s design can be summed up in a single sentence: CFS basically models an “ideal, precise multi-tasking CPU” on real hardware.

“Ideal multi-tasking CPU” is a (non-existent :-)) CPU that has 100% physical power and which can run each task at precise equal speed, in parallel, each at 1/nr_running speed. For example: if there are 2 tasks running, then it runs each at 50% physical power --- i.e., actually in parallel.

On real hardware, we can run only a single task at once, so we have to introduce the concept of “virtual runtime.” The virtual runtime of a task specifies when its next timeslice would start execution on the ideal multi-tasking CPU described above. In practice, the virtual runtime of a task is its actual runtime normalized to the total number of running tasks.

## **[nr_running](https://lore.kernel.org/all/1376814322-7320-9-git-send-email-leiwen@marvell.com/)

```c
 struct cfs_rq {
  struct load_weight load;
+ /*
+  * The difference between nr_running and h_nr_running is:
+  * nr_running:   present how many entity would take part in the sharing
+  *               the cpu power of that cfs_rq
+  * h_nr_running: present how many tasks in current cfs runqueue
+  */
  unsigned int nr_running, h_nr_running;
 
  u64 exec_clock;
```
