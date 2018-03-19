rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        ## Check that state and outcome are valid
        if(sum(data$State == state) == 0)
                stop("Error: Invalid state")        
        #####
        if(outcome != "heart attack" && outcome != "heart failure" && outcome != "pneumonia")
                stop("Error: Invalid outcome")    
        
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        
        if(outcome == "heart attack")
        {
                Deathrate <- as.numeric(data[data$State == state, 11])
                Names <- data[data$State == state, 2]
        }
        if(outcome == "heart failure")
        {
                Deathrate <- as.numeric(data[data$State == state, 17])
                Names <- data[data$State == state, 2]
        }
        if(outcome == "pneumonia")
        {
                Deathrate <- as.numeric(data[data$State == state, 23])
                Names <- data[data$State == state, 2]
        }
        
        if(is.character(num) == FALSE && num > length(Deathrate))
                stop("Error: NA")       

        index <- order(Deathrate, Names, na.last = NA)
        
        if(num == "worst")
                HospNames <- Names[index[length(index)]]
  
        else if(num == "best")
                HospNames <- Names[index[1]]   
        else
                HospNames <- Names[index[num]]
        #HospNames <- sort(HospNames)
        HospNames
}



