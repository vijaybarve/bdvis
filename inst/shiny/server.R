function(input, output) {

  observeEvent(input$go, {

    species_data <- reactive({
      withProgress(message = 'Download data', value = 0, {
        data_obtained <- rgbif::occ_search(scientificName = input$query, limit = input$limit)
        setProgress(0.45, detail = paste("Formatting and plotting"))
        data_obtained <- format_bdvis(data_obtained$data, "rgbif")
        setProgress(1.0, detail = paste("Finished"))
        data_obtained
      })
    })

    output$mapgrid <- renderPlot({
      mapgrid(species_data(), ptype = "species")
    })

    output$temporal <- renderPlot({
      tempolar(species_data(), color = "blue", plottype = "r")
    })

    output$distrigraph <- renderPlot({
      distrigraph(species_data(), ptype="cell",col="tomato")
    })

    output$bdcalendarheat <- renderPlot({
      bdcalendarheat(species_data())
    })

  }
  )}
