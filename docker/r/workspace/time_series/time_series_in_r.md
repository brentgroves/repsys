# Time series in R

## references

<https://robjhyndman.com/tsdl/>

<https://a-little-book-of-r-for-time-series.readthedocs.io/en/latest/src/timeseries.html>

<https://otexts.com/fpp2/>
<https://www.youtube.com/watch?v=iTq6fNfi4Rs>
<https://www.youtube.com/watch?v=wNB8AgZPFLU>

## Either debug in vscode or launch R using compose

With the docker file it is probably easier to install the needed packages.

launch R Studio using compose

```bash
pushd .
cd ~/src/repsys/docker/r
docker compose up

```

## **[R on Ubuntu](../../linux/r/r-install.md)

**[R in VS Code](../../linux/r/r_vscode.md)**

## Using R for Time Series Analysis¶

## Time Series Analysis

This booklet itells you how to use the R statistical software to carry out some simple analyses that are common in analysing time series data.

This booklet assumes that the reader has some basic knowledge of time series analysis, and the principal focus of the booklet is not to explain time series analysis, but rather to explain how to carry out these analyses using R.

If you are new to time series analysis, and want to learn more about any of the concepts presented here, I would highly recommend the Open University book “Time series” (product code M249/02), available from from the Open University Shop.

## Reading Time Series Data

The first thing that you will want to do to analyse your time series data will be to read it into R, and to plot the time series. You can read data into R using the scan() function, which assumes that your data for successive time points is in a simple text file with one column.

For example, the file <http://robjhyndman.com/tsdldata/misc/kings.dat> contains data on the age of death of successive kings of England, starting with William the Conqueror (original source: Hipel and Mcleod, 1994).

Only the first few lines of the file have been shown. The first three lines contain some comment on the data, and we want to ignore this when we read the data into R. We can use this by using the “skip” parameter of the scan() function, which specifies how many lines at the top of the file to ignore. To read the file into R, ignoring the first three lines, we type:

```r
kings <- scan("http://robjhyndman.com/tsdldata/misc/kings.dat",skip=3)
  Read 42 items
> kings
  [1] 60 43 67 50 56 42 50 65 68 43 65 34 47 34 49 41 13 35 53 56 16 43 69 59 48
  [26] 59 86 55 68 51 33 49 67 77 81 67 71 81 68 70 77 56

```

In this case the age of death of 42 successive kings of England has been read into the variable ‘kings’.

Once you have read the time series data into R, the next step is to store the data in a time series object in R, so that you can use R’s many functions for analysing time series data. To store the data in a time series object, we use the ts() function in R. For example, to store the data in the variable ‘kings’ as a time series object in R, we type:

```r
> kingstimeseries <- ts(kings)
> kingstimeseries
  Time Series:
  Start = 1
  End = 42
  Frequency = 1
  [1] 60 43 67 50 56 42 50 65 68 43 65 34 47 34 49 41 13 35 53 56 16 43 69 59 48
  [26] 59 86 55 68 51 33 49 67 77 81 67 71 81 68 70 77 56
```

Sometimes the time series data set that you have may have been collected at regular intervals that were less than one year, for example, monthly or quarterly. In this case, you can specify the number of times that data was collected per year by using the ‘frequency’ parameter in the ts() function. For monthly time series data, you set frequency=12, while for quarterly time series data, you set frequency=4.

You can also specify the first year that the data was collected, and the first interval in that year by using the ‘start’ parameter in the ts() function. For example, if the first data point corresponds to the second quarter of 1986, you would set start=c(1986,2).

An example is a data set of the number of births per month in New York city, from January 1946 to December 1959 (originally collected by Newton). This data is available in the file <http://robjhyndman.com/tsdldata/data/nybirths.dat> We can read the data into R, and store it as a time series object, by typing:

```r
births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
birthstimeseries <- ts(births, frequency=12, start=c(1946,1))
```

Similarly, the file <http://robjhyndman.com/tsdldata/data/fancy.dat> contains monthly sales for a souvenir shop at a beach resort town in Queensland, Australia, for January 1987-December 1993 (original data from Wheelwright and Hyndman, 1998). We can read the data into R by typing:

```r
> souvenir <- scan("http://robjhyndman.com/tsdldata/data/fancy.dat")
  Read 84 items
> souvenirtimeseries <- ts(souvenir, frequency=12, start=c(1987,1))
> souvenirtimeseries
```

Plotting Time Series
Once you have read a time series into R, the next step is usually to make a plot of the time series data, which you can do with the plot.ts() function in R.

For example, to plot the time series of the age of death of 42 successive kings of England, we type:

```r
plot.ts(kingstimeseries)
```

We can see from the time plot that this time series could probably be described using an additive model, since the random fluctuations in the data are roughly constant in size over time.

Likewise, to plot the time series of the number of births per month in New York city, we type:

> plot.ts(birthstimeseries)

## launch R Studio using compose

```bash
pushd .
cd ~/src/repsys/docker/r
docker compose up

```

<https://a-little-book-of-r-for-time-series.readthedocs.io/en/latest/src/timeseries.html>
