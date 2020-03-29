# a7: Access to Congressional Member Information:  API and Shiny UI Skills
This rubric is intended to help guide expectations and increase transparency. However, it **is not** necessarily fully exhaustive. Make sure to read the detailed explanation on Canvas, and follow the best practices described in the course book and in class.

Partial credit will be given where appropriate.

# Shiney Application (**52 points**)
## Set-up (**12 points**)
- Creates `app.R` file (**1 point**)
- Creates `app_ui.R` file (**1 point**)
- Creates `app_server.R` file (**1 point**)
- Adds shinyapp.io link to `README.md` (**1 point**)
- A user interface that has a navigable multi-page layout (**2 points**)
- The tabs have clear, concise, ordinary names [not "State representatives query page" - since "query page" is technical and "State representatives" is long] (**1 point** )
- The application has a clear, concise, interesting title (**1 point**)
- Application runs at shinyapp.io (**4 points** )

## About page (**10 points**)
### Overview (**4 points**)
- About 2-3 clear, concise and well-written paragraphs [about 100 words] (**2 points**)
- Includes link to ProPublica API (as hypertext link) [**1 point**]
- Professional use of sub-headings, whitespace, and/or bold or italic [**1 point**]

### Affiliation (**1 point**)
- Included and professionally presented (**1 points**)

### Reflective statement (**4 points**)
- Clear, concise, and well-written statement [> 100 words] (**2 points**)
- A focused appropriate citation to O'Neil (2016) (**1 point**)
- Creative or distinctive approach to writing or presentation (**1 point**)

### Overall (**-2 to 1 points**)
- Consistent headings for each section (**1 point**)
- Points taken off for spelling or grammatical errors (up to **-2 points**)

## State representatives query page (**14 points**)
- A `sideBarlayout()` (or other appropriate layout) to appropriately organize content (**2 points**)
- One labeled and working widget (e.g, `selectInput()`) allows a user to select one of 50 US states and control the tabular presentation (**2 points**)
- Table is drawn and all five fields are shown for each congressional representative (**4 points**)
- Table has headings (**2 points**)
- Mechanism for details on demand  works (**2 points**)
- All four fields for details on demand are shown (**2 points**)

## Summary page (**10 points**)  
- A `sideBarlayout()` (or other appropriate layout) to appropriately organize content (**2 points**)
- One labeled and working widget (e.g, `selectInput()`) allows a user to select one of 50 US states and present the two charts (**2 points**)
- Creates a horizontal bar chart of gender with title/axis labels (**3 points**)
- Creates a horizontal bar chart of political affiliation with title/axis labels (**3 points**)

## Code clarity and understandability (**6 points**)
- Code is consistently and clearly formatted (**2 points**)
- Clear, concise variable and function names (**2 points**)
- Good use of comments for describing purpose of code (**2 points**)

# ProPublica API: House of Representatives Charts (**28 points**)
## Set-up (**4 points**)
- Creates two files, `probulica.R` and `propublica_key.R` (**2 points**)
- Git/Github ignores the file containing API key (**2 points**)

## Functions and calculations (**18 points**)
- Function 1: Takes two parameters, `chamber` (`default="house"`) and `state` (`default="WA"`), and returns data on state representatives (**6 points**)
- Function 2: Takes a `member_id` parameter and returns data about the member (**6 points**)
- Function 3: A function to calculate the age of a representative (**2 points**)
- Function 4: A function to compute summary information for plotting (see "Summary page" above) (**4 points**)
- _Please note_: You will need to implement other functions to organize the functionality of your application.

## Code clarity and understandability (**6 points**)
- Code is consistently and clearly formatted (**2 points**)
- Clear, concise variable and function names (**2 points**)
- Good use of comments for describing purpose of code (**2 points**)
