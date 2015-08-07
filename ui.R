library(shiny)

shinyUI(
    pageWithSidebar(
        # Application title
        headerPanel("Predict number of incoming incidents"),
        sidebarPanel(
            sliderInput('periodsToPredict', label=h4('Number of periods to predict'),
                        5, min=1, max=20, step=1),
            
            submitButton('Submit'),
            
            h4('Number of incidents on previous periods'),
            numericInput('p7', 'Period p-1 (most recent)', 92, step = 10),
            numericInput('p6', 'Period p-2', 176, step = 10),
            numericInput('p5', 'Period p-3', 185, step = 10),
            numericInput('p4', 'Period p-4', 244, step = 10),
            numericInput('p3', 'Period p-5', 133, step = 10),
            numericInput('p2', 'Period p-6', 184, step = 10),
            numericInput('p1', 'Period p-7', 135, step = 10)
        ),
        mainPanel(
            p('This program predicts a number of incoming incidents based on a history
              of previous incidents. The number of incidents for the previous periods are
              in the left panel. The number of periods to be predicted can also be adjusted
              in the left panel.'),
            
            p('The method for prediction is very simple in this version: linear method. It would be 
              interesting in a future version to be able to select several types of prediction methods:
              GLM - Poisson, etc.'),
            
            h3('Results of prediction'),
            p('Predicted number of incidents for next periods:'),
            verbatimTextOutput("prediction"),
            
            h3('Graphical display'),
            p('The graph below shows the past incidents (blue) and prediction for next period (red).'),
            plotOutput('predictionGraph')
        )
    )
)