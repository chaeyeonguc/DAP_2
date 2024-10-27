[Shinyapp](https://chaeyeong.shinyapps.io/PublicSchoolsApp/)

# Load packages
library(tidyverse)
library(dplyr)
library(ggplot2)
library(sf)
library(shiny)
library(shinyFeedback)
library(plotly)

# Define ui
ui <- fluidPage(
  titlePanel("Location of Public Schools by Safety Scores in Chicago"),
  sidebarLayout(
    sidebarPanel(
      textInput(
        inputId = "safety_input",
        label = "Enter safety score and I will show you public schools over it",
        value = 0
      ),
      selectInput(inputId = "school_input", label = "School", choices = NULL)
    ),
    mainPanel(
      plotlyOutput("school_plot")
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  public_schools <- read_csv("Chicago_Public_Schools_-_Progress_Report_Cards__2011-2012__20241025.csv")
  zip_codes <- st_read("geo_export_fb313970-5c89-4a00-8f7c-2f7e7ca8255d.shp")
  public_schools <- public_schools %>%
    select(`Safety Score`, `Name of School`, LONGITUDE, LATITUDE)
  public_schools_sf <- st_as_sf(public_schools, coords = c("LONGITUDE", "LATITUDE"), crs = st_crs(zip_codes), remove = FALSE)
  public_schools_sf <- filter(public_schools_sf, !is.na(`Safety Score`))


  ## Subset based on user-inputted safety score
  public_schools_sf_updated <- reactive({
    public_schools_sf %>% filter(`Safety Score` >= as.numeric(input$safety_input))
  })

  ## call the resulting dataframe public_schools_sf_updated
  observeEvent(public_schools_sf_updated(), {
    school_choices <- unique(public_schools_sf_updated()$`Name of School`)
    updateSelectInput(inputId = "school_input", choices = school_choices)
  })

  ## Render the plot
  output$school_plot <- renderPlotly({
    ggplot() +
      geom_sf(data = zip_codes) +
      geom_sf(
        data = public_schools_sf_updated() %>% filter(`Name of School` == input$school_input),
        aes(fill = `Safety Score`), shape = 21, size = 2
      ) +
      scale_fill_gradient(low = "white", high = "blue") +
      labs(
        title = "Public Schools by Safety Scores in Chicago",
        x = "Longitude", y = "Latitude",
        fill = "Safety Score",
        caption = "Source: City of Chicago"
      ) +
      theme_minimal()
  })
}

# Run the app
shinyApp(ui = ui, server = server)
