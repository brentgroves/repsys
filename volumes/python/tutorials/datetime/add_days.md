# **[]()**

To add days to a datetime object in Python, utilize the timedelta class from the datetime module.
Here is an example:
Python

from datetime import datetime, timedelta

# Get the current date and time

current_datetime = datetime.now()
print(f"Current datetime: {current_datetime}")

# Define the number of days to add

days_to_add = 7

# Create a timedelta object

delta = timedelta(days=days_to_add)

# Add the timedelta to the datetime object

future_datetime = current_datetime + delta
print(f"Datetime after adding {days_to_add} days: {future_datetime}")

# You can also subtract days by using a negative number or the minus operator

days_to_subtract = 3
past_datetime = current_datetime - timedelta(days=days_to_subtract)
print(f"Datetime after subtracting {days_to_subtract} days: {past_datetime}")
In this example:
datetime.now() retrieves the current date and time.
timedelta(days=days_to_add) creates a timedelta object representing a duration of 7 days.
Adding the timedelta object to the datetime object (current_datetime + delta) calculates the new datetime object, effectively adding the specified number of days.
Subtracting days works similarly, either by using a negative value for days in timedelta or by using the subtraction operator.
