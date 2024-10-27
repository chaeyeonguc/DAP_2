library(tidyverse)
library(dplyr)
library(ggplot2)
library(sf)
library(lubridate)
library(styler)
style_file("/Users/yeong/Documents/GitHub/problem-set-2-chaeyeonguc/question_2.R")

# Question 2
## Load downloaded datasets and shapefile
public_schools <- read.csv("/Users/yeong/Documents/GitHub/problem-set-2-chaeyeonguc/Chicago_Public_Schools_-_Progress_Report_Cards__2011-2012__20241025.csv")
speed_cameras <- read.csv("/Users/yeong/Documents/GitHub/problem-set-2-chaeyeonguc/Speed_Camera_Locations_20241025.csv")
zippath <- "/Users/yeong/Documents/GitHub/problem-set-2-chaeyeonguc"
zipF <- paste0(zippath, "Boundaries - ZIP Codes.zip")
unzip(zipF, exdir = zippath)
zip_codes <- st_read(file.path(
  zippath,
  "geo_export_fb313970-5c89-4a00-8f7c-2f7e7ca8255d.shp"
))

## data wrangling: change the date format correctly
speed_cameras <- speed_cameras %>%
  mutate(
    GO.LIVE.DATE = as.Date(GO.LIVE.DATE,
      format = "%m/%d/%Y"
    ),
    GO.LIVE.DATE = if_else(year(GO.LIVE.DATE) < 100,
      update(GO.LIVE.DATE, year = year(GO.LIVE.DATE) + 2000),
      GO.LIVE.DATE
    )
  )

## Converting the two datasets to sf
converting_to_sf <- function(df, longitude = "LONGITUDE", latitude = "LATITUDE", crs = st_crs(zip_codes)) {
  ### Defining a Geometry set
  geometry <- st_sfc(lapply(1:nrow(df), function(i) {
    st_point(c(df[[longitude]][i], df[[latitude]][i]))
  }), crs = crs)

  ### Converting to sf
  sf_object <- st_sf(df, geometry = geometry)
  return(sf_object)
}

public_schools_sf <- converting_to_sf(public_schools)
speed_cameras_sf <- converting_to_sf(speed_cameras)

print(public_schools_sf)
print(speed_cameras_sf)

## Creating a choropleth for public schools
### Filtering NA observations in the variable to be filled
public_schools_sf <- public_schools_sf %>%
  filter(!is.na(Safety.Score))

### Creating a choropleth combined with the shapefile
choropleth_public_schools <- ggplot() +
  geom_sf(data = zip_codes) +
  geom_sf(data = public_schools_sf, aes(fill = Safety.Score), shape = 21, size = 2) +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(
    title = "Location of Public Schools by Safety Scores in Chicago",
    fill = "Safety Score",
    x = "Longitude", y = "Latitude",
    caption = "Source: the City of Chicago"
  ) +
  theme_minimal()

### Saving as .png file
ggsave("choropleth_public_schools.png", path = getwd(), plot = choropleth_public_schools, width = 10, height = 9, dpi = 300)

## Creating a chorpleth for speed cameras
### Creating new variable for the duration since GO.LIVE.DATE in years
speed_cameras_sf <- speed_cameras_sf %>%
  mutate(
    years_active = interval(GO.LIVE.DATE, Sys.Date()) %>%
      time_length(unit = "year")
  )

### Creating a choropleth combined with the shapefile
choropleth_speed_cameras <- ggplot() +
  geom_sf(data = zip_codes) +
  geom_sf(data = speed_cameras_sf, aes(fill = years_active), shape = 21, size = 3) +
  scale_fill_gradient(low = "white", high = "red") +
  labs(
    title = "Location of Speed Cameras by Years Active in Chicago",
    x = "Longitude", y = "Latitude",
    fill = "Years Active",
    caption = "Source: City of Chicago"
  ) +
  theme_minimal()

### Saving as .png file
ggsave("choropleth_speed_cameras.png", path = getwd(), plot = choropleth_speed_cameras, width = 10, height = 9, dpi = 300)
