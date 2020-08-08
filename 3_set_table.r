#este script realiza una tabla a partir de  CORDENADAS 
#MENSUALES en base a los archivos existentes en La carpeta prcp

library(tibbletime) 

#ruta de prco
ruta_prcp <- 'prcp20per1980-2017'
ruta_tmp <- 'temp20per1980-2017'
#lista de estaciones
lista_prcp <- dir(ruta_prcp, pattern = '_prcp.txt')
lista_temp <- dir(ruta_tmp, pattern = '_tmp.txt')

#como base seran prcp y temp

lista_t <- c()
prcp_names <- c() 
tmp_names  <- c()

for (archivo_prcp in lista_prcp) {
  name_prcp <-  gsub('_prcp.txt','', archivo_prcp)
  prcp_names <- append(prcp_names ,  name_prcp)
  
  for(archivo_tmp in lista_temp){
    name_tmp <-  gsub('_tmp.txt','', archivo_tmp)
    
    if(name_tmp == name_prcp){
      lista_t <- append(lista_t, 'True')
      #aniadir a lista de tmp
      tmp_names <- append(tmp_names, name_tmp)
      }
  }
}

if(length(lista_t) == length(lista_temp)){
   print('Todos los nombre de TMP existen en PRCP')
  }else{
   print('Revisa los nombres o la lista')
   break
}

#%%%%%%%%%%%%%5%%%%%%%%%%%%%%%%%%%%%%%%

df <- read.csv('CORDENADAS_MENSUALES.csv', header = T )

n <- length(df$Estacion)


c_prcp <-c()
df3 <- data.frame()

tmp_vect <- rep(NA, length(prcp_names))
for(j in seq(length(prcp_names))){
    for(name_tmp in tmp_names){
      if(name_tmp == prcp_names[j] ){  
       tmp_vect[j] <- TRUE  
    }
  }}


for(i in seq(n)){
  name_base <- as.character(df[i,]$Estacion[1])
  for(j  in seq(length(prcp_names))){
     
      if(prcp_names[j] == name_base){
         df_i <- df[i,]
         df_i['es_tmp'] <- tmp_vect[j] 
         df3 <-rbind(df_i, df3)
        } 
    }
}


df3 <- df3[order(df3$Estacion, decreasing = F), ]

# Guardar resultados 
write.table(df3, file='tabla_cordenadas.txt', col.names=T, row.names=F, sep='\t')

print('La OPERACION SE REALIZO CORRECTAMENTE :D')



