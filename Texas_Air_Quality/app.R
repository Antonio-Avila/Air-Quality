# This app is meant to run as a dashboard for my Air Quality Index Dashboard. 

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  titlePanel("Texas Air Quality"),
  sidebarPanel(
    helpText("The dashboard is meant to display the levels of select pollutants in Texas in a heat map to determine the severity,
             or safety(?), of the quality of air. By clicking on the tab above, it will display the trends for the last 4 years.
             Note, for ozone levels, it displays the 8-hour maximum over the day. In addition, due to the limited number of sites
             in Texas that collect air quality data, the majority of counties in Texas do not report pollutant levels."),
    
  selectInput("pollutant", h3("Select Pollutant"), choices = list("Ozone", "PM2.5"), selected = "Ozone"),
  dateInput("date", "Select Date", value = as.Date("2021-06-30"), min = as.Date("2017-09-01"), max = as.Date("2021-08-31")),
  sliderInput("date2", "Select Date",  value = as.Date("2021-06-30"), min = as.Date("2017-09-01"), max = as.Date("2021-08-31"))
  )

)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

}

# Run the application 
shinyApp(ui = ui, server = server)
