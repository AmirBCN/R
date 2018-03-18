pollutantmean <- function(directory, pollutant, id = 1:332) {
  SUM <- 0
  LG <- 0
  for(i in id)
  {
    csvfiles <- sprintf("%s/%03d.csv", directory, i)
    Data <- read.csv(file=csvfiles, sep=",")
    
    #for(j in 1:nrow(Data[pollutant]))
    #{
    #  if(is.na(Data[j,pollutant]) == FALSE)
    #  {
    #    SUM <- SUM + Data[j,pollutant]
    #    LG <- LG + 1
    #  }
    #}
    
    
    
    DataClean <- na.omit(Data[pollutant])
    SUM <- SUM + as.numeric(colSums(DataClean))
    LG <- LG + nrow(DataClean)
  }
  SUM / LG
}

  
