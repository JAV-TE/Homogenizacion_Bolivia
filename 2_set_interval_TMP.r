#ESTE SCRITP SELECCIONA LOS INTERVALOS 1980-2017 
library(tibbletime)  #filter date time

#ruta de prco
ruta_prcp <- 'tmp'
#ruta salida (carpeta)
out <- 'temp20per1980-2017'


#lista de estaciones
lista_est <- dir(ruta_prcp, pattern = '_tmp.txt')

#Vector vacio para porecentaje
na_porc  <- c()
na_porc0 <- c()

name_porc <- c()
for(archivo in lista_est){
  name_est <- gsub('_tmp.txt','', archivo)

  df <- read.table(paste(ruta_prcp,'/' ,archivo, sep=''), header = F)
  colnames(df) <- c('yy','mm','zero','prcp','tmax','tmin')

  #inicial y final anio datetim
  n <- length(df$yy)

  yy0 <- df$yy[1]
  mm0 <- df$mm[1]
  yyf <- df$yy[n]
  mmf <- df$mm[n]

  date0 <- paste(as.character(yy0),'/',as.character(mm0),'/1', sep = '')
  datef <- paste(as.character(yyf),'/',as.character(mmf),'/1', sep = '')
  # generamos date time vector
  date_time <- seq(as.Date(date0), as.Date(datef), "month")

  df['time'] <- date_time
  
  
  if(yy0 <= 1980 & yyf >= 2017  ){
    
    #crear un nuevo data frame
    df2 <- filter(df, time >= as.Date('1980/01/01') & time <= as.Date('2017/12/01'))
    df2<- df2[, c('yy','mm','time', 'tmax','tmin')]
    
  
    #convertir -100 a na y conteo
    df2$tmax[df2$tmax == -100] <- NA
    df2$tmin[df2$tmin == -100] <- NA
    #el multiplo 2.54 convertira en mm
    #df2['prcp'] <- df2$prcp*2.54
    
    na_tot <-  sum(is.na(df2$tmax))
    na_tot0 <-  sum(is.na(df2$tmin))
    porcentaje <- (na_tot/n)*100
    porcentaje0 <- (na_tot0/n)*100
    
    
    
    
    if(porcentaje <= 20 & porcentaje0 <= 20){
      write.table(df2, file=paste(c(out,archivo),collapse='/'), col.names=F, row.names=F, sep='\t')
      
      #almacenar en porcentajes
      na_porc <- append(na_porc, porcentaje)
      na_porc0 <- append(na_porc0, porcentaje0)
      
      name_porc <- append(name_porc, name_est)}
  }
}


df3 <- data.frame(name_porc, na_porc, na_porc0)
write.table(df3, file='tmp_NAS_20percent.txt', col.names=F, row.names=F, sep='\t')

print('La OPERACION SE REALIZO CORRECTAMENTE :D')



