# este script es principalmente un borrador para ir probando
# las funciones.

productmv <- function(matriz,vector,n,limite = -1 ){
  con.matriz <- file(matriz, "r")
  con.vector <- file(vector, "r")
  close(con.matriz,type="r")
  close(con.vector,type="r")
  if (limite != -1){
    
  }
}

  
productmm <- function(matriz,matriz2,n,limite = -1){
  # funcion que calcula multiplicacion matriz con matriz
  
  con.matriz <- file(matriz, "r")
  readLines(con.matriz,1) #saltar el header del csv , de prueba no lo tendrá 
  con.matriz2 <- file(vector, "r")
  readLines(con.matriz2,1) #saltar el header del csv , de prueba no lo tendrá
  mem <- memlimit(limit)
  
  close(con.matriz,type="r")
  close(con.matriz2,type="r")
}
  

con <- file("tblAkv10x10ident.csv", "r")
readLines(con,1) #saltar el header del csv , de prueba no lo tendrá
terminado = TRUE

#todas las lineas tendrán el mismo tamaño que el primero.

a <- readLines(con,1)
a

b <- readLines(con,1)
b
close(con,type="r")
object.size(b)  #104 bytes

c <- gsub("\\D", " ", b)
c
object.size(c)  #104 bytes

object.size(productmm) 

vector <- unlist(strsplit(c," "))
vector <- as.integer(vector[vector != ""])

# tiene 56 bytes



p <-memory.limit()



# Se busca tratar de dividir las matrices en trozos que no pesen
# mas de cierta cantidad de M cantidad de Mb, dividirlos, procesarlos y almacenar
# solo el resultado




# rm sirve para eliminar variables del workspace

# object.size(tblxkv10) retorna el tamaño de la variable en bytes 

# memory.limit() devuelve el limite de memoria en para R en Mb(1048576 bytes)

# memory.size() devuelve la cant de memoria en uso actualmente

# 

# funcion que calcula multiplicacion matriz con vector