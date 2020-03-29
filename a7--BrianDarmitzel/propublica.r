library("httr")
library("jsonlite")
library("dplyr")
library("lubridate")
library("eeptools")
library("plotly")

source("propublica_key.R")

# List of all state abbreviations to use in rep_data function
states_abb <- c("NA", "WA", "OR", "CA", "AK", "HI", "NA", "NV", "ID", "UT",
                "AZ", "NM", "CO", "NA", "WY", "MT", "ND", "SD", "NE", "KS",
                "OK", "NA", "TX", "LA", "AR", "MO", "IA", "TN", "MS", "AL",
                "GA", "FL", "SC", "NC", "NA", "MN", "WI", "IL", "IN", "KY",
                "OH", "MI", "NA", "VA", "WV", "PA", "MD", "NY", "NJ", "DE",
                "NA", "CO", "RI", "MA", "VT", "NH", "ME")

# List of all state full names to display in UI
states <- c("--- Pacific ---", "Washington", "Oregon", "California",
            "Alaska", "Hawaii", "--- Rocky Mountains ---", "Nevada",
            "Idaho", "Utah", "Arizona", "New Mexico", "Colorado",
            "--- Great Plains ---", "Wyoming", "Montana", "North Dakota",
            "South Dakota", "Nebraska", "Kansas", "Oklahoma", "--- South ---",
            "Texas", "Louisiana", "Arkansas", "Missouri", "Iowa", "Tennessee",
            "Mississippi", "Alabama", "Georgia", "Florida", "South Carolina",
            "North Carolina", "--- Midwest ---", "Minnesota", "Wisconsin",
            "Illinois", "Indiana", "Kentucky", "Ohio",
            "Michigan", "--- Mid-Atlantic ---", "Virginia", "West Virginia",
            "Pennsylvania", "Maryland", "New York", "New Jersey", "Delaware",
            "--- New England ---", "Connecticut", "Rhode Island",
            "Massachusetts", "Vermont", "New Hampshire", "Maine")

# Convert full name states to abbreviations
abb_to_full <- function(abb) {
  states[states_abb == abb]
}

# Convert state abbreviations to full names
full_to_abb <- function(full) {
  states_abb[states == full]
}

# Data frame of all members of the house in a state
state_house <- function(chamber, state) {

  url <- paste("https://api.propublica.org/congress/v1/members/",
               chamber, "/", state, "/current.json", sep = "")

  fromJSON(content(GET(url, add_headers("X-API-Key" = api_key)),
  as = "text", encoding = "UTF-8"), flatten = TRUE) %>%
    data.frame() %>%
    select("results.id", "results.name", "results.party",
           "results.twitter_id", "results.facebook_account",
           "results.district", "results.gender") %>%
    rename("Rep ID" = results.id,
           "Rep Name" = results.name,
           "Party" = results.party,
           "Twitter ID" = results.twitter_id,
           "Facebook Account" = results.facebook_account,
           "District" = results.district,
           "Gender" = results.gender)
}

# Gets the names of all reps in a state to display in app
get_rep_names <- function(state) {
  rep_id <- state_house("house", state) %>%
    select(`Rep Name`)
}

# Calculate age of Representatives
calc_age <- function(dob) {
  as.integer((Sys.Date() - as.Date(dob)) / 365)
}

# Gets data on individual represpentatives in a state
rep_data <- function(name, state) {
  rep_id <- state_house("house", state) %>%
  filter(`Rep Name` == name) %>%
  pull(`Rep ID`)

  url <- paste("https://api.propublica.org/congress/v1/members/",
               rep_id, ".json ", sep = "")

  rep_df <- fromJSON(content(GET(url, add_headers("X-API-Key" = api_key)),
  as = "text", encoding = "UTF-8"), flatten = TRUE) %>% data.frame()

  result <- do.call(data.frame, rep_df) %>%
    filter(results.roles.congress == 116) %>%
    mutate(`Age` = calc_age(results.date_of_birth)) %>%
    select(Age, results.roles.phone, results.roles.office, results.url,
           results.current_party, results.roles.district) %>%
    rename("Phone" = results.roles.phone, "Office" = results.roles.office,
           "Website" = results.url,
           "Party" = results.current_party, "District" = results.roles.district)
}

# Graph function to summarise gender by each state
graph_gender <- function(state) {
  color_map <- c("Female" = "deeppink", "Male" = "deepskyblue")
  data <- state_house("house", state) %>%
    group_by(Gender) %>%
    summarize(Num = n())

  data$Gender[data$Gender == "F"] <- "Female"
  data$Gender[data$Gender == "M"] <- "Male"

  plot_ly(
    type = "bar",
    x = data$Gender,
    y = data$Num,
    marker = list(color = color_map[data$Gender],
                  line = list(color = "black", width = 1))) %>%
      layout(title = paste("Gender of House Representatives in",
                           abb_to_full(state)),
           xaxis = list(title = "Gender of Representatives"),
           yaxis = list(title = "Count"))
}

# Graph function to summarise political affiliation by each state
graph_party <- function(state) {
  color_map <- c("Democrat" = "darkblue",
                 "Republican" = "red",
                 "Independent" = "darkgrey")

  data <- state_house("house", state) %>%
    group_by(`Party`) %>%
    summarize(Num = n())

  data$Party[data$Party == "D"] <- "Democrat"
  data$Party[data$Party == "R"] <- "Republican"
  data$Party[data$Party == "I"] <- "Independent"

  plot_ly(
    type = "bar",
    x = data$Party,
    y = data$Num,
    marker = list(color = color_map[data$Party],
                  line = list(color = "black", width = 1))) %>%
      layout(title = paste("Political Affiliation of House Representatives in",
                           abb_to_full(state)),
             xaxis = list(title = "Political Party of Representatives"),
             yaxis = list(title = "Count"))
}
