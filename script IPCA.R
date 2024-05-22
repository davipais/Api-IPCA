install.packages("rbcb")
install.packages("lubridate")
require(lubridate)
require(rbcb)


IPCA <- rbcb::get_series(c(IPCA = 433),
                         start_date = "2006-01-01",
                         end_date = "2035-03-31",
                         as = "data.frame")
IPCA=data.frame(data=IPCA$date, ano=year(IPCA$date), mes=month(IPCA$date), IPCA=IPCA$IPCA)


IPCA$Fator=(1+IPCA$IPCA/100)

IPCA$`ÍndiceMultiplicativo`=0

n=length(IPCA[,1])

IPCA$`ÍndiceMultiplicativo`[n]=IPCA$Fator[n]

for (i in I(n-1):1){
  IPCA$`ÍndiceMultiplicativo`[i]=IPCA$`ÍndiceMultiplicativo`[i+1]*IPCA$Fator[i]
}
atual=data.frame(data=Sys.Date(), ano=year(Sys.Date()), mes=month(Sys.Date()),IPCA=0,Fator=1,`ÍndiceMultiplicativo`=1)
IPCA=rbind(IPCA,atual)