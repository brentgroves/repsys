# Tutorial

## references

<https://www.w3schools.com/r/>

## Get started with an RStudio® instance

```bash
docker run --rm -ti -e PASSWORD=yourpassword -p 8787:8787 rocker/rstudio

```

and point your browser to localhost:8787. Log in with user/password rstudio/yourpassword.

## Example

How to output some text, and how to do a simple calculation in R:

```r
"Hello World!"
5 + 5
```

How you can use R to easily create a graph with numbers from 1 to 10 on both the x and y axis:

```r
plot(1:10)
```

## output

```r
text <- "awesome"

paste("R is", text)
```
