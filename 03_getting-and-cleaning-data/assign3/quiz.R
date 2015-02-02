setwd("~/repos/datasci/03_getting-and-cleaning-data/assign3")

# Question 1
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
#download.file(fileurl, destfile="./data.csv", method="curl")
data <- read.csv("data.csv")
agricultureLogical <- (data$ACR == 3 & data$AGS == 6)
print("Question 1:")
print(which(agricultureLogical))
# What are the first 3 values of that result?  125, 238, 262

# Question 2
library(jpeg)
fileurl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
#download.file(fileurl2, destfile="./jeff.jpg", method="curl")
pic <- readJPEG("jeff.jpg", native=TRUE)
print("Question 2:")
print(quantile(pic, probs=seq(0, 1, .1))[c(4, 9)])
# What are the 30th and 80th quantiles of the resulting data?
# 30th: -15258512, 80th: -10575416

# Question 3
fileurlGDP <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
#download.file(fileurlGDP, destfile="./gdp.csv", method="curl")
gdp <- read.csv("gdp.csv", header=FALSE)
gdp <- gdp[6:195,c(1, 2, 4)]
names(gdp) <- c("CountryCode", "rank", "CountryName")
# convert the rank from a factor to a numeric, because factor is not ordered properly
gdp$rank <- as.numeric(as.character(gdp$rank))
fileurlED <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
#download.file(fileurlED, destfile="./ed.csv", method="curl")
ed <- read.csv("ed.csv")
joined <- merge(gdp, ed, by.x="CountryCode", by.y="CountryCode")
sorted <- joined[order(joined$rank, decreasing=TRUE),]
print("Question 3:")
print(paste(c("Matching countries = ", nrow(sorted)), collapse=""))
print(sorted[13,"CountryName"])
# How many of the IDs match?  What is the 13th country in the resulting data frame?
# 189, St. Kitts and Nevis

# Question 4
print("Question 4:")

# What is the average GDP ranking for the "High income: OECD" group?
grpOECD <- mean(joined[(joined$Income.Group=="High income: OECD"),]$rank)
# What is the average GDP ranking for the "High income: nonOECD" group?
grpNonOECD <- mean(joined[(joined$Income.Group=="High income: nonOECD"),]$rank)
print(c(grpOECD, grpNonOECD))
# answer = 32.96667, 91.91304

# Question 5
print("Question 5:")

joined$qrank <- cut(joined$rank, breaks=quantile(joined$rank, probs=seq(0, 1, .2)))
t <- table(joined$qrank, joined$Income.Group)
print(t)
# How many countries are Lower middle income but among the 38 nations with highest GDP?
# answer = 5