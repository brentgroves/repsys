kings <- scan("http://robjhyndman.com/tsdldata/misc/kings.dat", skip = 3)
kings
kingstimeseries <- ts(kings)
kingstimeseries
births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
birthstimeseries <- ts(births, frequency=12, start=c(1946,1))
birthstimeseries
souvenir <- scan("http://robjhyndman.com/tsdldata/data/fancy.dat")
souvenirtimeseries <- ts(souvenir, frequency=12, start=c(1987,1))
souvenirtimeseries
plot.ts(kingstimeseries)
plot.ts(birthstimeseries)
