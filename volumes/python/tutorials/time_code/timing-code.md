# Timing code

## references

<https://realpython.com/python-timer/>

## tutorial

In this tutorial, you’ll learn how to use:

- time.perf_counter() to measure time in Python
- Classes to keep state
- Context managers to work with a block of code
- Decorators to customize a function

## Python Timers

First, you’ll take a look at some example code that you’ll use throughout the tutorial. Later, you’ll add a Python timer to this code to monitor its performance. You’ll also learn some of the simplest ways to measure the running time of this example.

## Python Timer Functions

If you check out the built-in time module in Python, then you’ll notice several functions that can measure time:

- monotonic()
- perf_counter()
- process_time()
- time()

Python 3.7 introduced several new functions, like thread_time(), as well as nanosecond versions of all the functions above, named with an_ns suffix. For example, perf_counter_ns() is the nanosecond version of perf_counter(). You’ll learn more about these functions later. For now, note what the documentation has to say about perf_counter():

    Return the value (in fractional seconds) of a performance counter, i.e. a clock with the highest available resolution to measure a short duration. (Source)

First, you’ll use perf_counter() to create a Python timer. Later, you’ll compare this with other Python timer functions and learn why perf_counter() is usually the best choice.

## Example: Download Tutorials

To better compare the different ways that you can add a Python timer to your code, you’ll apply different Python timer functions to the same code example throughout this tutorial. If you already have code that you’d like to measure, then feel free to follow the examples with that instead.

The example that you’ll use in this tutorial is a short function that uses the realpython-reader package to download the latest tutorials available here on Real Python. To learn more about the Real Python Reader and how it works, check out How to Publish an Open-Source Python Package to PyPI. You can install realpython-reader on your system with pip:

    ```bash
    conda activate base
    pip install realpython-reader
    ```
The reader is supported on Python 3.7 and above. Older versions of Python, including Python 2.7, are supported by version 1.0.0 of the reader.

## Real Python Feed Reader

The Real Python Feed Reader is a basic web feed reader that can download the latest Real Python tutorials from the Real Python feed.
For more information see the tutorial How to Publish an Open-Source Python Package to PyPI on Real Python.

The Python Package Index (PyPI) is a repository of software for the Python programming language.
PyPI helps you find and install software developed and shared by the Python community. Learn about installing packages.

## Then, you can import the package as reader

You’ll store the example in a file named latest_tutorial.py. The code consists of one function that downloads and prints the latest tutorial from Real Python:

    ```python
    # latest_tutorial.py

    from reader import feed

    def main():
        """Download and print the latest tutorial from Real Python"""
        tutorial = feed.get_article(0)
        print(tutorial)

    if __name__ == "__main__":
        main()
    ```

The code may take a little while to run depending on your network, so you might want to use a Python timer to monitor the performance of the script.

## Your First Python Timer

Now you’ll add a bare-bones Python timer to the example with time.perf_counter(). Again, this is a performance counter that’s well-suited for timing parts of your code.

perf_counter() measures the time in seconds from some unspecified moment in time, which means that the return value of a single call to the function isn’t useful. However, when you look at the difference between two calls to perf_counter(), you can figure out how many seconds passed between the two calls:

    ```python
    >>> import time
    >>> time.perf_counter()
    32311.48899951

    >>> time.perf_counter()  # A few seconds later
    32315.261320793
    ```

In this example, you made two calls to perf_counter() almost 4 seconds apart. You can confirm this by calculating the difference between the two outputs: 32315.26 - 32311.49 = 3.77.

You can now add a Python timer to the example code:

    ```python
    # latest_tutorial.py

    import time
    from reader import feed

    def main():
        """Print the latest tutorial from Real Python"""
        tic = time.perf_counter()
        tutorial = feed.get_article(0)
        toc = time.perf_counter()
        print(f"Downloaded the tutorial in {toc - tic:0.4f} seconds")

        print(tutorial)

    if __name__ == "__main__":
        main()
    ```

Note that you call perf_counter() both before and after downloading the tutorial. You then print the time it took to download the tutorial by calculating the difference between the two calls.

Note: In line 11, the f before the string indicates that this is an f-string, which is a convenient way to format a text string. :0.4f is a format specifier that says the number, toc - tic, should be printed as a decimal number with four decimals.

For more information about f-strings, check out Python’s F-String for String Interpolation and Formatting.
