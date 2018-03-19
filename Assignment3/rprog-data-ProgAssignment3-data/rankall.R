rankall <- function(outcome, num = "best") {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        ## Check that state and outcome are valid
        if(outcome != "heart attack" && outcome != "heart failure" && outcome != "pneumonia")
                stop("Error: Invalid outcome")    
        
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        HospNamesOUT <- data.frame(hospital=character(), state=character())
        #
        StateNames <- sort(unique(data$State))
        
        for(i in 1:length(StateNames))
        {
                HospNames <- data[data$State == StateNames[i], 2]
                if(outcome == "heart attack")
                {
                        Deathrate <- as.numeric(data[data$State == StateNames[i], 11])
                }
                if(outcome == "heart failure")
                {
                        Deathrate <- as.numeric(data[data$State == StateNames[i], 17])
                }
                if(outcome == "pneumonia")
                {
                        Deathrate <- as.numeric(data[data$State == StateNames[i], 23])
                }

                index <- order(Deathrate, HospNames, na.last = NA)
                
                if(is.character(num) == FALSE && num > length(Deathrate))
                        Hosplist <- list(hospital = NA , state = StateNames[i])
                else if(num == "worst")
                        Hosplist <- list(hospital = HospNames[index[length(index)]], state = StateNames[i])
                
                else if(num == "best")
                        Hosplist <- list(hospital = HospNames[index[1]], state = StateNames[i])
                else
                        Hosplist <- list(hospital = HospNames[index[num]], state = StateNames[i])
                
                #### Adding to the Hospital list 
                HospNamesOUT = rbind(HospNamesOUT,Hosplist,stringsAsFactors = FALSE)
        }
        
        #HospNames <- sort(HospNames)
        HospNamesOUT
}



