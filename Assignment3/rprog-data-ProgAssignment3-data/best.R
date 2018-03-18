best <- function(state, outcome) {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        ## Check that state and outcome are valid
        if(sum(data$State == state) == 0)
        {
                print("Error: Invalid state")
                return()
        }
        #####
        if(outcome != "heart attack" && outcome != "heart failure" && outcome != "pneumonia")
        {
                print("Error: Invalid outcome")
                return()
        }           
        ## Return hospital name in that state with lowest 30-day death
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
        index <- which.min(Deathrate)
        HospNames <- Names[index]
        HospNames <- sort(HospNames)
        HospNames[1]
}

