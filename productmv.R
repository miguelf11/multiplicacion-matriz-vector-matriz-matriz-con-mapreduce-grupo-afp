productmv <- function(matriz,vector,n,limite = -1 ){
  
  # funcion que multiplica 2 vectores de igual forma
  # como se necesita en la multiplicacion matriz- vector
  vxv <- function (vector1,vector2){
    #vector 1 es el vector de la matriz
    #vector 2 es el vector
    sum <- 0
    for (i in 1:length(vector1)){
      sum <- vector1[i] * vector2[i] + sum
    }
    return (sum) 
  }
  
  #open conection
  con.matriz <- file(matriz, "r")
  con.vector <- file(vector, "r")
  
  # read just 1 value to know the size of the string and so
  # know the max of values that can read in memory
  tam.matriz <- object.size(readLines(con.matriz,1))
  tam.vector <- object.size(readLines(con.vector,1))
  
  #close conection to reboot the pointer of the file
  close(con.matriz,type="r")
  close(con.vector,type="r")
  
  #function to know the limit of the memory
  memoria.limite <- memlimit(limite)
  
  
  #cantidad de N valores que puedo leer
  maximo.leer.matriz = as.integer(memoria.limite %/% tam.matriz) / 2
  
  
  
  if (maximo.leer.matriz > n){
    # then i can read all vector and all first row of the matrix
    # to calculate the first row of the new vector
    
    # open the conection with files  
    con.matriz <- file(matriz, "r")
    con.vector <- file(vector, "r")
    
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
    close(con.matriz,type="r")
    close(con.vector,type="r")
    close(con.resultado,type="w")
    
  }else{
    #vector not fit in memory 
    con.matriz <- file(matriz, "r")
    con.resultado <- file("resultado_vector.csv", "w")
    for(j in 1:n){
      con.vector <- file(vector, "r")
      con.intermedio <- file("intermedio.csv", "w")
      for(i in 1:(n/max)){
        valores.vector <- as.numeric(unlist(strsplit(readLines(con.vector,max
                                                               ,warn = FALSE),",")))
        valores.vector <- valores.vector[seq(from = 2 , to = max*2 , by = 2)]
        valores.matriz <- as.numeric(unlist(strsplit(readLines(con.matriz,max,warn = FALSE),",")))
        valores.matriz <- valores.matriz[seq(from = 3, to = max*3,by = 3 )]
        writeLines(as.character(vxv(valores.matriz,valores.vector)),con.intermedio)
      }
      rm(valores.vector)
      rm(valores.matriz)
      close(con.vector,type="r")
      close(con.intermedio,type="w")
      con.intermedio <- file("intermedio.csv", "r")
      suma <- 0
      for(k in 1:ceiling(n/2*max)){
        suma <- suma + sum(as.numeric(readLines(con.intermedio,n = 2*max)))
        print(paste(j,suma,sep=","))
      }
      close(con.intermedio,type="r")
      c <- c(paste(j,suma,sep=","))

      writeLines(c,con.resultado)
      #the result it is in the file resultado.csv
      
      rm(c)
      rm(suma)
    }
    close(con.matriz,type="r")
    close(con.resultado,type="w")
  }

}