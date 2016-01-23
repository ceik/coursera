rankall <- function(outcome, num = "best") {
    data <- read.csv("outcome-of-care-measures.csv")
    su <- unique(data[,7])
    states <- sort(su)
    
    if(outcome == "heart attack") {col <- 11}
        else if(outcome == "heart failure") {col <- 17}
        else if(outcome == "pneumonia") {col <- 23}
        else {stop("invalid outcome")}
    
    data_slim <- data.frame(data[, c(2, 7, col)])
    colnames(data_slim) <- c("name", "state", "value")
    data_clean <- data_slim[!data_slim$value == "Not Available",]
    
    result <- data.frame(hospital=NULL, state=NULL)
    
    for(s in states) {
        h <- NULL
        data_state <- data_clean[data_clean$state == s,]
        data_sorted <- data_state[
            order(as.numeric(as.character(data_state$value)), data_state$name),]
        
        rows <- nrow(data_sorted)
        if(num == "best") {r = 1}
            else if(num == "worst") {r = rows}
            else if(as.numeric(num) > rows) {h <- NA}
            else {r = as.numeric(num)}
        
        if(is.null(h)) {h <- as.character(data_sorted[r,1])}
            else {n <- NA}
        
        result_s <- data.frame(hospital=h, state=s)
        
        result <- rbind(result, result_s)
    }
    return(result)
}