productmm <- function(matriz,matriz2,n,limite = -1){
  # funcion que calcula multiplicacion matriz con matriz
  
  con.matriz <- file(matriz, "r")
  con.matriz2 <- file(vector, "r")
  
  memoria.limite <- memlimit(limite)
  #saltar el header del csv , de prueba no lo tendrá 
  readLines(con.matriz,1)
  #saltar el header del csv , de prueba no lo tendrá 
  readLines(con.matriz2,1)
  
  
  close(con.matriz,type="r")
  close(con.matriz2,type="r")
}