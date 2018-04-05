library(readxl)
library("dplyr")
api_key <- "0cf83ff665c570c59b951edd15ea6d82"
set_api_key(api_key)
url_pattern <- "http[s]?://www(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"
#LaCaNPage <- readLines('https://www.lacan.upc.edu/scientificPublications/publications/811')
# grep("LaC&agrave;N", LaCaNPage)
DataLC <- read_excel("WebArticlesLaCaN.xlsx")
DataLC <- DataLC[,1:15]
DataLC <- DataLC[-1,]
names(DataLC) <- c("Code", "Title", "Authors", "BibData", "DOI", "Link", "PDF", "UPClink", "URL", "Img", "Bibtext", "CA1", "CA2", "Journal", "ISBN")# Removing the NA raws
DataLC <- DataLC[!(is.na(DataLC$Code)) & !(is.na(DataLC$Authors)) & !(is.na(DataLC$Title)),]
# Counting the douplicate Rows
# CODE
n_occur1 <- data.frame(table(DataLC$Code))
n_occur1 <- n_occur1[n_occur1$Freq > 1,]
## Show the duplicate raws
Dupl1 <- DataLC[DataLC$Code %in% n_occur1$Var1[n_occur1$Freq > 1],]
Dupl1 <- unique(Dupl1$Code)
##################
# Title
n_occur2 <- data.frame(table(DataLC$Title))
n_occur2 <- n_occur2[n_occur2$Freq > 1,]
## Show the duplicate raws
Dupl2 <- DataLC[DataLC$Title %in% n_occur2$Var1[n_occur2$Freq > 1],]
Dupl2 <- unique(Dupl2$Title)
##################
# DOI
n_occur3 <- data.frame(table(DataLC$DOI))
n_occur3 <- n_occur3[n_occur3$Freq > 1,]
## Show the duplicate raws
Dupl3 <- DataLC[DataLC$DOI %in% n_occur3$Var1[n_occur3$Freq > 1],]
Dupl3 <- unique(Dupl3$DOI)
##################
# UPC link
n_occur4 <- data.frame(table(DataLC$UPClink))
n_occur4 <- n_occur4[n_occur4$Freq > 1,]
## Show the duplicate raws
Dupl4 <- DataLC[DataLC$UPClink %in% n_occur4$Var1[n_occur4$Freq > 1],]
Dupl4 <- unique(Dupl4$UPClink)
##################
UPClink <- DataLC$URL

j = 1
for (i in UPClink)
{
       if (!grepl("handle", i))
       {
               tryCatch({
               URL <- ""        
               URL <- DataLC$Link[j]
               URLpage <- readLines(URL)
               if (length(grep("Labratori de C", URLpage)) != 0 | length(grep("LaC", URLpage)) != 0)
               {
                       print(DataLC$Code[j])  
               }
               else{
                       temp <- article_retrieval(DataLC$DOI[j], identifier = "doi", verbose = FALSE)
                       urlfind <- str_extract(temp, url_pattern)
                       ID <- grep("https://www", urlfind)
                       if(length(ID) != 0)
                       {
                               URLpage <- readLines(urlfind[ID])
                       }
                       if (length(grep("Labratori de C", URLpage)) != 0 | length(grep("LaC", URLpage)) != 0)
                       {
                               print(DataLC$Code[j])  
                       }
               }
                       
               }, error=function(e){print(c("Link ERROR", DataLC$Code[j]))})
       }
       else # Checking for a pdf
       {
               tryCatch({
                       URL <- ""        
                       #URL <- DataLC$URL[j]
                       #URLpage <- readLines(URL)
                       #if (length(grep(".pdf", URLpage)) == 0 & length(grep(".PDF", URLpage)) == 0)
                       #{
                        #       print(c("PDF Error", DataLC$Code[j]))  
                       #}
                       #URL <- DataLC$URL[j]
                       ##################################
                       URL <- DataLC$Link[j]
                       URLpage <- readLines(URL)
                       if (length(grep("Laboratori de C", URLpage)) == 0 & length(grep("LaC", URLpage)) == 0)
                       {
                               temp <- article_retrieval(DataLC$DOI[j], identifier = "doi", verbose = FALSE)
                               urlfind <- str_extract(temp, url_pattern)
                               ID <- grep("https://www", urlfind)
                               if(length(ID) != 0)
                               {
                               URLpage <- readLines(urlfind[ID])
                               }
                               if (length(grep("Laboratori de C", URLpage)) == 0 & length(grep("LaC", URLpage)) == 0)
                               {
                                       print(c("LaCaN Error", DataLC$Code[j]))
                                       #print(c("LaCaN Error", DataLC$Code[j] ,  DataLC$Link[j]))
                               }
                       ##################################
                       }
               }, error=function(e){print(c("HANDLE ERROR", DataLC$Code[j]))})                
       }
       j = j+1
       #print(j)
}



