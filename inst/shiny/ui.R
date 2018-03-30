navbarPage("BDVis",
           tabPanel("Species Density Map",
                    sidebarLayout(
                      sidebarPanel(
                        textInput("query", "Query", "Add query"),
                        numericInput("limit", "Query imit", 100, min = 1, max = 10000),
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
