pollutantmean <- function(directory, pollutant, id = 1:332) {
    nc <- max(id) + 1 - min(id)
    number <- max(id)
    for(i in 1:nc) {
        filename = paste(directory, "/", formatC(number, width = 3, flag = "0"), ".csv", sep = "")
        data_new <- read.csv(filename)
        if(i == 1) {data <- data_new}
            else {data <- rbind(data_old, data_new)}
        data_old <- data
        number = number - 1
    }
    result <- mean(data[, pollutant], na.rm = TRUE)
    print(result)
}