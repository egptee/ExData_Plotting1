
#create plot3.png
createPlot3=function(){
  data<-read.table("./household_power_consumption.txt",sep=";",na.strings="?",header=TRUE,colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),skip=21900,nrows=530000);
  dataname<-read.table("./household_power_consumption.txt",sep=";",na.strings="?",header=TRUE,skip=0,nrows=1);
  #get the first row so as to get the colnames
  dataname<-colnames(dataname);
  
  #subset data to contain only Date = 2007 
  h<-grep("^(1|2)/2/2007",data[,1]);
  data<-data[h,];
  #change character  "Date"  to date type
  m<-paste(data[,1],data[,2])
  m<-strptime(m,"%d/%m/%Y %H:%M:%S")
  m<-as.POSIXct(m);#change class in order to get stored in dataframe
  data[,2]<-m;
  data<-data[,2:9];
  #give the col names
  dataname<-dataname[2:9];
  dataname[1]<-"DateTime";
  colnames(data)<-dataname;
  #open a device
  png(file="./plot3.png",width=480,height=480);
  #begin to plot
  #plot3
  plot(data$DateTime,data$Sub_metering_1,type="l");
  lines(data$DateTime,data$Sub_metering_2,col="red");
  lines(data$DateTime,data$Sub_metering_3,col="blue");
  legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"));
  
  #store plot
  dev.off();
  
}