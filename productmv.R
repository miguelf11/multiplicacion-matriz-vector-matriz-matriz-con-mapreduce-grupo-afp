source ("others.R")

productmv <- function(matriz,vector,n,limite = -1 ){
  
  con.matriz <- file(matriz, "r")
  con.vector <- file(vector, "r")
  
  tam.matriz <- object.size(readLines(con.matriz,1))
  
  tam.vector <- object.size(readLines(con.vector,1))
  
  
  close(con.matriz,type="r")
  close(con.vector,type="r")
  
  
  
  memoria.limite <- memlimit(limite)
  
  
  #cantidad de N que puedo leer
  maximo.leer.matriz = as.integer(memoria.limite %/% tam.matriz) / 2
  
  #vuelvo a abrir la coneccion 
  con.matriz <- file(matriz, "r")
  con.vector <- file(vector, "r")
  
  
  con.resultado <- file("resultado_vector.csv", "w")
  #si cabe el vector en la RAM
  if (maximo.leer.matriz > n){
    # then i can read all vector and all first row of the matrix
    # to calculate the first row of the new vector
    
    #its the same vector for al the rows of the matrix
    valores.vector <- as.numeric(unlist(strsplit(readLines(con.vector,n,warn = FALSE),",")))
    valores.vector <- valores.vector[seq(from = 2 , to = n*2 , by = 2)]
    for (i in 1:n){
      valores.matriz <- as.numeric(unlist(strsplit(readLines(con.matriz,n,warn = FALSE),",")))
      valores.matriz <- valores.matriz[seq(from = 3, to = n*3,by = 3 )]
      c <- c(paste(i,as.character(vxv(valores.matriz,valores.vector)),sep=","))
      print(c)
      writeLines(c,con.resultado)
    }
    
  }#else{
  #for(i in 1:maximo.leer.matriz){
  # for (j in 1:n){
  
  #}
  
  #}
  
  
  #}
  
  
  
  
  close(con.matriz,type="r")
  close(con.vector,type="r")
  close(con.resultado,type="w")

}