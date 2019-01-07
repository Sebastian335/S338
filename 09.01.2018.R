###############################################################################################################
########################R-Projekt##############################################################################
######2.5 Aufgabe 5: Bestandteile des EuroStoxx50-Index (Teil II)###############################################

###Löschen von alter Environment###

rm(list = ls(underlyings))

###Einlesen von csv Datei###

getwd()
setwd("/Users/sebastianmayer/Desktop/Empirische Wirtschafts- und Finanzanalyse")
Doc1 <- read.csv("STOXX50E_001.csv")

###Ändern des Spaltennamens, da beim Import der csv Datei das ^ in ein X umgewandelt wurde###

colnames(Doc1) <- "^STOXX50E"
View(Doc1)

###character Vektor###

(underlyings <- c("^STOXX50E", "ALV.DE", "G.MI", "BMW.DE", "SU.PA", "ENI.MI", "IBE.MC", "ORA.PA", "DBK.DE",
                 "BAYN.DE", "ENEL.MI", "AI.PA", "DTE.DE", "BN.PA", "SAF.PA", "BBVA.MC","PHIA.AS", 
                 "OR.PA", "ASML.AS", "DPW.DE", "AIR.PA", "BNP.PA", "INGA.AS", "ENGI.PA", "ABI.BR", 
                 "EI.PA", "SAN.PA", "CA.PA", "ITX.MC", "MC.PA", "FRE.DE"))


######2.6 Aufgabe 6: Quantmod-Package (II) (Teil II)#############################################################

###Diese Funktionen sind eigentlich für Windows. Das Quantmod-Paket konnte zuerst nicht runtergelaaden werden###
###Es gab Fehlermeldungen zur Kapazitätsgrenze des Mac OS Betriebssystems###
###Nach Anwendnung dieser Funktionen funktionierte der Download###

memory.size(size=2500)
memory.limit(size=2500)

###Installieren von Quantmod-Paket inklusive der Zusatzpakete###

install.packages("quantmod", dependencies = TRUE)
library("quantmod")

###Eingabe des Befehls getSymbols###

getSymbols(underlyings, from="2016-01-01", to="2019-01-08")


###im Internet gefunden###
my_data <- lapply(underlyings, function (underlyings) na.omit(getSymbols(underlyings, auto.assign = FALSE)))
names(my_data) <- underlyings
sapply(my_data, function (x) sum(is.na(x)))

###Erhöhen der Output Kapazität von R, da zuvor nicht alle Werte ausgegeben werden konnten###

options(max.print=10000)

######Bereinigung der NA Datenfelder aus den Zeitreihen mit missing values###########################

###Datensätze mit missing values. Diese wurden nach dem Ausführen der getSymbols Funktion in der Console ausgegeben###

SAN.PA
SU.PA
ASML.AS
SAF.PA

###Es wird nochmal abgefragt, ob missing values vorhanden sind. Ist dies der Fall, wird TRUE ausgegeben###

any(is.na(SAN.PA))
any(is.na(SU.PA))
any(is.na(ASML.AS))
any(is.na(SAF.PA))
any(is.na(FRE.DE))


###Löschen der missing values Felder###

SAN.PA_1 <- na.omit(SAN.PA)
SU.PA_1 <- na.omit(SU.PA)
ASML.AS_1 <- na.omit(ASML.AS)
SAF.PA_1 <- na.omit(SAF.PA)
FRE.DE_1 <- fun.zero.omit(FRE.DE)   ###das geht noch nicht*!*!*!*!*''######

###Erhöhen der Output Kapazität von R, da zuvor nicht alle Werte ausgegeben werden konnten###

options(max.print=1000000)

###Verwendung des cbind Befehls zum Erstellen einer einzigen Tabelle aus den 31 R-Objekten###

cbind(ALV.DE,G.MI,BMW.DE,SU.PA_1,ENI.MI,IBE.MC,ORA.PA,DBK.DE,BAYN.DE,ENEL.MI,AI.PA,DTE.DE,BN.PA,SAF.PA_1,
      BBVA.MC,PHIA.AS,OR.PA,ASML.AS_1,DPW.DE,AIR.PA,BNP.PA,INGA.AS,ENGI.PA,ABI.BR,EI.PA,SAN.PA_1,CA.PA,ITX.MC,
      MC.PA,FRE.DE_1)

######2.7 Aufgabe 7: Chartseries (Teil II)#############################################################

###Tägliche Amazon Aktienkurse zwischen dem angegebenen Zeitraum### 
getSymbols("AMZN", from="2010-01-01", to="2019-01-08")

###barChart###
barChart(AMZN, theme="white.mono",bar.type="hlc")

###barChart wird um simple moving average + Exponentially weighted moving average erweitert###
addSMA()
addEMA()


###candlechart###
candleChart(AMZN, multi.col=TRUE,theme="white")

###candleChart wird um simple moving average + Exponentially weighted moving average erweitert###
addSMA()
addEMA()

###lineChart###
lineChart(AMZN, line.type="h",TA=NULL)

###lineChart wird um volume chart + simple moving average + Exponentially weighted moving average erweitert###

addVo()
addSMA()
addEMA()


