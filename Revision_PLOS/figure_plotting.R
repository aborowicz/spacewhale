library(tidyverse)
## Colorblind color palette
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#CC79A7", "#0072B2", "#D55E00","#F0E442" )

#res<-read.csv('C:\\Users\\Starship\\Google Drive\\Projects\\Space Whales\\model_results\\example_res.csv')
res<-read.csv('C:\\Users\\Starship\\Desktop\\GitHub\\spacewhale\\Revision_PLOS\\train_model_results.csv')
res2<-read.csv('C:\\Users\\Starship\\Desktop\\GitHub\\spacewhale\\Revision_PLOS\\test_model_results.csv')

res$LR<-as.factor(res$LR)
res2$LR<-as.factor(res2$LR)
p<-ggplot(data=res, aes(x=seq(1,length(res$tp))))+
  #geom_point(aes(y=acc, x=seq(1,length(res$tp))))+
  #geom_point(aes(y=tn), color='blue')+
  #geom_point(aes(y=tp), color='red')+
  geom_line(aes(y=acc), color='red')+
  geom_line(aes(y=loss), color='blue')+
  theme_minimal()+
  labs(x='Epoch', y='')


p

### This one plots each model train as a line.
### There's a diff color for each LR, diff line type for each architect

acc_p<-ggplot(data=res, aes(x=epoch))+
  #geom_line(aes(y=Acc, color=LR))+
  #geom_point(aes(y=Acc, color=LR, shape=model))+
  geom_line(aes(y=Acc, color=LR, linetype=model), size=1)+
  theme_minimal()+
  scale_colour_manual(values=cbPalette)
acc_p

los_p<-ggplot(data=res, aes(x=epoch))+
  #geom_line(aes(y=Acc, color=LR))+
  #geom_point(aes(y=Acc, color=LR, shape=model))+
  geom_line(aes(y=Loss, color=LR, linetype=model), size=1)+
  theme_minimal()+
  scale_colour_manual(values=cbPalette)
los_p

testres<-ggplot(data=res2, aes(x=prec, y=recall))+
  geom_point(aes(color=LR, shape=model), size=3)+
  theme_minimal()+
  scale_colour_manual(values=cbPalette)
testres


########### Confusion matrix
# c() for each is tp,tn,fp,fn where tp is a true water, tn is a true whale
confu_dat<-read.csv('C:\\Users\\Starship\\Desktop\\GitHub\\spacewhale\\Revision_PLOS\\confusion_data.csv')
confu_dat$lr<-as.factor(confu_dat$lr)
confu_dat$lab<-as.factor(confu_dat$lab)
confu_dat$pred<-as.factor(confu_dat$pred)

ggplot(data =  confu_dat[which(confu_dat$mod=='densenet' & confu_dat$lr=='0.001'),], aes(x = lab, y = pred)) +
  geom_tile(aes(fill = val), colour="black") +
  geom_text(aes(label = sprintf("%1.0f", val)), vjust = 1) +
  scale_fill_gradient(low = "white", high = "white") +
  theme_bw() + theme(legend.position = "none")+
  xlab("True Class")+
  ylab("Predicted Class")

den001<-c(1281,31,1,109)
den01<-c(1015,28,4,375)
den1<-c(714,29,3,676)
r18_0009<-c(1296,32,0,94)
r18_001<-c(1257,32,0,3)
r18_01<-c(1129,26,6,261)
r32_01<-c(1295, 19, 13, 95)