#indicar el directorio de trabajo
setwd("C:\\Users\\GAIA\\Documents\\RstudioTesis\\A_Leptozona")

# cargar paquete readx
library(readxl)

# buscar la ruta del archivo de excel
file.choose()

# Copiar ruta de la consola y guardar en variable
ruta_excel <- "AlesDEGDiciembre20.xlsx"

# como mirar las hojas de tu excel
excel_sheets(ruta_excel)

#####################################
# 2. importar excel con código de R #
#####################################

# importar datos de los ID para revisar cuales son los datos repetitivos
genesunicos <- read_excel(ruta_excel,
                         sheet = "MaConcat",
                         range = "F1:F993")


#unique nos permite analizar las veces que se repite un dato y te arroja solo 
#los datos que se encuentran una sola ves en formato de tabla "Males"

unique(genesunicos)

#Nombramos la tabla para darle salida 
Genes_Males <- unique(genesunicos)

#en este caso repetimos la accion pero cambiando los datos por datos "Females"
genesunicos2 <- read_excel(ruta_excel,
                           sheet ="FeConcat",
                           range = "e1:e10191")

#volvemos a llamar a unique para el analisis de los datos 
unique(genesunicos2)

#Nombramos nuevamente los datos de salida
Genes_Females <- unique(genesunicos2)

#Para generar otra tabla con los datos repetidos utilizamos la funcion  

duplicated(genesunicos)


