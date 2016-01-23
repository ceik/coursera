---
title: "Severe Weather Events Impact"
output: html_document
---


# Data Processing

## Load & Subset

First the data needs to be loaded into R.
```{r, cache=TRUE}
setwd("C:/Chris/cds/repdata/cp2")
data <- read.csv("storm_data.csv")
```

Also the required packages need to be loaded.
```{r}
library(stringr)
```

Afterwards I subset the data to only include the relevant columns and only those
rows which will have an impact on the result. This will exclude rows/events in
which no human was harmed and no economic damage was caused.
```{r}
data_sub <- data[, c(8, 23, 24, 25, 26, 27, 28)]
data_sub2 <- data_sub[(data_sub$PROPDMG > 0 | data_sub$CROPDMG > 0 |
                           data_sub$FATALITIES > 0 | data_sub$INJURIES > 0),]
head(data_sub2)
```


## Factor Colum Cleanup

### Event Type

After removing not needed rows there are still 488 different event types, many 
of them actually being the same.

As a first step I convert the EVTYPE column to character and back to factor in
order to get rid of factor levels that are not relevant anymore (there were 985
EVTYPEs before subsetting the data). Afterwards I check my data frame and 
generate a table with all remaning event type.
```{r}
data_sub2$EVTYPE <- as.character(data_sub2$EVTYPE)
data_sub2$EVTYPE <- as.factor(data_sub2$EVTYPE)
table(data_sub2$EVTYPE)
str(data_sub2)
```

First I apply general rules to clean up obvious mistakes. This includes extra
whitespace and converting everything to lowercase.
```{r}
data_sub2$EVTYPE <- as.character(data_sub2$EVTYPE)
data_sub2$EVTYPE <- str_trim(data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("   ", " ", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("  ", " ", data_sub2$EVTYPE)
data_sub2$EVTYPE <- tolower(data_sub2$EVTYPE)
data_sub2$EVTYPE <- as.factor(data_sub2$EVTYPE)
```

Next I get rid of plural forms of words, abbreviations, and words that are 
nearly similar in meaning. While this might lead to worse awkward names it will
improve the quality of the data.
```{r}
data_sub2$EVTYPE <- as.character(data_sub2$EVTYPE)

data_sub2$EVTYPE <- gsub("tstm", "thunderstorm", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("winds", "wind", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("flooding", "flood", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("floods", "flood", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("cstl", "coastal", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("\\\\", "/", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("waves", "wave", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("rains", "rain", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("snow-squalls", "snow squalls", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("avalance", "avalanche", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("squalls", "squall", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("hvy", "heavy", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("landslides", "landslide", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("snowfall", "snow", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("lighting", "lightning", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("precipitationitation", "rain", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("precip", "rain", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("slides", "slide", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("currents", "current", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("storms", "storm", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("thuderstorm", "thunderstorm", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("thundeerstorm", "thunderstorm", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("thunderestorm", "thunderstorm", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("trees", "tree", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("wins", "wind", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("thunderstormw", "thunderstorm wind", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("thunderstormwinds", "thunderstorm wind", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("thunderstormwind", "thunderstorm wind", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("thundertorm", "thunderstorm", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("thunerstorm", "thunderstorm", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("tornadoes", "tornado", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("torndao", "tornado", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("tunderstorm", "thunderstorm", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("unseasonable", "unseasonably", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("fld", "flood", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("floodin", "flood", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("sml", "small", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("windchill", "wind chill", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("coastalstorm", "coastal storm", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("excessive", "heavy", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("extreme", "heavy", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("ice on road", "icy roads", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("ice roads", "icy roads", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("lake effect", "lake-effect", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("lakeshore", "lake", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("ligntning", "lightning", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("mudslide", "mud slide", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("non thunderstorm", "non-thunderstorm", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("severe", "heavy", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("small", "light", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("rainfall", "rain", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("shower", "rain", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("extreme", "heavy", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("extreme", "heavy", data_sub2$EVTYPE)

data_sub2$EVTYPE <- as.factor(data_sub2$EVTYPE)
```

Afterwards I replace/remove special characters. The most important aspect here 
is how to link different event types. E.g. "rain and flood" vs. "rain/flood".
I have decided to use " / " to link multiple event types. E.g. "rain / flood".

Also I have decided to treat event types with multiple events as separate events
types, instead of attributing the damage to each single one or splitting it. The
reason is that splitting would be arbitrary and counting damage twice will skew 
the data.
```{r}
data_sub2$EVTYPE <- as.character(data_sub2$EVTYPE)

data_sub2$EVTYPE <- gsub("\\?", "other", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub(" and ", " / ", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("[./-]$", "", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("/", " / ", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("   ", " ", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("  ", " ", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub(" and ", " / ", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub(" and$", "", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("\\&", "/", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub(" - ", " / ", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub(", ", " / ", data_sub2$EVTYPE)

data_sub2$EVTYPE <- as.factor(data_sub2$EVTYPE)
```


Next I'm removing all names and indicators of intensity.
```{r}
data_sub2$EVTYPE <- as.character(data_sub2$EVTYPE)

data_sub2$EVTYPE <- gsub(" 0.75| 075| 100| 125| 150| 175| 200| 275| 450| 75|damage| (g40)| 48| edouard| emily| erin| felix| gordon| opal| accident| mishap| (41)| (g35)| (g40)| (g45)| / awning| / tree| 13| 40| 45| 55$| 60 mph| 63 mph| 65 mph| 65)| 65mph| 98 mph| g45| g50| g52| g55| g58| g60| tree| windind| f0| f1| f2| f3| alberto| dean| gordon| jerry", 
                         "", data_sub2$EVTYPE)

data_sub2$EVTYPE <- as.factor(data_sub2$EVTYPE)
```


As a last step I am combining different events that should be in the same group
according to the data documentation, which specifies 48 unique event types.

I group everything that does not fall into one of these 48 event types into
"other".

Blizzard
```{r}
data_sub2$EVTYPE <- gsub("blizzard / winter storm|ground blizzard", 
                         "blizzard", data_sub2$EVTYPE)
```

Coastal Flood
```{r}
data_sub2$EVTYPE <- gsub("coastal erosion|astronomical high tide|coastal flood / erosion|coastal surge|erosion / coastal flood|high tides|high water|tidal flood", 
                         "coastal flood", data_sub2$EVTYPE)
```

Cold / Wind Chill
```{r}
data_sub2$EVTYPE <- gsub("cold / snow|cold / wet conditions|cold temperature|cold wave|cold weather|cool / wet|hypothermia|hypothermia / exposure|low temperature|bitter cold|unseasonably cold",
                         "cold / wind chill", data_sub2$EVTYPE)
```

Debris Flow
```{r}
data_sub2$EVTYPE <- gsub("landslide|mud slide urban flood|mud slide|rock slide", 
                         "debris flow", data_sub2$EVTYPE)
```

Dense Fog
```{r}
data_sub2$EVTYPE <- gsub("fog", "dense fog", data_sub2$EVTYPE)
```

Excessive Heat
```{r}
data_sub2$EVTYPE <- gsub("heavy heat|record / heavy heat|record heat", 
                         "excessive heat", data_sub2$EVTYPE)
```

Extreme Cold / Wind Chill
```{r}
data_sub2$EVTYPE <- gsub("extended cold|heavy wind chill|record cold", 
                         "extreme cold / wind chill", data_sub2$EVTYPE)
```

Flash Flood
```{r}
data_sub2$EVTYPE <- gsub("dam break|flash flood / street|flash flood from ice jams|flash flood wind|flood flash|flood / flash|ice jam flood|ice jam|ice floes|flash flood (minor",
                         "flash flood", data_sub2$EVTYPE)
```

Flood
```{r}
data_sub2$EVTYPE <- gsub("breakup flood|flood / river flood|light stream flood|major flood|minor flood|river / stream flood|river flood|rural flood|snowmelt flood|urban / light stream flood|urban flood|urban light|urban / light stream|urban / light",
                         "flood", data_sub2$EVTYPE)
```

Freezing Fog
```{r}
data_sub2$EVTYPE <- gsub("glaze ice|glaze / ice storm|glaze|freezing dense fog", 
                         "freezing fog", data_sub2$EVTYPE)
```

Frost / Freeze
```{r}
data_sub2$EVTYPE <- gsub("black ice|damaging freeze|early frost|hard freeze|icy roads", 
                         "frost / freeze", data_sub2$EVTYPE)
```

Hail
```{r}
data_sub2$EVTYPE <- gsub("hailstorm|light hail", 
                         "hail", data_sub2$EVTYPE)
```

Heat
```{r}
data_sub2$EVTYPE <- gsub("heat wave|unseasonably warm / dry|unseasonably warm|warm weather", 
                         "heat", data_sub2$EVTYPE)
```

Heavy Rain
```{r}
data_sub2$EVTYPE <- gsub("raintorm|record rainfall|torrential rainfall|unseasonal rain", 
                         "heavy rain", data_sub2$EVTYPE)
```

Heavy Snow
```{r}
data_sub2$EVTYPE <- gsub("falling snow / ice|heavy snow shower|heavy snow squall|heavy snowpack|record snow|snow / blowing snow|snow accumulation|snow squall|thundersnow", 
                         "heavy snow", data_sub2$EVTYPE)
```

High Surf
```{r}
data_sub2$EVTYPE <- gsub("beach erosion|hazardous surf|heavy surf|heavy swells|high surf advisory|high swells|high wave|rough surf", 
                         "high surf", data_sub2$EVTYPE)
```

High Wind
```{r}
data_sub2$EVTYPE <- gsub("high wind (g40)", 
                         "high wind", data_sub2$EVTYPE)
```

Hurricane / Typhoon
```{r}
data_sub2$EVTYPE <- gsub("hurricane|hurricane-generated swells", 
                         "hurricane / typhoon", data_sub2$EVTYPE)
```

Lakeshore Flood
```{r}
data_sub2$EVTYPE <- gsub("lake flood", 
                         "lakeshore flood", data_sub2$EVTYPE)
```

Lake-Effect Snow
```{r}
data_sub2$EVTYPE <- gsub("heavy lake snow",
                         "lake-effect snow", data_sub2$EVTYPE)
```

Lightning
```{r}
data_sub2$EVTYPE <- gsub("lightning fire|lightning wauseon|lightning injury", 
                         "lightning", data_sub2$EVTYPE)
```

Storm Tide
```{r}
data_sub2$EVTYPE <- gsub("storm surge|storm surge / tide", 
                         "storm tide", data_sub2$EVTYPE)
```

Strong Wind
```{r}
data_sub2$EVTYPE <- gsub("gusty wind", 
                         "strong wind", data_sub2$EVTYPE)
```

Thunderstorm Wind
```{r}
data_sub2$EVTYPE <- gsub("downburst|dry microburst|dry mircoburst wind|gustnado|microburst|microburst wind|wet microburst|whirlwind|thunderstorm wind 55", 
                         "thunderstorm wind", data_sub2$EVTYPE)
```

Tornado
```{r}
data_sub2$EVTYPE <- gsub("cold air tornado|landspout", 
                         "tornado", data_sub2$EVTYPE)
```

Tropical Depression
```{r}
data_sub2$EVTYPE <- gsub("gradient wind", 
                         "tropical depression", data_sub2$EVTYPE)
```

Tropical Storm
```{r}
data_sub2$EVTYPE <- gsub("coastal storm", 
                         "tropical storm", data_sub2$EVTYPE)
```

Wildfire
```{r}
data_sub2$EVTYPE <- gsub("brush fire|forest fire|grass fire|wild / forest fire|wild fire", 
                         "wildfire", data_sub2$EVTYPE)
```

Winter Storm
```{r}
data_sub2$EVTYPE <- gsub("heavy snow / strong wind|heavy snow / wind",
                         "winter storm", data_sub2$EVTYPE)
```

Winter Weather
```{r}
data_sub2$EVTYPE <- gsub("freezing drizzle|freezing rain / sleet| freezing rain / snow|freezing rain|freezing spray|light snow|winter weather / mix|winter weather mix|wintry mix", 
                         "winter weather", data_sub2$EVTYPE)
```

Other & Multi Events
```{r}
data_sub2$EVTYPE <- gsub("agricultural freeze|apache county|blowing dust|blowing snow|heavy mix| / heavy weather|/ light stream urban|heavy seas| / squall|heavy turbulence|heavy wetness|high seas|landslump|late season snow|non-heavy wind damage|non-thunderstorm wind|rapidly rising water|rogue wave|rough seas|storm force wind|drowning", 
                         "other", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("dust devil waterspout", 
                         "dust devil / waterspout", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("flash flood debris flow", 
                         "flash flood / debris flow", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("flood / flash flood|flood / flashflood", 
                         "flash flood / flood", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("flood / rain / wind|flood and heavy rain", 
                         "flood / heavy rain", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("lightning thunderstorm wind", 
                         "lightning / thunderstorm wind", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("rain / snow", 
                         "heavy rain / heavy snow", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("rain / wind", 
                         "heavy rain / strong wind", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("waterspout tornado|waterspout-tornado", 
                         "waterspout / tornado", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("winter storm high wind", 
                         "winter storm / high wind", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("hail / wind", 
                         "hail / strong wind", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("heat drought", 
                         "drought / heat", data_sub2$EVTYPE)
data_sub2$EVTYPE <- gsub("high wind heavy rain", 
                         "high wind / heavy rain", data_sub2$EVTYPE)


data_sub2$EVTYPE <- as.factor(data_sub2$EVTYPE)
```




```{r}
test <- table(data_sub2$EVTYPE)
write.csv(data_sub2$EVTYPE, "evtypes5.csv")
```


test <- table(data_sub2$EVTYPE)
```






```{r}
table(data_sub2$CROPDMGEXP)
table(data_sub2$PROPDMGEXP)
```

```{r}
head(data)
tail(data)
names(data)
str(data)
lapply(data_sub, class)
```

# Results

The results are split in two parts, one looking at the impact of severe weather
events on human health, the other part looking at economic consequences.

## Health Impact

Impact on human health is measured by two variables in the data: One for 
fatalities and one for injuries.

```{r}
mean_fat <- round(tapply(data_sub2$FATALITIES, data_sub2$EVTYPE, mean, na.rm=TRUE))



order(mean_fat, decreasing = TRUE)
str(mean_fat)
mean_fat
df <- data.frame(mean_fat)
df_new <- df[order(df$mean_fat),]
df_new
write.csv(df_new, "evtypes.csv")
table(mean_fat)


```
















## Economics Impact