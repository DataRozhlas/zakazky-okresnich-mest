shinyUI(fluidPage(
  
        title="Utrácelo vaše město před volbami víc než jindy?",
        
        h1("Utrácelo vaše město před volbami víc než jindy?"),
        
        p("Aplikace pro interní potřeby Centra zpravodajství ČRo. Datum zakázky je datum, kdy byla uveřejněna ve věstníku veřejných zakázek, obvykle do jednoho měsíce od výběru dodavatele. Proto sledujeme nejen období před volbami, ale i krátce po volbách, kdy se ve věstníku ještě objevují zakázky schválené předchozím zastupitelstvem. Tečkovaná čára značí termín voleb, modře vyznačené je období od začátku září do konce listopadu. Zdroj dat:",
                a("http://www.vsechnyzakazky.cz/",
                  href = "http://www.vsechnyzakazky.cz/data/")),
        
        hr(),
        
        fluidRow(
                
                       selectInput("vybraneMesto",
                                   h5("Vyber město"),
                                   choices=c("HLAVNÍ MĚSTO PRAHA", "Statutární město Brno", "STATUTÁRNÍ MĚSTO LIBEREC", "Město Rakovník", "Statutární město Pardubice", "Město Příbram", "Statutární město Jihlava", "Město Žďár nad Sázavou", "Statutární město Prostějov", "Statutární město Zlín", "Město Rychnov nad Kněžnou", "MĚSTO ČESKÁ LÍPA", "Město Tábor", "Město Náchod", "MĚSTO UHERSKÉ HRADIŠTĚ", "Město Kutná Hora", "Statutární město Frýdek-Místek", "Město Kolín", "Město Semily", "Město Nový Jičín", "Město Klatovy", "MĚSTO BLANSKO", "Město Vsetín", "Město Svitavy", "Statutární město Ostrava", "Statutární město Olomouc", "Město Ústí nad Orlicí", "Město Louny", "STATUTÁRNÍ MĚSTO MOST", "Statutární město Ústí nad Labem", "Město Jičín", "Město Znojmo", "Město Pelhřimov", "Statutární město Jablonec nad Nisou", "Město Trutnov", "Město Chrudim", "STATUTÁRNÍ MĚSTO DĚČÍN", "MĚSTO KROMĚŘÍŽ", "Město  Nymburk", "Město Jeseník", "Město HODONÍN", "Statutární město České Budějovice", "Město Domažlice", "Statutární město Kladno", "Město Vyškov", "Město Šumperk", "STATUTÁRNÍ MĚSTO TEPLICE", "MĚSTO PRACHATICE", "STATUTÁRNÍ MĚSTO CHOMUTOV", "Město Písek", "Statutární město Hradec Králové", "Město Benešov", "STATUTÁRNÍ MĚSTO KARVINÁ", "MĚSTO TŘEBÍČ", "Město Bruntál", "Statutární město Opava", "Město Strakonice", "MĚSTO HAVLÍČKŮV BROD", "Město Rokycany", "Obec Písek", "Statutární město Přerov", "Město Český Krumlov", "Město Cheb", "MĚSTO BŘECLAV", "Město Beroun", "Město Jindřichův Hradec", "Město Litoměřice", "statutární město Plzeň", "Město Tachov", "Město Mělník", "Statutární město Karlovy Vary", "OBEC BENEŠOV", "Město Sokolov", "Statutární město  Mladá Boleslav", "Obec Písek")
                
                )
                
        ),
        
        br(),
                
        plotOutput("graf"),
        
        textOutput("shrnuti")
              
))