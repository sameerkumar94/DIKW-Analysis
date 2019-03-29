library(tidyr)
library(stringr)
library(foreig)
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
vitdata = read.csv('C:/Users/csame/Desktop/AIT 664/clusterfile.csv')
View(vitdata)
#data.frame(table(unlist(strsplit(tolower(vitdata$cluster1), " "))))

#Cluster-1
data1 <- Corpus(VectorSource(vitdata$cluster1))
data <- TermDocumentMatrix(data1)
mat <- as.matrix(data)
type <- sort(rowSums(mat),decreasing=TRUE)
freq <- data.frame(word = names(type),freq=type)
head(freq, 10)

#Cluster-2
data1 <- Corpus(VectorSource(vitdata$cluster2))
data <- TermDocumentMatrix(data1)
mat <- as.matrix(data)
type <- sort(rowSums(mat),decreasing=TRUE)
freq <- data.frame(word = names(type),freq=type)
head(freq, 10)

#Cluster-3
data1 <- Corpus(VectorSource(vitdata$cluster3))
data <- TermDocumentMatrix(data1)
mat <- as.matrix(data)
type <- sort(rowSums(mat),decreasing=TRUE)
freq <- data.frame(word = names(type),freq=type)
head(freq, 10)