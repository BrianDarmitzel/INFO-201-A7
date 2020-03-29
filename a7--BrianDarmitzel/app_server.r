source("propublica.r")

server <- function(input, output) {

  #####

  # Select States to show Representatives
  output$state_selector <- renderUI({
    pickerInput(
      inputId = "state",
      label = "Select a State:",
      choices = states,
      multiple = F,
      choicesOpt = list(
        disabled = states %in% states[c(1, 7, 14, 22, 35, 43, 51)]
      )
    )
  })

  # Select individual Representatives
  output$rep_names <- renderUI({
    data <- full_to_abb(input$state)

    selectInput(inputId = "name",
                label = "Select a Representative:",
                choices = get_rep_names(data))
  })

  # Render table of representatives
  output$state_reps <- renderTable({
    state_house("house", full_to_abb(input$state))
  })

  # Render table of individual rep info
  output$rep_info <- renderTable({
    rep_data(input$name, full_to_abb(input$state))
  })

  # Title for table of reps
  output$title1 <- renderText({
    paste0("List of Representatives from ", input$state)
  })

  # Title for individual rep
  output$title2 <- renderText({
    paste0("Selected Representative: ", input$name)
  })

  #####

  # Create summary plot of Gender
  output$gender_plot <- renderPlotly({
    graph_gender(full_to_abb(input$gender))
  })

  # Create summary plot of Gender
  output$political_plot <- renderPlotly({
    graph_party(full_to_abb(input$political))
  })
}
