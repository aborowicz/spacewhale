library(tidyverse)

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
  theme_minimal()
acc_p

los_p<-ggplot(data=res, aes(x=epoch))+
  #geom_line(aes(y=Acc, color=LR))+
  #geom_point(aes(y=Acc, color=LR, shape=model))+
  geom_line(aes(y=Loss, color=LR, linetype=model), size=1)+
  theme_minimal()
los_p

testres<-ggplot(data=res2, aes(x=prec, y=recall))+
  geom_point(aes(color=LR, shape=model))+
  theme_minimal()
testres
