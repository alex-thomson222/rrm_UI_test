library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(tidyverse)
library(gt)
library(leaflet)
library(htmlwidgets)
library(shinycssloaders)
library(plotly)
library(DT)

source("dashboard_tab_items.R")

ui <- dashboardPage(skin="red",
                    header = dashboardHeader(title = "Risk Reward Models"),
                    sidebar = dashboardSidebar(
                      sidebarMenu(
                        menuItem("Model", tabName = "model"),
                        menuItem("Explore", tabName =  "explore"),
                        menuItem("Output", tabName = "output"),
                        menuItem("Data", tabName = "data"),
                        menuItem("Help", tabName = "help")
                      )),
                    body = dashboardBody(
                      tabItems(
                      tabItem(tabName = "model",class='active',
                        tabsetPanel(
                          select_area_tab,
                          tabPanel(title = "Model Inputs"),
                          model_tab
                        )),
                      tabItem(tabName = "explore",class='active',
                              tabsetPanel(
                                    area_summary_tab,
                                    summary_tab,
                                    tabPanel(title = "Risk Parameters")
                        )),
                      tabItem(tabName = "output",
                        tabsetPanel(
                                    report_tab,
                                    report_tab2
                        )),
                      tabItem(tabName = "data",class='active',
                        tabsetPanel(
                                    tabPanel(title = "Data Listing"),
                                    data_tab
                        )),
                        tabItem(tabName = "help",class='active',
                     help_tab)
                        )
                    )
                        
)

server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
    leaflet()%>%
      addProviderTiles("OpenStreetMap.HOT", group = "OSM (default)") %>%
      addProviderTiles("OpenTopoMap", group = "Topography") %>%
      addProviderTiles("Esri.WorldImagery", group = "World Imagery (satellite)")
    
  })
  
  output$error_message <- renderText({
    
    "Error"
    
  })
  
  output$SummaryTable <- render_gt({
    
    data.frame(A = c(1,2,3), B = c(4.22,5.66,9.21))%>%
      gt()
    
  })
  
  output$p1 <- renderPlotly({
    
    ggplot()
    
  })
  
  output$p2 <- renderPlotly({
    
    ggplot()
    
  })
  
  output$p3 <- renderPlotly({
    
    ggplot()
    
  })
  
  output$p4 <- renderPlotly({
    
    ggplot()
    
  })
  
  output$SummaryMap <- renderLeaflet({
    
    leaflet()%>%
      addProviderTiles("OpenStreetMap.HOT", group = "OSM (default)") %>%
      addProviderTiles("OpenTopoMap", group = "Topography") %>%
      addProviderTiles("Esri.WorldImagery", group = "World Imagery (satellite)")
    
  })
  
  output$SummaryText <- renderText({
    
    "Some text"
    
  })
  
  output$help<-renderText("In case of errors please contact sam@stats4sd.org")
  
  output$Status <- render_gt({
    
    data.frame(A = c(1,2,3), B = c(4.22,5.66,9.21))%>%
      gt()
    
  })
  
  output$table <- renderDT({
    
    data.frame(A = c(1,2,3), B = c(4.22,5.66,9.21))
    
  })
  
  output$map_summary <- renderLeaflet({
    
    leaflet()%>%
      addProviderTiles("OpenStreetMap.HOT", group = "OSM (default)") %>%
      addProviderTiles("OpenTopoMap", group = "Topography") %>%
      addProviderTiles("Esri.WorldImagery", group = "World Imagery (satellite)")
    
  })
  
  output$landuse_plot <- renderPlot({
    
    ggplot()
    
  })
  
  output$landuse_table <- render_gt({
    
    data.frame(A = c(1,2,3), B = c(4.22,5.66,9.21))%>%
      gt()
    
  })
  
  
  output$AreaTable <- render_gt({
    
    data.frame(A = c(1,2,3), B = c(4.22,5.66,9.21))%>%
      gt()
    
  })
  
  output$AreaPlot <- renderPlot({
    
    ggplot()
    
  })
  
  output$AreaMap2 <- renderLeaflet({
    
    leaflet()%>%
      addProviderTiles("OpenStreetMap.HOT", group = "OSM (default)") %>%
      addProviderTiles("OpenTopoMap", group = "Topography") %>%
      addProviderTiles("Esri.WorldImagery", group = "World Imagery (satellite)")
    
  })
  
  output$AreaText <- renderText({
    
    "Some text"
    
  })
  
  
  output$kill <- renderText({
    
    "Some text"
    
  })
  
  output$Risk <- renderText({
    
    "32%"
    
  })
  
  output$Reward <- renderText({
    
    "32%"
    
  })
  
  output$ResultsPlot <- renderPlot({
    
    ggplot()
    
  })
  
  output$ResultsTable <- render_gt({
    
    data.frame(A = c(1,2,3), B = c(4.22,5.66,9.21))%>%
      gt()
    
  })
  
  output$kill2 <- renderText({
    
    "Some text"
    
  })
  
  output$long_render <- renderText({
    
    "Some text"
    
  })
  
  output$existing_reports <- render_gt({
    
    data.frame(A = c(1,2,3), B = c(4.22,5.66,9.21))%>%
      gt()
    
  })
  
  
}



shinyApp(ui, server)