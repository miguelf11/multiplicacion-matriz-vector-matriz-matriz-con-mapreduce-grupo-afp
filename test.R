setwd("C:/Users/Alex/Documents/R/Proy_ICD/multiplicacion-matriz-vector-matriz-matriz-con-mapreduce-grupo-afp")

source("productmm.R")
source("productmv.R")

matriz <- "datos/tblAkv3x3.csv"
vector <- "datos/tblxkv3.csv"


productmm(matriz,matriz,3,limite = 500)

productmv(matriz,vector,3,limite = 500)
