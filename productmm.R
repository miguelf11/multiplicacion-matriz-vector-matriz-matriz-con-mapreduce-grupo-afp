productmm <- function(matriz,matriz2,n,limite = -1){
  # funcion que calcula multiplicacion matriz con matriz
  
  
  
  vxv <- function (vector1,vector2){
    #vector 1 es el vector de la matriz
    #vector 2 es el vector
    sum <- 0
    for (i in 1:length(vector1)){
      sum <- vector1[i] * vector2[i] + sum
    }
    return (sum) 
  }
  
  con.matriz <- file(matriz, "r")
  con.matriz2 <- file(vector, "r")
  
  memoria.limite <- memlimit(limite)
  
  #readLines(con.matriz,1)
  #readLines(con.matriz2,1)
  
  close(con.matriz,type="r")
  close(con.matriz2,type="r")
}