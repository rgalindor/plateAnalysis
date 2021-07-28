#archivo<-commandArgs(trailingOnly=T)[1]
#denopt<-read.table(archivo, header=TRUE)

#obtener un patron desde la linea principal generando un arreglo
#con los archivos de la carpeta que cumplan con la presencia del
#patron en su nombre
#patronsito<-commandArgs(trailingOnly=T)[1]
#seis<-ATENCION!!!!!!!! el nombre del output
seis<-"areas.txt"
patroncito<-"headed"
filosos<-list.files(pattern=patroncito)
#concatenado de archivos:
denopt<-NULL
for(i in 1:length(filosos)){
#	denopt<-c(denopt,read.table(filosos[i],header=FALSE))
	denopt<-c(denopt,read.table(filosos[i],header=TRUE))
}
#area bajo la curva obtenida por el metodo de los trapecios
#NOTA: hace falta acotar el area de cada trapecio por el tamano
#      del intervalo de tiempo, quiza estandarizar a 1
areas<-rep(0,length(denopt))
areas1<-areas
areas2<-areas
tampuntos<-length(denopt[[1]])
mita<-(tampuntos+1)%/%2
for(j in 1:length(denopt)){
	for(i in 2:tampuntos){
		areas[j]<-areas[j]+(denopt[[j]][i]+denopt[[j]][i-1])/2
		if(i==mita){
			areas1[j]<-areas[j]
		}
	}
	areas2[j]<-areas[j]-areas1[j]
}
names(areas)<-names(denopt)
#concatenar e imprimir
#cat(colnames(opt_dens[(i*2)-1]),"\n",file=seis, append=bandera)
for(i in 1:length(areas)){
	bandera = i>1
	linea<-paste(names(areas)[i],areas[i],areas1[i],areas2[i],sep=",")
	cat(linea,"\n",file=seis,append=bandera)
#	cat(paste(names(areas)[i],areas[i],sep=","),"\n",file=seis, append=bandera)
}
#barplot(areas,las=2)
#boxplot(areas)

