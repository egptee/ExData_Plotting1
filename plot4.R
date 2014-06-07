
#create plot4.png
createPlot4=function(){
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
  png(file="./plot4.png",width=480,height=480);
  #begin to plot
  par(mfcol = c(2,2));
  #plot2
  plot(data$DateTime,data$Global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)",main="");
  #plot3
  plot(data$DateTime,data$Sub_metering_1,type="l");
  lines(data$DateTime,data$Sub_metering_2,col="red");
  lines(data$DateTime,data$Sub_metering_3,col="blue");
  legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"));
  #plot4 voltage
  plot(data$DateTime,data$Voltage,type="l",ylab="Voltage",xlab="datetime");
  #plot5 reactive
  plot(data$DateTime,data$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")
  
  #store plot
  dev.off();
  
  #
  
}