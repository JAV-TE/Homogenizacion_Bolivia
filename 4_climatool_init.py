#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from os import listdir


# In[174]:


#carpeta de entrada para prcp
in_prcp = '/home/Physics/Proyectos/homo_conclimatool/preprocesing_data/estaciones_deprueba'
out_prcp = '/home/Physics/Proyectos/homo_conclimatool/preprocesing_data/prcp_climatol/'
#carpeta de entrda para tmp
#in_tmp = '/home/Physics/Proyectos/homo_conclimatool/preprocesing_data/temp20per1980-2017'
#out_tmp = '/home/Physics/Proyectos/homo_conclimatool/preprocesing_data/tmp_climatol/'


# In[178]:


lista=listdir(in_prcp)
lista = [i for i in lista if 'prcp.txt' in  i]


# In[179]:


file = '/home/Physics/Proyectos/homo_conclimatool/preprocesing_data/tabla_cordenadas.txt'
df2 = pd.read_csv(file, header = 0,  delimiter = '\t')


# In[180]:


#crear listas vacias para prcp
lon_c =  []
lat_c =  []
alt_c =  []
code_c = []
name_c = [] 
matrix_c = []

#create loop
for archivo in lista :
    ruta_archivo = in_prcp+'/'+archivo
    df = pd.read_csv(ruta_archivo, header = None, delimiter = '\t')
    df.columns = ['yy','mm','fechas','prcp']
    
    #vector 1d
    vect_p = df['prcp'].values
    matrix_c = np.append(matrix_c, vect_p)
     
    #almacenar nombres cordenadas y codigos
    name = archivo.replace('_prcp.txt','')
    #debo buscar el nombre en al df2
    lon = df2[df2['Estacion']==name]['Longitud'].values[0]
    lat = df2[df2['Estacion']==name]['Latitud'].values[0]
    alt = df2[df2['Estacion']==name]['Elevacion'].values[0]
    codigo =df2[df2['Estacion']==name]['CODIGO'].values[0]
    
    #almacenamos a medida que corre el loop
    lon_c.append(lon)
    lat_c.append(lat)
    alt_c.append(alt)
    code_c.append(codigo)
    name_c.append(name)


# In[182]:


#covertimos matrix en dataframe .dat
matrix = matrix_c.reshape(int(len(matrix_c)/12),12) #convertir a matrix
np.savetxt(out_prcp +'Ttest-m_1980-2017.dat', matrix,fmt = '%.3f' ,delimiter = ' ') #'%.3f 3 decimales'


# In[183]:


#guardar en data drame en pandas
pest = pd.DataFrame({'lon':lon_c , 'lat' :lat_c, 'alt':alt_c , 'code':code_c, 'name':name_c })


# In[184]:


np.savetxt(out_prcp +'Ttest-m_1980-2017.est', pest.values,fmt = ['%.3f', '%.3f', '%.1f','%s',"%s"] ,delimiter = ',') #'%.3f 3 decimales'


# In[199]:


pest.to_csv(out_prcp +  '000_borrar.csv', index = False, header = False, sep = ',')

