# kumulativní součty objemů zakázek
library(dplyr)
library(ggplot2)

zakazky5 <- tbl_df(zakazky3)

zakazky6 <- zakazky5 %>%
        filter(datum>as.Date("2009-12-31")) %>%
        filter(datum<as.Date("2015-01-01")) %>%
        arrange(datum) %>%
        select(zadavatel, datum, cena, zadavatelURL, nazev, zdroj, zdrojURL)

write.csv(zakazky6, file="zakazky2/zakazky.csv", row.names=F)

p <- ggplot(zakazky6, aes(x=datum, y=kumcena/1000000000)) + geom_line()
p <- p + annotate("rect", xmin=as.Date("2010-09-01"), xmax=as.Date("2010-11-30"), ymin=0, ymax=max(zakazky6$kumcena)/1000000000*1.04, alpha=0.1, fill="blue")
p <- p + annotate("rect", xmin=as.Date("2014-09-01"), xmax=as.Date("2014-11-30"), ymin=0, ymax=max(zakazky6$kumcena)/1000000000*1.04, alpha=0.1, fill="blue")        
p <- p + geom_vline(xintercept=14898, linetype="dotted")
p <- p + geom_vline(xintercept=16354, linetype="dotted")
p <- p + ylab("miliardy korun")
p <- p + xlab("rok")
p <- p + ggtitle("Kumulativní součet cen veřejných zakázek zadavatele")
p <- p + annotate("text", x=as.Date("2010-10-16"), y=max(zakazky6$kumcena)/1000000000, label="komunální volby 2010", size=4, hjust=-0.2)
p <- p + annotate("text", x=as.Date("2014-10-11"), y=max(zakazky6$kumcena)/20000000000, label="komunální volby 2014", size=4, hjust=1.15)
p

ceiling(zakazky6$kumcena)

sum(zakazky6$cena)/1000000000


as.Date("2014-10-11") - as.Date("1970-01-01")
as.Date("2010-10-16") - as.Date("1970-01-01")

ggplot(zakazky6, aes(x=datum, y=cena)) + geom_line() + facet_wrap(~ zadavatel)

zakazky5[zakazky5$cenaCelkem!=zakazky5$cena, ] %>%
        select(cena, cenaCelkem, URLzakazky)
