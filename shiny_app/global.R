#antData <- read.csv("~/GitHub/antweb/shiny_app/data/antData.csv", stringsAsFactors=FALSE)
#antData <- antData[is.na(antData$decimal_latitude)==FALSE,]
#antData$latitude <- jitter(antData$decimal_latitude)
#antData$longitude <- jitter(antData$decimal_longitude)

#antData <- antData[c("subfamily","genus","scientific_name","country","latitude","longitude")]

grid <- read.csv("~/GitHub/antweb/data/grid.csv", stringsAsFactors=FALSE)
grid <- grid[is.na(grid$numRecords)==FALSE,]
grid$latitude <- grid$lat
grid$longitude <- grid$lon
grid <- grid[colnames(grid)!="lon"& colnames(grid)!="lat"]
