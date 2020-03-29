library("shiny")
library("shinyWidgets")

source("propublica.r")


about_page <- tabPanel("About",

  h3("Overview"),
  p("This assignment has us compile a list of the Congresssional
    representatives for our state in the House of Representatives,
    and then allow us to select an individual representative to get
    more information on them. Information included is political party,
    age, Twitter account, Facebook account, gender, and Congressional
    district. Phone numbers, office, and website information can be
    found as well."),
  p("This assignment also has a Summary Graphs information page. This
    page has two tabs, one showing data about state representatives gender,
    and the other shows data about state representatives political
    affiliation.Each has an explanation on what this data is about
    and can be adjusted for all 50 states."),
  p("For ease of access, the information used to make these visualizations
    can be found here:"),
  p(a("Link used to find information on House legislatures",
    href = "https://api.propublica.org/congress/v1/members/{chamber}/{state}/current.json")),
  p(a("Link used to find information on individual members",
    href = "https://api.propublica.org/congress/v1/members/{member}.json")),
  br(),

  h3("Affiliation"),
  p("Brian Darmitzel"),
  p("INFO 201A: Technical Foundations of Informatics"),
  p("The Information School"),
  p("University of Washington"),
  p("Autumn 2019"),
  br(),

  h3("Reflective Statement"),
  p("One of the most challenging aspects of this assignment was
    determining how to retrieve the correct data to show on our
    Shiny application, as well as how to present the data once it
    was recieved. Through this process we learned how to use our
    imagination and creativity to make the presentation of this
    data clean and user-friendly. Although the user may not notice,
    a large amount of work has gone into making this project
    presentable and informative for the viewers, something that
    may not be apparent at first glance. Through the process of
    completing this assignment, I have gained a fuller understanding
    of the important of front and back-end development to make an
    efficient product. And these are skills I will certainly carry
    with me to other professional fields and through life in general."),
)

query_page <- tabPanel("Search Representatives",
  sidebarLayout(

   sidebarPanel(
     htmlOutput("state_selector"),
     htmlOutput("rep_names")
   ),

   mainPanel(
     h3(textOutput("title1")),
     tableOutput("state_reps"),
     h3(textOutput("title2")),
     tableOutput("rep_info")
   )
  )
)

graphs_page <- navbarMenu("Summary Graphs",
  tabPanel("Representatives by Gender",
   sidebarLayout(
     sidebarPanel(
       pickerInput(
         choices = states,
         inputId  = "gender",
         label = "View Gender by State:",
         choicesOpt = list(
           disabled = states %in% states[c(1, 7, 14, 22, 35, 43, 51)]
         )
       )
     ),
     mainPanel(
       plotlyOutput("gender_plot"),
     )
   )
  ),
  tabPanel("Representatives by Party",
   sidebarLayout(
     sidebarPanel(
       pickerInput(
         choices = states,
         inputId  = "political",
         label = "View Political Affiliation by State:",
         choicesOpt = list(
           disabled = states %in% states[c(1, 7, 14, 22, 35, 43, 51)]
         )
       )
     ),
     mainPanel(
       plotlyOutput("political_plot"),
     )
   )
  )
)

ui <- fluidPage(
  navbarPage("INFO 201 A7 - Congressional Information",
   about_page,
   query_page,
   graphs_page
  )
)
