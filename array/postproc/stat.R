require(ggplot2)
data = read.table("fort.9",col.names = c("time","CFL","drag","lift","dragf","liftf"))
l = length(data$time)
n = 2000
j = round(seq(30,l,len=min(l,n)))
data = data[j,]
CFL = qplot(time,CFL,data=data,geom="line")
t = 0.5*(min(data$time)+max(data$time))
late = subset(data,time>t)
mdrag = mean(late$drag+late$dragf)
adrag = mad(late$drag+late$dragf)
mlift = mean(late$lift+late$liftf)
alift = mad(late$lift+late$liftf)
drag = qplot(time,drag,data=data,geom="line")
drag = drag+geom_line(aes(y=dragf),color='red')
y = (mdrag+adrag)*1.2
drag = drag+annotate("text",x=t,y=y,label=paste("mean=",round(mdrag,4)," amp=",round(adrag,4)))
lift = qplot(time,lift,data=data,geom="line")
lift = lift+geom_line(aes(y=liftf),color='red')
y = (mlift+alift)*1.2
lift = lift+annotate("text",x=t,y=y,label=paste("mean=",round(mlift,4)," amp=",round(alift,4)))

ppdf = function(plot,name){
     pdf(name,8,4)
     print(plot)
     dev.off()
}

ppdf(CFL,"CFL.pdf")
ppdf(drag,"drag.pdf")
ppdf(lift,"lift.pdf")

data = read.table("mgs.txt", col.names = c("itr","res"))

l = length(data$itr)
n = 2000
data$i = seq(1,l)
j = round(seq(1,l,len=min(l,n)))
#j = unique(c(which(data$itr>1),j))
data = data[j,]

itr = qplot(i,log(itr,2),data=data)+ylab(expression(log[2](iteration)))
res = qplot(i,log(res,10),data=data)+ylab(expression(log[10](residual)))
ppdf(itr,"itr.pdf")
ppdf(res,"res.pdf")

source('analysis.R')
