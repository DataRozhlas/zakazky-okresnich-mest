shinyUI(fluidPage(
  
        title="Zakázky krajských a okresních měst",
        
        h1("Zakázky krajských a okresních měst (nejen) v době komunálních voleb"),
        
        p("Aplikace pro interní potřeby Centra zpravodajství ČRo. Datum zakázky je datum, kdy byla uveřejněna ve věstníku veřejných zakázek, obvykle do jednoho měsíce od výběru dodavatele. Zdroj dat:",
                a("http://www.vsechnyzakazky.cz/",
                  href = "http://www.vsechnyzakazky.cz/")),
        
        br(),
        
        h4(textOutput("souhrnneInfo")),
        
        br(),
               
        p("Výběr a řazení můžete upravit pomocí formuláře:"),
        
        fluidRow(
                column(2,
                       selectInput("vybraneMesto",
                                   p("1. Vyber jedno či více měst"),
                                   choices=c("Benešov", "Beroun", "Blansko", "Brno", "Bruntál", "Břeclav", "Česká Lípa", "České Budějovice", "Český Krumlov", "Děčín", "Domažlice", "Frýdek-Místek", "Havlíčkův Brod", "Hodonín", "Hradec Králové", "Cheb", "Chomutov", "Chrudim", "Jablonec nad Nisou", "Jeseník", "Jičín", "Jihlava", "Jindřichův Hradec", "Karlovy Vary", "Karviná", "Kladno", "Klatovy", "Kolín", "Kroměříž", "Kutná Hora", "Liberec", "Litoměřice", "Louny", "Mělník", "Mladá Boleslav", "Most", "Náchod", "Nový Jičín", "Nymburk", "Olomouc", "Opava", "Ostrava", "Pardubice", "Pelhřimov", "Písek", "Plzeň", "Praha", "Prachatice", "Prostějov", "Přerov", "Příbram", "Rakovník", "Rokycany", "Rychnov nad Kněžnou", "Semily", "Sokolov", "Strakonice", "Svitavy", "Šumperk", "Tábor", "Tachov", "Teplice", "Trutnov", "Třebíč", "Uherské Hradiště", "Ústí nad Labem", "Ústí nad Orlicí", "Vsetín", "Vyškov", "Zlín", "Znojmo", "Žďár nad Sázavou"),
                                   multiple=TRUE
                       )
                ),
                column(3,
                       dateRangeInput("vybraneDatum",
                                      p("2. Vyber období"),
                                      start="2014-08-01",
                                      end="2014-11-30",
                                      format="d. m. yyyy",
                                      weekstart=1,
                                      language="cs",
                                      separator="až"
                       )
                ),
                column(2,
                       numericInput("cenaMin",
                                    label = p("3. Zadej nejnižší cenu v Kč"),
                                    value = 0,
                                    min = 0,
                                    max = 17819557851,
                                    step = 10000)
                ),
                column(2,
                       numericInput("cenaMax",
                                    label = p("4. Zadej nejvyšší cenu v Kč"),
                                    value = 17819557851,
                                    min = 0,
                                    max = 17819557851,
                                    step = 10000)       
                ),
                column(2,
                       radioButtons("radit",
                                    label = p("5. Seřadit"),
                                    choices = list("Chronologicky" = 1, "Podle ceny" = 2), 
                                    selected = 1)       
                )
                
        ),
        
        dataTableOutput("filtrovanaTabulka")
        
))
        