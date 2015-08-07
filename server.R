library(shiny)

shinyServer(
    function(input, output) {
        output$predictionGraph <- renderPlot({
            periods <- c(1, 2, 3, 4, 5, 6, 7)
            incidents <- c({input$p1}, {input$p2}, {input$p3}, {input$p4},
                           {input$p5}, {input$p6}, {input$p7})
            dat <- data.frame(periods,incidents)
            # generalized linear model, poisson family
            #fit <- glm(incidents ~ periods, data = dat, family = poisson)
            
            # linear model
            fit <- lm(incidents ~ periods, data = dat)
            
            lBound <- length(periods) + 1
            uBound <- lBound + {input$periodsToPredict} - 1
            new.periods <- c(lBound : uBound)
            
            new.incidents <- predict(fit, newdata = data.frame(periods = new.periods))
            plot(x = c(periods, new.periods), y = c(incidents, new.incidents),
                 ylim=c(0, 500), col="blue", pch=19, xlab="periods", ylab="incidents")
            title("Predict incoming incidents based on previous periods")
            lines(c(periods, new.periods), c(incidents, new.incidents), col="blue", lwd=2)
            points(x = new.periods, y = new.incidents, pch=19, col="red", cex = 2)
            
            output$prediction <- renderPrint({new.incidents})
        })
    }
)