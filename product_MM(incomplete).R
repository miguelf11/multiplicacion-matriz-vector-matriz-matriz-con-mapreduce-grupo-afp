# por ahora pondre esto por aquí
memlimit <- function(size){
  if (size == -1 ){
    return(memory.limit() - 100)
  }else{
    return (size)
  }
}





#parametros
matriz  <- "tblAkv3x3.csv"
matriz2 <- "tblAkv3x3.csv"
n <- 3
limite = -1

# con este codigo obtenemos las columnas de la
# matriz 2

c <- c()
columna <- 3
if(columna == n){
    for(k in seq(from=columna,to=((n*n)-1),by=3)){
      a <- read.csv(matriz2,header = F,skip = k,nrows=1)
      print(a)
      c <- c(c,a$V3)
    }
}else{
    for(k in seq(from=columna,to=((n*n)-(n-columna)),by=3)){
      a <- read.csv(matriz2,header = F,skip = k,nrows=1)
      print(a)
      c <- c(c,a$V3)
    }
}
    

#calculo cuanto de cada uno puede tener

#open conection
con.matriz <- file(matriz, "r")

# read just 1 value to know the size of the string and so
# know the max of values that can read in memory
tam.matriz <- object.size(readLines(con.matriz,1))

#close conection to reboot the pointer of the file
close(con.matriz,type="r")


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






# mi idea es iterar en la matriz 1 por fila y en la matriz 2
# por columna
# además por cada fila y por cada columna iterar de forma similar
# a como itero en la matriz - vector 
# revisa github que está actualizado con esa matriz - vector
# avisa cuando leas esto xD

# como comentario aparte datajoy debería mejor su editor de texto
# jaja 


# hagamos un caso superhipotetico primero para organizarnos
# mentalmente
# que es asumir que el vector fila de la M1 y el vector
# columna de la matriz 2 caben en memoria :D

con.resultado <- file("resultado_matriz.csv", "w")
con.matriz <- file(matriz, "r")
con.matriz2 <- file(matriz2,"r")
for(i in 1:n){
  valores.matriz <- as.numeric(unlist(strsplit(readLines(con.matriz,n,warn = FALSE),",")))
  valores.matriz <- valores.matriz[seq(from = 3, to = n*3,by = 3 )]
  for (j in 1:n){
      c <- c()
      columna <- j-1
      for(k in seq(from=columna,to=((n*n)-1),by=3)){
        a <- read.csv(matriz2,header = F,skip = k,nrows=1)
        c <- c(c,a$V3)
      }
      writeLines(paste(i,j,vxv(valores.matriz,c)),con.resultado)
  }
  
}

close(con.resultado,type="w")
close(con.matriz,type="r")
close(con.matriz2,type="r")




## codigo cuando fila de la m1 y la columna de m2 no cabe :( LLORA Y CORRE!!
tam.matriz <- object.size(readLines(con.matriz,1))
tam.matriz2 <- object.size(readLines(con.matriz2,1))
close(con.matriz,type="r")
close(con.matriz2,type="r")
### Memoria límite para realizar las operaciones
limite = -1
memoria.limite <- memlimit(limite)
maximo.leer.matriz <-  as.integer(memoria.limite / tam.matriz) %/% 2
maximo.leer.matriz2 <-  as.integer(memoria.limite / tam.matriz2) %/% 2





max <- maximo.leer.matriz
max <- 1
maximo.leer.matriz <- 1
con.resultado <- file("resultado_matriz.csv", "w")
con.matriz2 <- file(matriz2,"r")
for(i in 1:n){
  for (j in 1:n){
    con.intermedio <- file("intermedio.csv", "w")
    con.matriz <- file(matriz, "r")
    if(i>1){
      readLines(con.matriz,(i-1)*n,warn = FALSE)
    }
    for(k in 1:ceiling(n/maximo.leer.matriz)){
    # huehuehuehue esto causa problemas de sincronización xq termina leyendo más que toda la fila
    #
      valores.matriz <- as.numeric(unlist(strsplit(readLines(con.matriz,max,warn = FALSE),",")))
      valores.matriz <- valores.matriz[seq(from = 3, to = m*3,by = 3 )]
      valores.matriz <- valores.matriz[!is.na(valores.matriz)]
      c <- c()
      columna <- j-1
      columna <- columna + ((k-1) * (maximo.leer.matriz * 3))


      for(p in seq(from=columna,to=((columna + maximo.leer.matriz*3)-1),by=3)){
        if(p < (n*n)){
          a <- read.csv(matriz2,header = F,skip = p,nrows=1)
          c <- c(c,a$V3)
        }
      }
      print(paste("i:",i,"j:",j,"k:",k))
      print(valores.matriz)
      print(c)
      #print(paste(i,j,vxv(valores.matriz,c)))
      writeLines(as.character(vxv(valores.matriz,c)),con.intermedio)
      rm (valores.matriz)
      rm(c)
    }
    close(con.intermedio,type="w")
    con.intermedio <- file("intermedio.csv", "r")
    suma <- 0
    for(k in 1:ceiling(n/max)){
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