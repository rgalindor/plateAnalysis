wan <-commandArgs(trailingOnly=T)[1]
tu <-commandArgs(trailingOnly=T)[2]
tri<-commandArgs(trailingOnly=T)[3]
four <-commandArgs(trailingOnly=T)[4]
fai <-commandArgs(trailingOnly=T)[5]
uno <- read.table(wan)
dos <-read.table(tu)
tres<-read.table(tri)
tres<- as(tres,"matrix")
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
#length(tiempo)
#length(dos)
pedefe<-paste(four,".pdf",sep="")
pdf(pedefe)
plot(tiempo, dos[1:47], type="lines", col=rgb(0,1,1/4), ylim=c(0,maximal+(length(bu[1,])*.11)), ylab="DO", xlab="hours",main="Grafica de cepas que crecieron adecuadamente", lty=2)
lines(tiempo, tres[1:47], type="lines", col=rgb(0,1/8,1/10), lty=2)
for (i in 1:length(bu[1,])){ lines(tiempo, bu[,i], col=rgb(1-(i*15/255),i*10/255,i*15/255))
points(tiempo, bu[,i], col=rgb(1-(i*15/255),i*10/255,i*15/255), pch=i)
legend(.2,maximal+(length(bu[1,])*.1)-(i*.1), claves[i], col=rgb(1-(i*15/255),i*10/255,i*15/255), lty=1, bty="n", pch=i)}
legend(.2,maximal+length(bu[1,])*.1, "Wild Type H2O", col=rgb(0,1,1/4), lty=2, bty="n")
legend(.2,(maximal+length(bu[1,])*.1)+(.1), "Wild Type PT1", col=rgb(0,1/8,1/10), lty=2, bty="n")
dev.off()

####parte de areas
##
area<-seq(1,length(bu[1,]),1)
area<-area*0
#bu[1,1]
#bu[2,3]
length(bu[1,]) #####bu[cosa,$variable]
length(bu[,1]) #####bu[$variable,cosa]
for(j in 1:length(bu[1,])){
	for(i in 2:length(bu[,1])){
	#	bu[j,i]
	#	bu[i,j]
		area[j]<-area[j]+((as.numeric(bu[i,j])+as.numeric(bu[i-1,j]))/4)
	}
}
wth<-0
wtp<-0
for(i in 2:length(dos)){
	wth<-wth+((dos[i]+dos[i-1])/4)
	wtp<-wtp+((tres[i]+tres[i-1])/4)
}
cala<-paste(fai,".pdf","")
pdf(cala)
maximo<-max(area)
maximos<-c(wth,maximo)
maximo<-max(maximos)
barplot(area,col="blue",names.arg=claves,cex.names=0.5,ylim=c(-1,maximo+3),main="Cepas que tienen crecimiento adecuado",xlab="\nCepas\nMetodo de los trapecios: area=intervalo de tiempo*(DO[i]+DO[i-1])/2",ylab="Area bajo la curva")
abline(h=wtp,lty=5,col="red")
abline(h=wth,lty=3, col="red")
dev.off()
