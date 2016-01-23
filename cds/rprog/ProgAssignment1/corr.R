corr <- function(directory, threshold = 0) {
    files <- complete(directory)
    valid_files <- subset(files, nobs > threshold)
    no_valid_files <- nrow(valid_files)
    print(no_valid_files)
    if(no_valid_files ==0) {result <- vector(mode="numeric", length=0)}
        else {
            for(i in 1:no_valid_files) {
            filename = paste(directory, "/", formatC(valid_files[i,1], width = 3, flag = "0"), ".csv", sep = "")
            data <- read.csv(filename)
            this_cor <- cor(data$sulfate, data$nitrate, use = "complete.obs")
            if(i == 1) {result <- this_cor}
                else {result[i] <- this_cor}
            }
            print(result)
        }
}