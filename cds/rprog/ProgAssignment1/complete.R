complete <- function(directory, id = 1:332) {
    nf <- length(id) ## max(id) + 1 - min(id)
    number <- id[1]
    for(i in 1:nf) {
        filename = paste(directory, "/", formatC(number, width = 3, flag = "0"), ".csv", sep = "")
        data <- read.csv(filename)
        good_rows <- nrow(na.omit(data))
        if(i == 1) {df <- data.frame(id = number, nobs = good_rows)}
            else {dfi <- data.frame(id = number, nobs = good_rows)
                df <- rbind(df, dfi)}
        next_number <- i + 1
        if(next_number <= nf) {number <- id[[next_number]]}
    }
    print(df)
}