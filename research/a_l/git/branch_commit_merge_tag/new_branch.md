# **[New Branch](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging)**

## Basic Branching and Merging

Let’s go through a simple example of branching and merging with a workflow that you might use in the real world. You’ll follow these steps:

1. Do some work on a website.
2. Create a branch for a new user story you’re working on.
3. Do some work in that branch.

At this stage, you’ll receive a call that another issue is critical and you need a hotfix. You’ll do the following:

1. Switch to your production branch.
2. Create a branch to add the hotfix.
3. After it’s tested, merge the hotfix branch, and push to production.
4. Switch back to your original user story and continue working.

 To create a new branch and switch to it at the same time, you can run the git checkout command with the -b switch:

## Before Beginning

Make sure the main branch just the way you want it and all changes have been committed.

```bash
# git diff, git diff HEAD HEAD~1 and git diff --staged
cd ~/src/go/tutorials/oop/vin1
# or
cd ~/src/go/tutorials/oop/vin_main
# List branches
git branch
# git checkout -b feature1
git checkout -b use_constructors 
Switched to a new branch 'add_test'
```
