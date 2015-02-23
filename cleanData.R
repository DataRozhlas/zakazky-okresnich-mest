library(jsonlite)
library(dplyr)

dodavatel  <- data.frame(api=character(), name=character())

for (i in unique(zakazky$dodavatel)) {
        result  <- fromJSON(paste0("http://www.vsechnyzakazky.cz", i, "?format=json"))
        if(is.null(result$nazev)) {result$nazev  <- NA}
        dodavatel  <- rbind(data.frame(api=i, name=result$nazev), dodavatel)
        print(result$nazev)
}

zadavatel  <- data.frame(api=character(), name=character())
for (i in unique(zakazky$zadavatel)) {
        result  <- fromJSON(paste0("http://www.vsechnyzakazky.cz", i, "?format=json"))
        if(is.null(result$nazev)) {result$nazev  <- NA}
        zadavatel  <- rbind(data.frame(api=i, name=result$nazev), zadavatel)
        print(result$nazev)
}

druhrizeni  <- data.frame(api=character(), name=character())
for (i in unique(zakazky$druh_rizeni)) {
        result  <- fromJSON(paste0("http://www.vsechnyzakazky.cz", i, "?format=json"))
        if(is.null(result$nazev)) {result$nazev  <- NA}
        druhrizeni  <- rbind(data.frame(api=i, name=result$nazev), druhrizeni)
        print(result$nazev)
}

typzakazky  <- data.frame(api=character(), name=character())
for (i in unique(zakazky$typ_zakazky)) {
        result  <- fromJSON(paste0("http://www.vsechnyzakazky.cz", i, "?format=json"))
        if(is.null(result$nazev)) {result$nazev  <- NA}
        typzakazky  <- rbind(data.frame(api=i, name=result$nazev), typzakazky)
        print(result$nazev)
}


levels(dodavatel$name)["neuveden"]  <- "neuveden"

dodavatel$name  <- as.character(dodavatel$name)
dodavatel[is.na(dodavatel$name),]$name  <- "neuveden"

zakazky2  <- merge(zakazky, dodavatel, by.x="dodavatel", by.y="api")
zakazky2  <- merge(zakazky2, druhrizeni, by.x="druh_rizeni", by.y="api")
zakazky2  <- merge(zakazky2, typzakazky, by.x="typ_zakazky", by.y="api")
zakazky2  <- merge(zakazky2, zadavatel, by.x="zadavatel", by.y="api")

zakazky3  <- data.frame(
        zadavatel=zakazky2[,25],
        zadavatelURL=paste0("http://vsechnyzakazky.cz/zadavatel/detail/", substr(zakazky2$zadavatel, 18, 24)),
        dodavatel=zakazky2[,22],
        dodavatelURL=paste0("http://vsechnyzakazky.cz/dodavatel/detail/", substr(zakazky2$dodavatel, 18, 24)),
        rizeni=zakazky2[,23],
        URLzakazky=paste0("http://vsechnyzakazky.cz/zakazka/detail/", substr(zakazky2$resource_uri, 16, 23)),
        cena=zakazky2$cena,
        cenaCelkem=zakazky2$cena_celkem,
        odvetvi=zakazky2[,24],
        zdroj=zakazky2$zdroj_nazev,
        zdrojURL=zakazky2$zdroj,
        ramcovaSmlouva=zakazky2$ramcova_smlouva,
        popis=zakazky2$popis,
        nazev=zakazky2$nazev,
        nabidek=zakazky2$pocet_nabidek,
        eu=zakazky2$podporeno_eu,
        datum=zakazky2$datum_zadani,
        ico=zakazky2$ico
        )

save(zakazky3, file="data/zakazky_clean.R")

zakazky4 <- data.frame(
        mesto = zakazky_ico$NAZOB,
        datum = as.Date(zakazky_ico$datum),
        zadavatel = paste0("<a href=\"", zakazky_ico$zadavatelURL, "\" target=\"_blank\">", zakazky_ico$NAZOB, "</a>"),
        dodavatel = paste0("<a href=\"", zakazky_ico$dodavatelURL, "\" target=\"_blank\">", zakazky_ico$dodavatel, "</a>"),
        cena = zakazky_ico$cena,
        nazev = paste0("<a href=\"", zakazky_ico$URLzakazky, "\" target=\"_blank\">", zakazky_ico$nazev, "</a>"),
        rizení = zakazky_ico$rizeni,
        nabidek = zakazky_ico$nabidek,
        zdroj = paste0("<a href=\"", zakazky_ico$zdrojURL, "\" target=\"_blank\">", zakazky_ico$zdroj, "</a>")
)

save(zakazky4, file="zakazky/zakazky.R")

write.csv(zakazky3, file="zakazky/zakazky3.csv", row.names = F)
write.csv(zakazky4, file="zakazky/zakazky4.csv", row.names = F)

