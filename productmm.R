productmm <- function(matriz,matriz2,num,limite = -1){
  # funcion que calcula multiplicacion matriz con matriz
  
  source("memlimit.R")
  
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
  
  memoria.limite <- memlimit(limite)
  
  tam.matriz <- object.size(readLines(con.matriz,1))

  close(con.matriz,type="r")
  
  #function to know the limit of the memory
  memoria.limite <- memlimit(limite)
  
  
  #cantidad de N valores que puedo leer o almacenar en memoria
  maximo.leer.matriz <-  as.integer(memoria.limite / tam.matriz) %/% 2
  maximo.leer.matriz <- 2
  max <- 2
  
  
  
  if(maximo.leer.matriz > num){
    con.resultado <- file("resultado_matriz.csv", "w")
    con.matriz <- file(matriz, "r")
    con.matriz2 <- file(matriz2,"r")
    for(i in 1:num){
      valores.matriz <- as.numeric(unlist(strsplit(readLines(con.matriz,num,warn = FALSE),",")))
      valores.matriz <- valores.matriz[seq(from = 3, to = n*3,by = 3 )]
      for (j in 1:num){
        c <- c()
        columna <- j-1
        for(k in seq(from=columna,to=((n*n)-(n-columna)),by=3)){
          a <- read.csv(matriz2,header = F,skip = k,nrows=1)
          c <- c(c,a$V3)
        }
        writeLines(paste(i,j,vxv(valores.matriz,c)),con.resultado)
      }
      
    }
    
    close(con.resultado,type="w")
    close(con.matriz,type="r")
    close(con.matriz2,type="r")
  }else{
    
    
    max <- maximo.leer.matriz
    con.resultado <- file("resultado_matriz.csv", "w")
    n <- num
    con.matriz2 <- file(matriz2,"r")
    for(i in 1:num){
      for (j in 1:num){
        con.intermedio <- file("intermedio.csv", "w")
        con.matriz <- file(matriz, "r")
        if(i>1){
          readLines(con.matriz,(i-1)*n,warn = FALSE)
        }
        columna <- 0
        for(k in 1:ceiling(n/maximo.leer.matriz)){
          
          if (num < k*maximo.leer.matriz){
            valores.matriz <- as.numeric(unlist(strsplit(readLines(con.matriz,n = (num - (k-1)*max),warn = FALSE),",")))
            aux <- length(valores.matriz)
            valores.matriz <- valores.matriz[seq(from = 3, to = (max*3),by = 3 )]
            valores.matriz <- valores.matriz[!is.na(valores.matriz)]
            
          }else{
            valores.matriz <- as.numeric(unlist(strsplit(readLines(con.matriz,n = max,warn = FALSE),",")))
            valores.matriz <- valores.matriz[seq(from = 3, to = (max*3),by = 3 )]
            valores.matriz <- valores.matriz[!is.na(valores.matriz)]
            rm(aux)
          }
          
          n = (i*maximo.leer.matriz) - n
          c <- c()
          columna <- j-1
          columna <- columna + ((k-1) * (maximo.leer.matriz * 3))
          for(p in seq(from=columna, to= ((columna + maximo.leer.matriz*3)-1),by=3)){
            if(p < (num*num)){
              a <- read.csv(matriz2,header = F,skip = p,nrows=1)
              c <- c(c,a$V3)
            }
          }
          writeLines(as.character(vxv(valores.matriz,c)),con.intermedio)
          rm (valores.matriz)
          rm(c)
        }
        close(con.intermedio,type="w")
        con.intermedio <- file("intermedio.csv", "r")
        suma <- 0
        for(k in 1:ceiling(num/max)){
          suma <- suma + sum(as.numeric(readLines(con.intermedio,n = maximo.leer.matriz)))
        }
        close(con.intermedio,type="r")
        c <- c(paste(i,j,suma,sep=","))
        
        writeLines(c,con.resultado)
        #the result it is in the file resultado.csv
        rm(c)
        rm(suma)
        close(con.matriz,type="r")
      }
      
    }
    close(con.resultado,type="w")
    close(con.matriz2,type="r")
    
  }
  
}