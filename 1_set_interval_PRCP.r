#ESTE SCRITP SELECCIONA LOS INTERVALOS 1980-2017 
library(tibbletime)  #filter date time

#ruta de prco
ruta_prcp <- 'prcp'
#ruta salida
out <- 'prcp20per1980-2017f'


#lista de estaciones
lista_est <- dir(ruta_prcp, pattern = '_prcp.txt')

#Vector vacio para porecentaje
na_porc <- c()
name_porc <- c()
for(archivo in lista_est){
  name_est <- gsub('_prcp.txt','', archivo)

  df <- read.table(paste(ruta_prcp,'/' ,archivo, sep=''), header = F)
  colnames(df) <- c('yy','mm','prcp')

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
    df2<- df2[, c('yy','mm','time', 'prcp')]
    
    #convertir -100 a na y conteo
    df2$prcp[df2$prcp == -100] <- NA
    #el multiplo 2.54 convertira en mm
    df2['prcp'] <- df2$prcp*2.54
    
    na_tot <-  sum(is.na(df2$prcp))
    porcentaje <- (na_tot/n)*100
  
    if(porcentaje <= 20){
      write.table(df2, file=paste(c(out,archivo),collapse='/'), col.names=F, row.names=F, sep='\t')
      
      #almacenar en porcentajes
      na_porc <- append(na_porc, porcentaje)
      name_porc <- append(name_porc, name_est)
    } 
    
  }
  
}

df3 <- data.frame(name_porc, na_porc)
write.table(df3, file='prcp_NAS_20percent.txt', col.names=F, row.names=F, sep='\t')

print('La OPERACION SE REALIZO CORRECTAMENTE :D')



