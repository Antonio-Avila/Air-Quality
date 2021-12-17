# This app is meant to run as a dashboard for my Air Quality Index Dashboard. 

library(shiny)
library(tidyverse)
library(usmap)
library(plotly)


#------------- Begin by importing data and preprocessing 
ozone_texas <- read_csv("ozone_texas.csv")
ozone_texas["fips"] <- as.integer(ozone_texas$state_code) * 1000 + as.integer(ozone_texas$county_code)

# Define functions to calculate the 8-hour maximum as per EPA ozone standard.
avg_8hr <- function(data){
  avgs = matrix(nrow = 24-8, ncol = 1)
  for(i in 1:(24-8)) { 
    avgs[i] = mean(data[i:(i+7)], na.rm = TRUE)
  }
  return(avgs)
}

max_8hr_avg <- function(data){
  max_avg = max(avg_8hr(data)) * 1000
  max_avg = trunc(max_avg)
  return(max_avg)
}

daily_max_sites <- ozone_texas %>% 
  group_by(county, fips, site_number, date_local) %>% 
  summarize(max_8hr_avg = max_8hr_avg(sample_measurement))


daily_max_counties <- daily_max_sites %>%
  group_by(county, fips, date_local) %>% 
  summarise(county_max = max(max_8hr_avg, na.rm = TRUE))




# Define UI 
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

# Define server l
server <- function(input, output, session) {

}

# Run the application 
shinyApp(ui = ui, server = server)
