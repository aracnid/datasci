setwd("~/repos/datasci/03_getting-and-cleaning-data/assign4")

# Question 1
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
#download.file(fileurl, destfile="./data1.csv", method="curl")
data1 <- read.csv("data1.csv")
splitNames <- strsplit(names(data1), "wgtp")
print(splitNames[123])
# What is the value of the 123rd element?
# ""    "15"


# Question 2
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
#download.file(fileurl, destfile="./gdp.csv", method="curl")
gdp <- read.csv("gdp.csv", header=FALSE)
gdp <- gdp[6:195,c(1,2,4,5)]
names(gdp) <- c("CountryCode", "rank", "CountryName", "gdp")
gdpVal <- as.numeric(gsub(",", "", as.character(gdp$gdp)))
print(mean(gdpVal))
# What is the average?
# 377652.4


# Question 3
# What is the regular expression that would allow you to count the number 
#of countries whose name begins with "United"?  How many countries?
countryNames <- gdp$CountryName
print(length(grep("^United", countryNames)))
# grep("^United", countryNames)
# 3 countries


# Question 4
fileurlED <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
#download.file(fileurlED, destfile="./ed.csv", method="curl")
ed <- read.csv("ed.csv")
joined <- merge(gdp, ed, by.x="CountryCode", by.y="CountryCode")
notes <- joined$Special.Notes
print(length(grep("Fiscal year.*June", notes)))
# How many countries have a fiscal year end in June?
# 13


# Question 5
library(quantmod)
amzn <- getSymbols("AMZN", auto.assign=FALSE)
sampleTimes <- index(amzn)
year2012 <- sampleTimes[sampleTimes >= "2012-01-01" & sampleTimes < "2013-01-01"]
wk <- weekdays(year2012)
mon <- wk[wk == "Monday"]
print(c(length(year2012), length(mon)))
# How many values were collected in 2012? 
# How many values were collected on Mondays in 2012?
# 250   47