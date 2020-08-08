# 1. Homogenizacion_Bolivia 3 de ago 2020
En este primer proceso se realiza un filtrado de las estaciones de Prcp (precipitacion) y  tmp (temperatura max y  min).

Las estaciones con datos faltantes mayor a 20% seran descartadas tanto para Prcp y Tmp para un intervalo de 1980-2017 (38años).

En el siguiente link de nube se encuentran las estaciones ya filtradas para TMP y PRCP:\
https://yadi.sk/d/48VlTrv22CovJg
 
 103 estaciones de prcp\
 66 estaciones de tmp 
 
Los datos aucentes sinbolizadas con "NA".

- Los siguientes Scripts utilizadas para obtener cierto intervalo y el porcentaje de datos ausentes. \
 1_set_interval_PRCP.r \
 2_set_interval_TMP.r
- Los siguientes archivos tienen el nombre de la estacion y el porcentaje de datos aucentes.\
 prcp_NAS_20percent.txt\
 tmp_NAS_20percent.txt

Los siguientes ficheros finales ejemplo de Prcp y Tmp: \
 Abapo_prcp.txt  \
 Arani_tmp.txt 

## 1.1 La siguiente tarea:
Realizar una tabla como tu ex, con  columnas:\
[Latitud, Longitud, Altura, Nombre, Codigo, var_PRCP, var_Tmax, var_Tmin] 

Para ello se tiene el siguinte Archivo o tabla:\
CORDENADAS MENSUALES.csv 
Se debe extraer solo los nombres con datos ausentes <= 20% del resultado anterior. \
Esta tabla se realiza para representar datos de manera espacial: \
Ejemplo: Precipitacion acumulada anual, etc, y otros resultados.

**Uno de los codigos que realiza esta operacion es:**\
3_set_table.r \

Con entrada: (CORDENADAS_MENSUALES.csv), y los archvos de de PRCP y TMP de la nume rusa. Como resultado se obtine: \
tabla_cordenadas.txt 

## 1.2 La siguiente tarea para el lunes:
- Revisar algoritmos de agrupacion de datos espaciales.(para empezar K-means y DBSCAN) \
- Primero se debe agrupar para luego preparar los archivos .dat y .txt por cada grupo o region.
- A partir de "tabla_cordenadas.txt" y una cantidad de estaciones de la nube-rusa (unos 5) realizar un codigo en Python o R que da como resultado 
  a (.est) y (.dat) mensuales.
- Tambien luis realiza una expocicion.




