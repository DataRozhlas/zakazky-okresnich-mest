library(xlsx)
library(rvest)
library(jsonlite)

obce  <- read.xlsx("data//obce.xls", 1)

krajska  <- c("Brno", "České Budějovice", "Hradec Králové", "Jihlava", "Karlovy Vary", "Liberec", "Olomouc", "Ostrava", "Pardubice", "Plzeň", "Praha", "Ústí nad Labem", "Zlín")

html  <- html("http://cs.wikipedia.org/wiki/Seznam_okres%C5%AF_v_%C4%8Cesku")
okresni  <- html_table(html)[[1]]
okresni  <- substr(okresni[,1], 7, 25)

okresni[4]  <- "Brno"
okresni[5]  <- "Brno"
okresni[47]  <- "Plzeň"
okresni[48]  <- "Plzeň"
okresni[49]  <- "Plzeň"
okresni[50]  <- "Praha"
okresni[51] <- "Praha"
okresni[52]  <-  "Praha"

okresni  <- unique(okresni)

rm(html)

vyber  <- obce[as.character(obce$Obec) %in% krajska | as.character(obce$Obec) %in% okresni, ]

# odstraň duplikáty
vyber  <- vyber[c(-27,-63),]
vyber  <- vyber[-27,]
vyber  <- vyber[-51,]

#scrape

zadavatele  <-  data.frame()

for (i in vyber$IČO) {
        result  <- fromJSON(paste0("http://vsechnyzakazky.cz/api/v1/zadavatel/?format=json&ico=", i))$objects
        zadavatele  <- rbind(result, zadavatele)
        print(i)
}

zakazky  <- data.frame()

for (i in zadavatele$id) {
        result  <- fromJSON(paste0("http://vsechnyzakazky.cz/api/v1/zakazka/?format=json&limit=500&zadavatel=", i))
        zakazky  <- rbind(result$objects, zakazky)
        print(i)
        print(result$meta[[2]])
        while (!is.null(result$meta[[2]])) {
                result  <- fromJSON(paste0("http://vsechnyzakazky.cz", result$meta[[2]]))
                zakazky  <- rbind(result$objects, zakazky)
                print(i)
                print(result$meta[[2]])
        }
}

