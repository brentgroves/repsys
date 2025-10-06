# **[](https://www.dataquest.io/blog/python-datetime-tutorial/)**

## Extract Year and Month from the Date

Now we’ve seen what makes up a datetime object, we can probably guess how date and time objects look, because we know that date objects are just like datetime without the time data, and time objects are just like datetime without the date data.

We can also antipate some problems. For example, in most data sets, date and time information is stored in string format! Also, we may not want all of this date and time data — if we’re doing something like a monthly sales analysis, breaking things down by microsecond isn’t going to be very useful.

So now, let’s start digging into a common task in data science: extracting only the elements that we actually want from a string using datetime.

To do this, we need to do a few things.

## Handling Date and Time Strings with strptime() and strftime()

Thankfully, datetime includes two methods, strptime() and strftime(), for converting objects from strings to datetime objects and vice versa. strptime() can read strings with date and time information and convert them to datetime objects, and strftime() converts datetime objects back into strings.

Of course, strptime() isn’t magic — it can’t turn any string into a date and time, and it will need a little help from us to interpret what it’s seeing! But it’s capable of reading most conventional string formats for date and time data (see the documentation for more details). Let’s give it a date string in YYYY-MM-DD format and see what it can do!

```python
my_string = '2019-10-31'

# Create date object in given time format yyyy-mm-dd
my_date = datetime.strptime(my_string, "

print(my_date)
print('Type: ',type(my_date))
```

2019-10-31 00:00:00 Type:  'datetime.datetime'
Note that strptime() took two arguments: the string (my_string) and "

A full list of these patterns is available in the documentation, and we’ll go into these methods in more depth later in this tutorial.

You may also have noticed that a time of 00:00:00 has been added to the date. That’s because we created a datetime object, which must include a date and a time. 00:00:00 is the default time that will be assigned if no time is designated in the string we’re inputting.

Anyway, we were hoping to separate out specific elements of the date for our analysis. One way can do that using the built-in class attributes of a datetime object, like .month or .year:

```python
print('Month: ', my_date.month) # To Get month from date
print('Year: ', my_date.year) # To Get month from year
```
