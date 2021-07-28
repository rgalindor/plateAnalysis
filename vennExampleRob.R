choro<-rnorm(34*3)
dododo<-choro*0
for (i in 1:length(choro)){
if(choro[i]>0){
dododo[i]<-1
}
else{
dododo[i]<-0
}
}
dododo<-matrix(dododo,34,3)
dododo<-as.table(dododo)
colnames(dododo)<-c("catalitica","regulacion","estructural")
vennDiagram(dododo, counts.col="red", circle.col=c("green","cyan","pink"),main="genes")
legend(1,-2.5, "unknow",bty="n")
