navbarPage("BDVis",
           tabPanel("Species Density Map",
                    sidebarLayout(
                      sidebarPanel(
                        textInput("query", "Scientific species name", ""),
                        numericInput("limit", "Maximum number of observations", 1000, min = 1, max = 10000),
                        actionButton("go", "Go")
                      ),
                      mainPanel(
                        plotOutput("mapgrid")
                      )
                    )
           ),
           tabPanel("Temporal Distribution",
                    plotOutput("temporal")),
           tabPanel("Distribution Graph",
                    plotOutput("distrigraph")),
           tabPanel("Calendar Heatmap",
                    plotOutput("bdcalendarheat"))
)
