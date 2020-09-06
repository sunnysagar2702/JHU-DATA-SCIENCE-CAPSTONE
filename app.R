#' ---
#' title: 'Task 06: Data Product'
#' author: "Sunny Sagar"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---

#' ## Shiny App 
#' This script creates a Shiny App that takes a word or phrase input in a text box
#' and outputs the a predicted next word. 

library(shiny)
suppressPackageStartupMessages({
   library(tidyverse)
   library(stringr)
 })

#' Source ngram matching function
source("ngram.R")

#' Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Text Prediction Model"),
   p("This app that takes an input phrase (multiple words) in a text box and outputs a prediction of the next word."),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        h2("Instructions:"), 
        h5("1. Enter a word or words in the text box."),
        h5("2. The predicted next word prints below it in blue."),
        h5("3. No need to hit enter of submit."),
        h5("4. A question mark means no prediction, typically due to mis-spelling"),
        h5("5. Additional tabs show plots of the top ngrams in the dataset"),
        br(),
        a("Source Code", href = "https://github.com/mark-blackmore/JHU-Data-Science-Capstone/tree/master/ngram_match")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(
          tabPanel("predict",
            textInput("user_input", h3("Your Input:"), 
                    value = "Your words"),
            h3("Predicted Next Word:"),
            h4(em(span(textOutput("ngram_output"), style="color:blue")))),
        
          tabPanel("top quadgrams",
            br(),
            img(src = "quadgrams.png", height = 500, width = 700)),
        
          tabPanel("top trigrams",
            br(),       
            img(src = "trigrams.png", height = 500, width = 700)),
      
          tabPanel("top bigrams",
            br(),
            img(src = "bigrams.png", height = 500, width = 700))
          )   
    )
  )
)
#' Define server logic required to draw a histogram
server <- function(input, output) {
   
  output$ngram_output <- renderText({
      ngrams(input$user_input)
  })
  
}
  
#' Run the application 
shinyApp(ui = ui, server = server)

