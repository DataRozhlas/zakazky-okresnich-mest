shinyUI(fluidPage(
  
        title="Zakázky krajských a okresních měst",
        
        h1("Zakázky krajských a okresních měst"),
        
        p("Aplikace pro interní potřeby Centra zpravodajství ČRo. Datum zakázky je datum, kdy byla uveřejněna ve věstníku veřejných zakázek, obvykle do jednoho měsíce od výběru dodavatele. Zdroj dat:",
                a("http://www.vsechnyzakazky.cz/",
                  href = "http://www.vsechnyzakazky.cz/")),
        
        hr(),
        
        h4(textOutput("souhrnneInfo")),
        
               
        p("Výběr a řazení můžete upravit pomocí formuláře:"),
        
        
        fluidRow(
                column(2,
                       selectInput("vybraneMesto",
                                   p("1. Vyber jedno či více měst"),
                                   choices=c("HLAVNÍ MĚSTO PRAHA", "Statutární město Brno", "STATUTÁRNÍ MĚSTO LIBEREC", "Město Rakovník", "Statutární město Pardubice", "Město Příbram", "Statutární město Jihlava", "Město Žďár nad Sázavou", "Statutární město Prostějov", "Statutární město Zlín", "Město Rychnov nad Kněžnou", "MĚSTO ČESKÁ LÍPA", "Město Tábor", "Město Náchod", "MĚSTO UHERSKÉ HRADIŠTĚ", "Město Kutná Hora", "Statutární město Frýdek-Místek", "Město Kolín", "Město Semily", "Město Nový Jičín", "Město Klatovy", "MĚSTO BLANSKO", "Město Vsetín", "Město Svitavy", "Statutární město Ostrava", "Statutární město Olomouc", "Město Ústí nad Orlicí", "Město Louny", "STATUTÁRNÍ MĚSTO MOST", "Statutární město Ústí nad Labem", "Město Jičín", "Město Znojmo", "Město Pelhřimov", "Statutární město Jablonec nad Nisou", "Město Trutnov", "Město Chrudim", "STATUTÁRNÍ MĚSTO DĚČÍN", "MĚSTO KROMĚŘÍŽ", "Město  Nymburk", "Město Jeseník", "Město HODONÍN", "Statutární město České Budějovice", "Město Domažlice", "Statutární město Kladno", "Město Vyškov", "Město Šumperk", "STATUTÁRNÍ MĚSTO TEPLICE", "MĚSTO PRACHATICE", "STATUTÁRNÍ MĚSTO CHOMUTOV", "Město Písek", "Statutární město Hradec Králové", "Město Benešov", "STATUTÁRNÍ MĚSTO KARVINÁ", "MĚSTO TŘEBÍČ", "Město Bruntál", "Statutární město Opava", "Město Strakonice", "MĚSTO HAVLÍČKŮV BROD", "Město Rokycany", "Obec Písek", "Statutární město Přerov", "Město Český Krumlov", "Město Cheb", "MĚSTO BŘECLAV", "Město Beroun", "Město Jindřichův Hradec", "Město Litoměřice", "statutární město Plzeň", "Město Tachov", "Město Mělník", "Statutární město Karlovy Vary", "OBEC BENEŠOV", "Město Sokolov", "Statutární město  Mladá Boleslav", "Obec Písek"),
                                   multiple=TRUE
                       )
                ),
                column(2,
                       dateRangeInput("vybraneDatum",
                                      p("2. Vyber období"),
                                      start="2014-07-01",
                                      end="2014-11-30",
                                      format="d. m. yyyy",
                                      weekstart=1,
                                      language="cs",
                                      separator="až"
                       )
                ),
                column(3,
                       numericInput("cenaMin",
                                    label = p("3. Zadej nejnižší cenu v Kč"),
                                    value = 0,
                                    min = 0,
                                    max = 17819557851,
                                    step = 10000)
                ),
                column(3,
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
        
        br(),
        br(),
        
        dataTableOutput("filtrovanaTabulka"),
        
        br(),
                
        plotOutput("histogram")
        
        
))
        