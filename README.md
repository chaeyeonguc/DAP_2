# Data Skills 2 - R
## Fall Quarter 2024

## Homework 2
## Due: October 26 before midnight on Gradescope

__Question 1 (10%):__ Complete the final project quiz on Canvas.  Note that your ideas can evolve as we approach the project presentations.

__Question 2 (40%):__ For this question, you will be using the City of Chicago [Data Portal](https://data.cityofchicago.org) to create a choropleth using the ggplot and sf libraries.  You should:
  * Download two [datasets](https://data.cityofchicago.org/browse?limitTo=datasets) that interest you
  * Download one or more [shapefiles](https://data.cityofchicago.org/browse?tags=shapefiles)

At a minimum you should use the "fill" aes in ggplot to color based on your selected data, but you are free to use others as well. 

Effort to improve the appearance of your plots relative to the default will be rewarded, as will proper usage of tidyverse style, and loops/containers/functions should they be appropriate for your code.

Save this code as "question_2.R", and include your downloads from the Data Portal in your repo.  Save your choropleths as .png files and commit them as well.  Include 2-4 sentences in the README describing each specific choropleth is about. Also include in your README a description of the datasets and shapefile.

__Question 3 (40%):__ Using what you created for question 2, convert it into a Shiny app.  Allow at least two elements to be controlled in the UI.  For one of the elements, include either 1) a warning that checks for a condition and does not display the plot if the condition is not met or 2) a dynamic input where the second input changes depending on the first. Include in your README file a description of your warning or dynamic input.

Save this code as "app.R."

__Question 4 (10%):__ Create a free account on [shinyapps.io](https://www.shinyapps.io/) and upload your app.R file and data files from question 3 to it.  Check that the url it generates is working, and include the url to your Shiny app in a comment at the top of your app.R file.

General note: Mind the size of the data you pick, particularly the shapefiles.  If it becomes quite large you may have issues committing it to GitHub or uploading it to the shinyapps.io website, so lower resolution is generally preferred, and test the upload steps early.
