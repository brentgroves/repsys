# **[How to combine CMD and ENTRYPOINT](https://forums.docker.com/t/how-to-combine-cmd-and-entrypoint/132517)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

In a Dockerfile, ENTRYPOINT and CMD are both instructions that define how a container starts when it's run. Here's how they work together:

## ENTRYPOINT

- Sets the main command for the container.
- This command is executed when the container starts and cannot be overridden by default.
- Use the exec form to define the command as an array, which is the recommended practice:

```dockerfile
ENTRYPOINT ["executable", "arg1", "arg2"]
```

## CMD

- Provides default arguments for the ENTRYPOINT command.
- These arguments can be overridden when running the container.
- Use the exec form to define the arguments as an array:

```dockerfile
CMD ["arg1", "arg2"]
```

## How they interact

- When you run a container, Docker combines the ENTRYPOINT and CMD instructions to create the final command that's executed.
- If you don't specify a CMD, the default arguments in the CMD instruction will be used.
- If you override the CMD when running the container, the new arguments will be used instead.

Example:

```dockerfile
FROM ubuntu

ENTRYPOINT ["/bin/echo"] 
CMD ["Hello World"]
```

- Building and running this Dockerfile without any arguments will output "Hello World".
- Running the container with docker run <image_name> "Goodbye" will output "Goodbye".

Choosing the right approach:

- Use ENTRYPOINT when you want to define the primary purpose of your container and ensure that a specific command always runs.
- Use CMD to provide default arguments that can be overridden, making your container more flexible.

In most cases, using both ENTRYPOINT and CMD is the best practice.
