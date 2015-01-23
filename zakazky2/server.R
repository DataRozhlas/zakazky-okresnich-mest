

shinyServer(function(input, output) {
        library("ggplot2")
        library("dplyr")
        
        zakazky <- read.csv("zakazky.csv")
        
        output$graf <- renderPlot({
                vysledek <- zakazky %>%
                        filter(zadavatel==input$vybraneMesto) %>%
                        mutate(datum=as.Date(datum)) %>%
                        mutate(kumcena=cumsum(cena))
                
                p <- ggplot(vysledek, aes(x=datum, y=kumcena/1000000000)) + geom_line()
                p <- p + annotate("rect", xmin=as.Date("2010-09-01"), xmax=as.Date("2010-11-30"), ymin=0, ymax=max(vysledek$kumcena)/1000000000*1.04, alpha=0.1, fill="blue")
                p <- p + annotate("rect", xmin=as.Date("2014-09-01"), xmax=as.Date("2014-11-30"), ymin=0, ymax=max(vysledek$kumcena)/1000000000*1.04, alpha=0.1, fill="blue")        
                p <- p + geom_vline(xintercept=14898, linetype="dotted")
                p <- p + geom_vline(xintercept=16354, linetype="dotted")
                p <- p + ylab("miliardy korun")
                p <- p + xlab("rok")
                p <- p + ggtitle(paste("Kumulativní součet cen zakázek zveřejněných zadavatelem", input$vybraneMesto))
                p <- p + annotate("text", x=as.Date("2010-10-16"), y=max(vysledek$kumcena)/1000000000, label="komunální volby 2010", size=4, hjust=-0.2)
                p <- p + annotate("text", x=as.Date("2014-10-11"), y=max(vysledek$kumcena)/20000000000, label="komunální volby 2014", size=4, hjust=1.15)
                p                                
        })        

        output$shrnuti <- renderText()
        
})
        
        
        
        
        
        
        
        
        
        
        
        