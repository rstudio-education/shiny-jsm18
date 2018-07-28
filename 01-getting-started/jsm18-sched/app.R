# Load packages -----------------------------------------------------
library(shiny)
library(tidyverse)
library(DT)
library(glue)

# Load data ---------------------------------------------------------
jsm_sessions <- read_csv("data/jsm2018_sessions.csv")
jsm_talks <- read_csv("data/jsm2018_talks.csv")

# UI ----------------------------------------------------------------
ui <- navbarPage(
  "JSM 2018",
  
  # Tab 1: Session schedule -----------------------------------------
  tabPanel("Session Schedule",
           sidebarLayout(
             sidebarPanel(
               HTML(
                 "Select day(s) and sponsor(s) to get started. Scroll
                 down to limit session types."
               ),
               br(),
               br(),
               
               # Select day(s) -----------------------
               checkboxGroupInput(
                 "day",
                 "Day(s)",
                 choices = c(
                   "Fri, Jun 27" = "Fri",
                   "Sat, Jun 28" = "Sat",
                   "Sun, Jun 29" = "Sun",
                   "Mon, Jun 30" = "Mon",
                   "Tue, Jun 31" = "Tue",
                   "Wed, Aug 1"  = "Wed",
                   "Thu, Aug 2"  = "Thu"
                 ),
                 selected = "Sun"
               ),
               
               # Select start and end time -----------
               sliderInput(
                 "beg_time",
                 "Start time",
                 min = 7,
                 max = 23,
                 value = 8,
                 step = 1
               ),
               
               sliderInput(
                 "end_time",
                 "End time",
                 min = 7,
                 max = 23,
                 value = 17,
                 step = 1
               ),
               
               # Select sponsor(s) -------------------
               checkboxGroupInput(
                 "sponsor_check",
                 "Sponsor(s)",
                 choices = c(
                   "Statistical Education",
                   "Statistical Computing",
                   "Statistical Graphics",
                   "Statistical Learning and Data Science"
                 ),
                 selected = "Statistical Education"
               ),
               
               # Select other sponsor(s) -------------
               textInput("sponsor_text",
                         "For other sponsor(s) type keyword(s)"),
               
               # Select types(s) ---------------------
               checkboxGroupInput(
                 "type",
                 "Type(s)",
                 choices = sort(unique(jsm_sessions$type)),
                 selected = unique(jsm_sessions$type)
               ),
               
               width = 3
               ),
             
             # Output --------------------------------
             mainPanel(DT::dataTableOutput(outputId = "schedule"), width = 9)
             
           )),
  
  # Tab 2: Talk finder
  tabPanel("Talk Finder",
           sidebarLayout(
             sidebarPanel(
               HTML("Select keywords you're interested in, or add your own:"),
               br(),
               # Keyword selection -------------------------------------------
               checkboxGroupInput("keyword_choice",
                                  "",
                                  choices = c(
                                    "R"       = " R | R$", 
                                    "tidy"    = "[tT]idy", 
                                    "Shiny"   = "[sS]hiny", 
                                    "RStudio" = "RStudio|R Studio", 
                                    "Python"  = "[pP]ython"),
                                  selected = " R | R$"),
               
               # Other -------------------------------------------------------
               textInput("keyword_text",
                         "Other keywords"),
               
               # Excluded fee events -----------------------------------------
               checkboxInput("exclude_fee",
                             "Exclude added fee events")
               
             ),
             
             # Output --------------------------------------------------------
             mainPanel(DT::dataTableOutput(outputId = "talks"))
             
           ))
)

# Server ------------------------------------------------------------
server <- function(input, output) {
  
  # Sessions --------------------------------------------------------
  output$schedule <- DT::renderDataTable({
    # Require inputs ------------------------------------------------
    req(input$day)
    req(input$type)
    # Wrangle sponsor text ------------------------------------------
    sponsor_check_string <- glue_collapse(req(input$sponsor_check), sep = "|")
    sponsor_text_string <- str_replace_all(input$sponsor_text, " ", "|")
    sponsor_string <- ifelse(
      sponsor_text_string == "",
      sponsor_check_string,
      glue(sponsor_check_string, sponsor_text_string, .sep = "|")
      )
    # Filter and tabulate data --------------------------------------
    jsm_sessions %>%
      filter(
        day %in% input$day,
        type %in% input$type,
        beg_time_round >= input$beg_time,
        end_time_round <= input$end_time,
        str_detect(tolower(sponsor), tolower(sponsor_string))
      ) %>%
      mutate(
        date_time = glue("{day}, {date}<br/>{time}"),
        session = glue('<a href="{url}">{session}</a>')
      ) %>%
      select(date_time, session, location, type, sponsor) %>%
      DT::datatable(rownames = FALSE, escape = FALSE) %>%
      formatStyle(columns = "date_time", fontSize = "80%", width = "100px") %>%
      formatStyle(columns = "session", width = "450px") %>%
      formatStyle(columns = c("location", "type"), width = "100px") %>%
      formatStyle(columns = "sponsor", fontSize = "80%", width = "200px")
    
  })
  
  # Talks -----------------------------------------------------------
  output$talks <- DT::renderDataTable({
    keyword_choice_string <- glue_collapse(input$keyword_choice, sep = "|")
    keyword_string <- ifelse(input$keyword_text == "", 
                             keyword_choice_string,
                             glue(keyword_choice_string, input$keyword_string, .sep = "|"))

    if (input$exclude_fee) {
      jsm_talks <- jsm_talks %>% filter(has_fee == FALSE)
    }
    
    jsm_talks %>%
      filter(str_detect(title, keyword_string)) %>%
      mutate(title = glue('<a href="{url}">{title}</a>')) %>%
      select(title) %>%
      DT::datatable(rownames = FALSE, escape = FALSE)
    
  })
}

# Create the app object ---------------------------------------------
shinyApp(ui, server)
