wan <-commandArgs(trailingOnly=T)[1]
tu <-commandArgs(trailingOnly=T)[2]
tri <-commandArgs(trailingOnly=T)[3]
uno <- read.table(wan)
dos <-read.table(tu)
dos <- as(dos, "matrix")
uno <- as(uno, "matrix")
claves <- uno[1,]
bu<-seq(1,length(uno)-length(uno[,1]),1)
bu<-matrix(bu, length(uno[,1])-1, length(uno[1,]))
bu<-bu*0
for (i in 1:length(uno[1,])){ bu[,i]<-uno[2:length(uno[,1]),i]}
maximal <- max(bu[length(bu[,1]),])
maximal <- as.numeric(maximal)
tiempo <- seq(0,(length(bu[,1])/2)-(1/2),1/2)
pedefe<-paste(tri,".pdf",sep="")
pdf(pedefe)
plot(tiempo, dos, type="lines", col=rgb(0,1,1/4), ylim=c(0,maximal+(length(bu[1,])*.11)), ylab="DO", xlab="hours",main="Grafica de cepas que crecieron adecuadamente", lty=2)
for (i in 1:length(bu[1,])){ lines(tiempo, bu[,i], col=rgb(1-(i*15/255),i*10/255,i*15/255))
points(tiempo, bu[,i], col=rgb(1-(i*15/255),i*10/255,i*15/255), pch=i)
legend(.2,maximal+(length(bu[1,])*.1)-(i*.1), claves[i], col=rgb(1-(i*15/255),i*10/255,i*15/255), lty=1, bty="n", pch=i)}
legend(.2,maximal+length(bu[1,])*.1, "Wild Type H2O", col=rgb(0,1,1/4), lty=2, bty="n")
dev.off()

