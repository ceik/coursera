rankhospital <- function(state, outcome, num = "best") {
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
    colnames(data_clean) <- c("name", "state", "value")
    
    data_sorted <- data_clean[order(as.numeric(as.character(data_clean$value)), data_clean$name),]
    rows <- nrow(data_sorted)
    
    if(num == "best") {r = 1}
        else if(num == "worst") {r = rows}
        else if(as.numeric(num) > rows) {return(NA)}
        else {r = as.numeric(num)}

    return(as.character(data_sorted[r,1]))
}