shinyUI(fluidPage(
  
        title="Utrácelo vaše město před volbami víc než jindy?",
        
        h1("Utrácelo vaše město před volbami víc než jindy?"),
        
        p("Aplikace pro interní potřeby Centra zpravodajství ČRo. Datum zakázky je datum, kdy byla uveřejněna ve věstníku veřejných zakázek, obvykle do jednoho měsíce od výběru dodavatele. Proto sledujeme nejen období před volbami, ale i krátce po volbách, kdy se ve věstníku ještě objevují zakázky schválené předchozím zastupitelstvem. Tečkovaná čára značí termín voleb, modře vyznačené je období od začátku srpna do konce listopadu. Zdroj dat:",
                a("http://www.vsechnyzakazky.cz/",
                  href = "http://www.vsechnyzakazky.cz/data/")),
        
        hr(),
        
                
        selectInput("vybraneMesto",
                    h5("Vyber město"),
                    choices=c("Ústí nad Labem", "Beroun", "Kolín", "Karviná", "Rokycany", "Jičín", "Šumperk", "Jeseník", "Frýdek-Místek", "Trutnov", "Uherské Hradiště", "Tábor", "Prachatice", "Semily", "Náchod", "Chrudim", "Rakovník", "Svitavy", "Tachov", "Znojmo", "Liberec", "Mladá Boleslav", "Kroměříž", "Hodonín", "Karlovy Vary", "Pardubice", "Vyškov", "Přerov", "České Budějovice", "Most", "Havlíčkův Brod", "Blansko", "Prostějov", "Strakonice", "Bruntál", "Brno", "Kladno", "Žďár nad Sázavou", "Vsetín", "Mělník", "Písek", "Ostrava", "Jablonec nad Nisou", "Příbram", "Opava", "Pelhřimov", "Zlín", "Sokolov", "Domažlice", "Plzeň", "Děčín", "Benešov", "Břeclav", "Český Krumlov", "Kutná Hora", "Česká Lípa", "Ústí nad Orlicí", "Jindřichův Hradec", "Olomouc", "Praha", "Cheb", "Nymburk", "Hradec Králové", "Jihlava", "Louny", "Třebíč", "Klatovy", "Chomutov", "Nový Jičín", "Teplice", "Litoměřice", "Rychnov nad Kněžnou")
                    ),
        
        br(),
                
        plotOutput("graf"),
        
        textOutput("shrnuti")
              
))