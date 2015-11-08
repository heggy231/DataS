getwd()
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, destfile = "./data/housing.csv")
list.files("./data")
house<- read.csv("./data/housing.csv")
head(house,2)
home_24 <- house$VAL[complete.cases(house$VAL) & house$VAL==24]
length(home_24)

subset(house,val==24)
table(house$FES)
summary(house$FES)
house$FES[1:5]#first 5 rows
library(xlsx)

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileURL, destfile="./data/gov.xlsx")
list.files("./data")
rowIndex <- 18:23
colIndex <- 7:15
dat<-read.xlsx("./data/gov2.xlsx", sheetIndex=1, colIndex=colIndex, 
               rowIndex=rowIndex, header=TRUE)

sum(dat$Zip*dat$Ext,na.rm=T) #na.rm is a parameter (argument) of Sum,
    #na.rm is set False by default, keeps NA value 

## ... unless  we exclude missing values explicitly:
## sum(1:5, NA, na.rm = TRUE)

## Pass a vector to sum, and it will add the elements together.
## sum(1:5)
install.packages("XML")
library(XML)
rest <- xmlTreeParse("./data/getdata_data_restaurants.xml", useInternalNodes = TRUE)
#like rest<-read.csv("file",) this saves the file under
#variable rest
xmltop<-xmlRoot(rest) #
#xmltop
#xmltop[[1]][[2]][[2]]
restaurants <- xpathSApply(xmltop, "//zipcode", xmlValue) 
#array xpathSApply got the array
restTable <- xpathApply(xmltop, "//row", xmlValue) #A list a vector
length(restaurants[restaurants=="21231"])
#now we only have zipcode under restaurant so get th
#lenghth (No) of zipde = 21231
length(restaurants)


#Q5) 
#1) download the file
install.packages("data.table")
require(data.table) 
#require fail with error, same with library but 
#library keeps d/l without fail
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "./data/commSurv.csv")
DT <- fread("./data/commSurv.csv",sep =",")
#inorder to run fread you must have data.table package required(read same)
head(commSurv) 

mean(DT$pwgtp15,by=DT$SEX) #only gives one number we need 2 no.

rowMeans(DT)[DT$SEX==1]; 
rowMeans(DT)[DT$SEX==2]  #not working

mean(DT[DT$SEX==1,]$pwgtp15); 
mean(DT[DT$SEX==2,]$pwgtp15) ##gives 2 numbers good

tapply(DT$pwgtp15,DT$SEX,mean) # works! 2 numbers
#tapply(array, indicies, function, ..., simplify)
#array column, indicies category SEX, function mean

sapply(split(DT$pwgtp15,DT$SEX),mean) #works! 2 numbers
#sapply(list, function, ..., simplify)
#split(x, f, drop = FALSE, ...), x- whole vector, data frame
#f - factor defines the grouping, drop - 
DT[,mean(pwgtp15),by=SEX] ##works! 2 numbers

tapply(DT$pwgtp15,DT$SEX,mean) ##works! 2 numbers.  good sign


system.time(for(i in 1:100) tapply(DT$pwgtp15,DT$SEX,mean))
system.time(rowMeans(DT)[DT$SEX==1])
system.time(rowMeans(DT)[DT$SEX==2])
system.time(for(i in 1:100) sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(for(i in 1:100) DT[,mean(pwgtp15),by=SEX])
system.time(for(i in 1:100) mean(DT[DT$SEX==1,]$pwgtp15))
system.time(for(i in 1:100) mean(DT[DT$SEX==2,]$pwgtp15))
system.time(for(i in 1:1000) mean(DT$pwgtp15,by=DT$SEX))
mean(DT$pwgtp15,by=DT$SEX)
