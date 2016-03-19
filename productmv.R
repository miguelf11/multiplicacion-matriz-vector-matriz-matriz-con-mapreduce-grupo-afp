productmv <- function(matriz,vector,n,limite = -1 ){
  con.matriz <- file(matriz, "r")
  con.vector <- file(vector, "r")
  
  memoria.limite <- memlimit(limite)
  
  #saltar el header del csv , de prueba no lo tendrá 
  readLines(con.matriz,1)
  #saltar el header del csv , de prueba no lo tendrá 
  readLines(con.vector,1)
  
  close(con.matriz,type="r")
  close(con.vector,type="r")

}