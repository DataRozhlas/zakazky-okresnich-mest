library(dplyr)
library(tidyr)
library(lubridate)

# podle počtu a objemu zveřejněných zakázek

zakazky3 <- tbl_df(zakazky3)

obce_ico <- tbl_df(obce_ico)

names(obce_ico)[3] <- "ico"

zakazky_ico <- inner_join(zakazky3, obce_ico)



obce_zakazky <- zakazky_ico %>%
        filter(as.Date(datum)>as.Date("2009-12-31")) %>%
        group_by(NAZOB, POCET_OBYVATEL_260311) %>%
        summarise(pocetZakazek=n(), objemZakazek=sum(cena))

obce_zakazky <- tbl_df(obce_zakazky)

output <- obce_zakazky %>%
        mutate(objemNaObyvatele=objemZakazek/POCET_OBYVATEL_260311) %>%
        arrange(desc(objemNaObyvatele))

write.csv(output, file="output/obce-zverejnene-zakazky.csv")


# měsíční průměry

zakazky_mesice <- zakazky_ico %>%
        filter(as.Date(datum)>as.Date("2010-10-30")&as.Date(datum)<as.Date("2014-11-30")) %>%
        mutate(mesic=as.Date(paste0(year(datum), "-", formatC(month(datum), width=2, flag=0), "-01"))) %>%
        group_by(mesic, ico) %>%
        summarise(cena=sum(cena))

zakazky_mesice <- inner_join(zakazky_mesice, obce_ico)

zakazky_volebni <- zakazky_mesice %>%
        mutate(volebni=ifelse(mesic>as.Date("2014-07-31"), TRUE, FALSE))%>%
        select(mesic=mesic, cena, obec=NAZOB, volebni=volebni) %>%
        group_by(obec, volebni) %>%
        summarise(prumer=median(cena))

zakazky_volebni <- spread(zakazky_volebni, volebni, prumer)

zakazky_volebni <- zakazky_volebni %>%
        select(obec, nevolebni=2, volebni=3) %>%
        mutate(rozdil=volebni/nevolebni*100) %>%
        arrange(desc(rozdil))

write.csv(zakazky_volebni, file="output/output.csv")

# tabulky pro jednolivá města
export <- zakazky_ico %>%
        mutate(volebni=ifelse(as.Date(as.character(datum))>as.Date("2014-07-31")&as.Date(as.character(datum))<as.Date("2014-11-10"), TRUE, FALSE)) %>%
        select(volebni, mesto=NAZOB, datum, cena, nazev, popis, dodavatel, odvetvi, nabidek, rizeni, zdrojURL, URLzakazky, dodavatelURL)
        
for (i in unique(export$mesto)) {
        print(i)
        vysledek <- export %>%
                filter(volebni==TRUE & mesto==i) %>%
                select(-volebni, -mesto) %>%
                arrange(desc(cena))
        if (nrow(vysledek)>0) {write.xlsx2(data.frame(vysledek), file=paste0("output/zakazky-kolem-voleb/", cleanString(i), ".xlsx"), row.names=F)}
}

cleanString <- function(x){
        tmp <- iconv(x, from="UTF8", to ="ASCII//TRANSLIT")
        gsub("[^[:alpha:]]", "", tmp)
}

