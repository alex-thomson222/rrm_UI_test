
select_area_tab <- tabPanel(title="Select Area",
                            fluidRow(htmlOutput("start_up")),
                            fluidRow(
                              column(width=6,textInput("polygon_name", label = "Project Name", value = "new_project",width = '50%')),
                              column(width=6,selectInput("method1","Choose selection method", width = '50%',
                                                         choices=c("Draw Outline"="draw","Circle Around Point"="buffer",
                                                                   "Select administrative areas"="adm","Upload shape file"="upload")))),
                            br(),
                            
                            fluidRow(
                              column(width = 8,
                                     box(title = "Project Area",
                                         withSpinner(leafletOutput("map",height = 600)),
                                         width = NULL)),
                              column(width = 4,
                                     box(width = NULL,
                                         title = "Validate Project Area",
                                         conditionalPanel("input.method1 == 'draw'",
                                                          actionButton("undo",label="Undo",width = '50%')),
                                         actionButton("reset",label="Reset",width = '50%'),
                                         checkboxInput("lakes","Remove lakes",value=TRUE),
                                         checkboxInput("borders","Remove area outside of national border",value=TRUE),
                                         fluidRow(
                                           column(width = 1),
                                           actionButton(width = '80%',"validate", "Validate ShapeFile", icon = icon("vector-square"),
                                                        style = "color: white; background-color: red;")),
                                         conditionalPanel("input.validate!='0'",
                                                          fluidRow(htmlOutput("error_message"))))
                              )
                              
                            ),
                            
                            class='active')

data_tab<-tabItem(
  title = "Variable Summary",
                  class='active',
                  selectInput("variables","Select variable to explore",choices = c("Fire" = "fire", "Population" = "pop")),
                  selectInput("colour_type","Visualise Data As",
                              choices = c("Values"="values","Percentiles"="quantiles")),
                  fluidRow(
                    column(width = 6,
                           
                           box(title = "Summary Table",
                               withSpinner(gt::gt_output("SummaryTable")), width = NULL, height = 300),
                           tabBox(id = "data_tab_plots",title = "Summary Plots",
                                  selected = "p1",
                                  side = "left",
                                  height = 500,
                                  width = NULL,
                                  tabPanel("Regional Barplot", value = "p1", withSpinner(plotlyOutput("SummaryPlot2"))),
                                  tabPanel("Regional Boxplot", value = "p2", withSpinner(plotlyOutput("SummaryPlot3"))),
                                  tabPanel("District Histogram", value = "p3", withSpinner(plotlyOutput("SummaryPlot"))),
                                  tabPanel("District Pointplot", value = "p4", withSpinner(plotlyOutput("SummaryPlot4")))
                           )),
                    
                    column(width = 6,
                           tabBox(selected = "District",
                                  title = "Summary Map",
                                  side = "left",
                                  height = 750,
                                  width = NULL,
                                  tabPanel("District", withSpinner(leafletOutput("SummaryMap", height = 745)))
                                  #,
                                  # tabPanel("Region", withSpinner(leafletOutput("SummaryMap2", height = 745))))
                           )
                    ),
                  ),
                  fluidRow(
                    column(width = 1),
                    column(width = 10,
                           box(htmlOutput("SummaryText"), width = NULL)),
                    column(width = 1)
                  )
)

help_tab<-tabPanel(title="Help",
                  class='active',
                  htmlOutput("help"),
                  gt_output("Status"))


area_summary_tab<-tabPanel(title="Project Area Characteristics",
                          fluidRow(htmlOutput("area_summary_header")),
                          br(),
                          fluidRow(
                            box(
                              title = "Shapefile Download", width = 2,
                              downloadButton("downloadData", "Download Shape File"))),
                          br(),
                          fluidRow( box(
                            title = "Project Area Summary",
                            selectInput("level","Summary level",
                                        choices = c("National"="adm0","Regional"="adm1","District"="adm2")),
                            DT::DTOutput("table"),
                            width = 12)),
                          fluidRow( column(width = 12,
                                           box(
                                             title = "Project Area Map",
                                             leafletOutput("map_summary",height = 600),
                                             width = NULL))),
                          br(),
                          fluidRow(box( title = "Land Use Treemap",
                                                         plotOutput("landuse_plot", height = 800),
                                                         width = 7),
                                                    box(title = "Land Use Table",
                                                        gt::gt_output("landuse_table"),
                                                        width = 5, height = 800),
                          ),
                          
                          br())


summary_tab<-tabPanel(title="Data Summary",
                     class='active',
                     box(
                       selectInput("variables2","Select variable to explore",choices = c("Fire" = "fire", "Population" = "pop")),
                       selectInput("comparison","Compare results to:",choices = c("Whole Country"="ctry",
                                                                                  "Region(s) overlapping with selected area"="region_over",
                                                                                  "District(s) overlapping with selected area"="district_over",
                                                                                  "Village(s) overlapping with selected area"="village_over",
                                                                                  "Specific Region(s)"="region",
                                                                                  "Specific District(s)"="district",
                                                                                  "Specific Village(s)"="village")),
                       actionButton("calculate","Produce summaries of variables"),
                       htmlOutput("AreaWarning"),
                       width=12),
                     fluidRow(
                       column(width = 6,
                              box(title = "Summary Table",
                                  withSpinner(gt::gt_output("AreaTable")), width = NULL, height = 300),
                              tabBox(selected = "District Histogram",
                                     title = "Summary Plot",
                                     side = "left",
                                     width = NULL,
                                     tabPanel("District Histogram",withSpinner(plotlyOutput("AreaPlot")), width = NULL, height = 400)
                                     #,
                                     # tabPanel("Area Barplot",withSpinner(plotlyOutput("AreaPlot2")), width = NULL, height = 400)
                              )
                       ),
                       column(width = 6,
                              tabBox(selected = "Comparison Area",
                                     title = "Summary Map",
                                     side = "left",
                                     height = 750,
                                     width = NULL,
                                     # tabPanel("Project Area", withSpinner(leafletOutput("AreaMap", height = 650))),
                                     tabPanel("Comparison Area", withSpinner(leafletOutput("AreaMap2", height = 650))))
                       )),
                     fluidRow(
                       column(width = 1),
                       column(width = 10, 
                              box(htmlOutput("AreaText"), width = NULL)),
                       column(width = 1)
                     )
)


model_tab<-tabPanel(title="Run Model",
                   class='active',
                   #fileInput("shape_file", "Upload cleaned shape file", accept=c('.shp','.dbf','.sbn','.sbx','.shx',".prj"), multiple=TRUE),
                   #fileInput("model_inputs", "Upload model inputs", accept=c('.csv'), multiple=TRUE),
                   selectInput("parameters","Select risk/reward parameters",
                               choices=c("A","B","C"),
                               selected=c("A","B","C"),multiple=TRUE, width = '50%'),
                   actionButton("run","Run model"),
                                    htmlOutput("kill"),
                   actionButton("save_model","Save changes to model online"),
                                    textOutput("response"),
                                    fluidRow(box(span(textOutput("Risk"),style = "font-size:20px"),width=4,status="danger"),
                                             box(span(textOutput("Reward"),style = "font-size:20px"),width=4,status="success"),width=6),
                                    selectInput("ColourScheme",lab="Colour Scheme",c("Traffic Lights"="RdYlGn","Risk: Red; Reward: Green"="RedsGreens")),
                                    #    fluidRow(plotOutput("headlinePlot"),width=11),
                                    fluidRow(box(withSpinner(plotOutput("ResultsPlot",height = "600px")),width=12),width=12),
                                    fluidRow(box(withSpinner(gt_output("ResultsTable")), width = 12), width = 12))

report_tab <- tabPanel(title = "Download Summaries",
                      class = "active",
                      fluidRow(HTML("Previously Generated Reports"),
                               column(gt::gt_output("existing_reports"),width=10),
                      ),
                      downloadButton("downloadData2", "Download Excel Summary"),
                      htmlOutput("kill2"))


report_tab2 <- tabPanel(title = "Customise Report",
  selectInput("report_vars", "Select variables to include in report",
                                                   choices = c("Fire" = "fire", "Population" = "pop"),
                                                   multiple = TRUE),
                                       selectInput("comparison_report","Compare results to:",choices = c("Whole Country"="ctry",
                                                                                                         "Region(s) overlapping with selected area"="region_over",
                                                                                                         "District(s) overlapping with selected area"="district_over",
                                                                                                         "Village(s) overlapping with selected area"="village_over",
                                                                                                         "Specific Region(s)"="region",
                                                                                                         "Specific District(s)"="district",
                                                                                                         "Specific Village(s)"="village")),
                                       selectInput("vis_report", "Visualise as:",
                                                   choices = c("Map" = "map", "Plot" = "plot", "Table only" = "table"),
                                                   selected = "tbl"),
                                       selectInput("report_format", "Format of report:",
                                                   choices = c("HTML"= "html", "PDF" = "pdf", "Word" = "docx")),
                                       actionButton("confirm_report", "Confirm report options"),
                                       textOutput("long_render"),
                                                        actionButton("report", "Generate Report"),
                                                        downloadButton("downloadReport", "Download Report")
                      )