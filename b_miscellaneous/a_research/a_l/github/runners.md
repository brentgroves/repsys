# **[GitHub Runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners/about-github-hosted-runners#supported-runners-and-hardware-resources)**

**[Back to Research List](../../research_list.md)**\
**[Back to Juju List](./juju_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## references

<https://github.com/actions/runner>
<https://github.com/actions/runner-images>

The runner is the application that runs a job from a GitHub Actions workflow. It is used by GitHub Actions in the **[hosted virtual environments](https://github.com/actions/virtual-environments)**, or you can self-host the runner in your own environment.

## About GitHub-hosted runners

GitHub offers hosted virtual machines to run workflows. The virtual machine contains an environment of tools, packages, and settings available for GitHub Actions to use.

## Overview of GitHub-hosted runners

Runners are the machines that execute jobs in a GitHub Actions workflow. For example, a runner can clone your repository locally, install testing software, and then run commands that evaluate your code.

GitHub provides runners that you can use to run your jobs, or you can host your own runners. Each GitHub-hosted runner is a new virtual machine (VM) hosted by GitHub with the runner application and other tools preinstalled, and is available with Ubuntu Linux, Windows, or macOS operating systems. When you use a GitHub-hosted runner, machine maintenance and upgrades are taken care of for you.
