library(genArise)

filosos<-paste(getwd(),"/",list.files(),"/",list.files(), sep="")
filososos<-paste(filosos,".txt", sep="")
repris<-paste(list.files(),".rep", sep="")
sobres<-paste(list.files(),".exp", sep="")

for(j in 1:length(filosos)){
	print(paste("j =",j))
	mic1<-NULL
	mic1<-read.spot(filososos[j],cy3=10,cy5=11,bg.cy3=12,bg.cy5=13,ids=7,header=FALSE,sep="\t",is.ifc=FALSE)
	mic1<-bg.correct(mic1)
	mic1<-global.norm(mySpot=mic1)
	mic1<-filter.spot(mySpot=mic1)
	mic1<-spotUnique(mySpot=mic1)
	mic1<-Zscore(mic1,type="ri")
	rep1<-mic1@dataSets$Id[mic1@dataSets$Zscore < -2]
	exp1<-mic1@dataSets$Id[mic1@dataSets$Zscore > 2]
	
	
	for(i in 1:length(rep1)){
		bandera=i>1
		cat(rep1[i],"\n",file=repris[j],append=bandera)
	}
	for(i in 1:length(exp1)){
		bandera=i>1
		cat(exp1[i],"\n",file=sobres[j],append=bandera)
	}
}

