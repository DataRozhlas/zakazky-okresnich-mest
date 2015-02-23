zakazky4 <- read.csv("zakazky4.csv")
shinyServer(function(input, output) {
        output$filtrovanaTabulka <- renderDataTable(
                {vysledek <- zakazky4
                if (!is.null(input$vybraneMesto)) {vysledek <- vysledek[vysledek$mesto %in% input$vybraneMesto, ]}
                vysledek <- vysledek[as.Date(vysledek$datum) > input$vybraneDatum[1] & as.Date(vysledek$datum) < input$vybraneDatum[2], ]
                vysledek <- vysledek[vysledek$cena>=input$cenaMin, ]
                vysledek <- vysledek[vysledek$cena<=input$cenaMax, ]
                if (input$radit==2) {vysledek <- vysledek[order(vysledek$cena, decreasing=TRUE),]}
                if (input$radit==1) {vysledek <- vysledek[order(vysledek$datum, decreasing=TRUE),]}
                vysledek[,2:9]},
                options = list(
                         searching=FALSE,
                         ordering=FALSE,
                         language=list(
                                 url="https://cdn.datatables.net/plug-ins/a5734b29083/i18n/Czech.json"
                         ),
                         lengthMenu = list(
                                 c(10, 50, 100, 1000, -1),
                                 c("10", "50", "100", "1000", "Všechno")
                         ),
                         pageLength = 10
                 ),
                escape=FALSE
        )
         
        output$souhrnneInfo <- renderText({
                vysledek <- zakazky4
                if (!is.null(input$vybraneMesto)) {vysledek <- vysledek[vysledek$mesto %in% input$vybraneMesto, ]}
                vysledek <- vysledek[as.Date(vysledek$datum) > input$vybraneDatum[1] & as.Date(vysledek$datum) < input$vybraneDatum[2], ]
                vysledek <- vysledek[vysledek$cena>=input$cenaMin, ]
                vysledek <- vysledek[vysledek$cena<=input$cenaMax, ]
                if (input$radit==2) {vysledek <- vysledek[order(vysledek$cena, decreasing=TRUE),]}
                if (input$radit==1) {vysledek <- vysledek[order(vysledek$datum, decreasing=TRUE),]}
                options(scipen=999)
                paste("Máte vybráno", nrow(vysledek), "zakázek ze", length(unique(vysledek$mesto)), "okresních a krajských měst. Jejich celková hodnota činí", sum(vysledek$cena)/1000000000, "miliard Kč." )
        })
        
        
})
        
        
        
        
        
        
        
        
        
        
        
        