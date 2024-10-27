Chaeyeong Park

Date Created: 10/26/2024

Date Modified: 10/26/2024

Required R packages: tidyverse, dplyr, ggplot2, sf, shiny, lubridate, styler, plotly, shinyFeedback

Version of R used: 2023-03-15 (Version 4.2.3)

Summary of code: question_2.R loads the two datasets (.csv) and one shapefile: public_schools, speed_cameras, and zip_codes. Data wrangling was involved for the speed_cameras dataset to change the date format accordingly for further plotting analysis. After converting the .csv to sf files, I created two choropleths by combining each file with the shape file to indicate all locations of public schools and speed cameras in Chicago. Each choropleth is committed to the current repository by .png file.

app.R shows a [shinyapp](https://chaeyeong.shinyapps.io/PublicSchoolsApp/) for the public schools in Chicago, which is converted from the plot "Location of Public Schools by Safety Scores and School Name in Chicago." The UI consists of a dynamic input, which additionally allows users to select school names as well as safety scores. After entering a safety score, the school dropdown shows a list of public schools over that safety score, such that the plot interactively presents a specific location of the public school by safety score and school name.  

Note:The functions and plots created in question_2.R are as follows:

converting_to_sf: A function to convert the .csv files to sf files

choropleth_public_schools: a choropleth indicating the location of public schools by safety scores in Chicago. NA values in the "Safety.Score" variable were filtered out to show clear visualization. The x axis is 

choropleth_speed_cameras: a choropleth indicating the location of speed cameras by Years Active in Chicago. 
The variable "years_active" was created to calculate each speed camera's duration since GO.LIVE.DATE in years.

The R file should be run in order from top to bottom. Note that the current directory in R needs to be set to the directory containing the problem-set-2-chaeyeonguc folder.

Explanation of original data source: The original two datasets and one shapefile in question2.R were directly downloaded from the from the City of Chicago [Data Portal](https://data.cityofchicago.org).
For specific paths, public_school.csv is exported from (https://data.cityofchicago.org/Education/Chicago-Public-Schools-Progress-Report-Cards-2011-/9xs2-f89t/about_data),
speed_cameras.csv is exported from (https://data.cityofchicago.org/Transportation/Speed-Camera-Locations/4i42-qv3h/about_data),
and Boundaries - ZIP Codes.zip  is exported from (https://data.cityofchicago.org/Facilities-Geographic-Boundaries/Boundaries-ZIP-Codes/gdcf-axmw)

The file labeled "public_schools" is a .csv file containing various information about Chicago's public schools, including locations, zip codes, latitude/longitude, and safety scores.

The file labeled "speed_cameras" is .csv file containing information about speed cameras in Chicago, including each camera's location, longitude/langitude and "GO-Live dates" which indicates when each speed camera started to be active.

The file labeled "zip_codes" is created by unzipping Boundaries - ZIP Codes.zip and the loading .shp one.
