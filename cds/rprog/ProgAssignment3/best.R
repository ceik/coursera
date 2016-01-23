best <- function(state, outcome) {
    data <- read.csv("outcome-of-care-measures.csv")
    states <- unique(data[,7])
    
    if(! state %in% states) {stop("invalid state")}
    
    if(outcome == "heart attack") {col <- 11}
        else if(outcome == "heart failure") {col <- 17}
        else if(outcome == "pneumonia") {col <- 23}
        else {stop("invalid outcome")}
    
    data_state <- data[data[,7] == state,]
    data_state_slim <- data.frame(data_state[, c(2, 7, col)])
    data_clean <- data_state_slim[!data_state_slim[,3] == "Not Available",]
    min <- min(as.numeric(as.character(data_clean[,3])))
    data_best <- data_clean[as.numeric(as.character(data_clean[,3])) == min,]
    
    return(as.character(data_best[1,1]))
}