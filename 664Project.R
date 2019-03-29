#Milestone 1
#-----------
library(jsonlite)
prodata <- fromJSON("http://ist.gmu.edu/~hpurohit/courses/ait690-proj-data-spring17.json")
write.csv(prodata,"prodata.csv")

#Milestone 2
#-----------
library(tidyr)
library(stringr)
library(foreign)

#Removing unnecessary Columns
for(i in seq(from=1, to=3135, by=1)){
  prodata$DOCUMENT_ID<-NULL
}

#Separating the Date and Time
prodata <- separate(prodata,DATETIME,into = c("DATE","TIME"),sep =" ")

#Removing unnecessary characters from Message Column
prodata$MESSAGE <- gsub("@", " " , prodata$MESSAGE)
prodata$MESSAGE <- gsub("#", " " , prodata$MESSAGE)
prodata$MESSAGE <- gsub("(s?)(f|ht)tp(s?)://\\S+\\b", "", prodata$MESSAGE)
prodata$MESSAGE <- gsub("[[:punct:]]", " " , prodata$MESSAGE)
prodata$MESSAGE <- gsub("[0-9]", " " , prodata$MESSAGE)
prodata$MESSAGE <- gsub("\\ can ", " " , prodata$MESSAGE)
prodata$MESSAGE <- gsub("\\ to ", " " , prodata$MESSAGE)
prodata$MESSAGE <- gsub("\\ is ", " " , prodata$MESSAGE)
prodata$MESSAGE <- gsub("\\ the ", " " , prodata$MESSAGE)
prodata$MESSAGE <- gsub("\\ did ", " " , prodata$MESSAGE)
prodata$MESSAGE <- gsub("\\You ", " " , prodata$MESSAGE)
prodata$MESSAGE <- gsub("\\Your ", " " , prodata$MESSAGE)
prodata$MESSAGE <- gsub("\\The ", " " , prodata$MESSAGE)
prodata$MESSAGE <- tolower(prodata$MESSAGE)

#Imputation of longitude
mnvaltot <- 0
mnvalcnt <- 0
for(i in seq(from=1, to=3135, by=1)){
  if(!(prodata$LONGITUDE[i] == 10000))
  {
    mnvaltot <- mnvaltot + as.numeric(prodata$LONGITUDE[i])
    mnvalcnt <- mnvalcnt + 1
  }
}
mnval <- (mnvaltot/mnvalcnt)
for(i in seq(from=1, to=3135, by=1)){
  if(prodata$LONGITUDE[i] == 10000)
  {
    prodata$LONGITUDE[i] <- mnval
  }
}

#Imputation of Latitude
mnvaltotlat <- 0
mnvalcntlat <- 0
for(i in seq(from=1, to=3135, by=1)){
  if(!(prodata$LATITUDE[i] == 10000))
  {
    mnvaltotlat <- mnvaltotlat + as.numeric(prodata$LATITUDE[i])
    mnvalcntlat <- mnvalcntlat + 1
  }
}
mnvallat <- (mnvaltotlat/mnvalcntlat)
for(i in seq(from=1, to=3135, by=1)){
  if(prodata$LATITUDE[i] == 10000)
  {
    prodata$LATITUDE[i] <- mnvallat
  }
}

#Writing to CSV to ARFF

write.csv(prodata,"C:/Users/csame/Desktop/projectfile.csv")
exceldata = read.csv('C:/Users/csame/Desktop/projectfile.csv')
write.arff(exceldata, file='C:/Users/csame/Desktop/projectfile.arff')

