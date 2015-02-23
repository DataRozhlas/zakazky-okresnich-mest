library("ggplot2")
library("dplyr")

zakazky <- read.csv("zakazky.csv")

shinyServer(function(input, output) {
        

                
        output$graf <- renderPlot({
                vysledek <- zakazky %>%
                        filter(zadavatel==input$vybraneMesto) %>%
                        mutate(datum=as.Date(datum)) %>%
                        filter(datum>as.Date("2010-10-30")) %>%
                        arrange(datum) %>%
                        mutate(kumcena=cumsum(cena))
                p <- ggplot(vysledek, aes(x=datum, y=kumcena/1000000000)) + geom_line()
#                p <- p + annotate("rect", xmin=as.Date("2010-08-01"), xmax=as.Date("2010-11-30"), ymin=0, ymax=max(vysledek$kumcena)/1000000000*1.04, alpha=0.1, fill="blue")
                p <- p + annotate("rect", xmin=as.Date("2014-08-01"), xmax=as.Date("2014-11-30"), ymin=0, ymax=max(vysledek$kumcena)/1000000000*1.04, alpha=0.1, fill="blue")        
 #               p <- p + geom_vline(xintercept=14898, linetype="dotted")
                p <- p + geom_vline(xintercept=16354, linetype="dotted")
                p <- p + ylab("miliardy korun")
                p <- p + xlab("rok")
                p <- p + ggtitle(paste("Kumulativní součet cen zakázek zveřejněných městem", input$vybraneMesto))
      #          p <- p + annotate("text", x=as.Date("2010-10-16"), y=max(vysledek$kumcena)/1000000000, label="komunální volby 2010", size=4, hjust=-0.2)
                p <- p + annotate("text", x=as.Date("2014-10-11"), y=max(vysledek$kumcena)/20000000000, label="komunální volby 2014", size=4, hjust=1.15)
                p                                
        })
        
        output$shrnuti <- renderText({
                vysledek <- zakazky %>%
                        filter(zadavatel==input$vybraneMesto) %>%
                        mutate(datum=as.Date(datum)) %>%
                        filter(datum>as.Date("2014-07-31") & datum<as.Date("2014-11-30")) %>%
                        arrange(datum) %>%
                        mutate(kumcena=cumsum(cena))
                if (nrow(vysledek)<5&nrow(vysledek)>0) {sklonovani <- "veřejné zakázky"} else {sklonovani <- "veřejných zakázek"}
                veta1 <- paste("V době komunálních voleb (srpen až listopad 2014) přidělilo město", input$vybraneMesto, "celkem", nrow(vysledek), sklonovani, "v celkovém objemu", round(sum(vysledek$cena)/1000000), "milionů Kč.")
                veta1
                
        })
 
})
        
        
        
        
        
        
        
        
        
        
        
        