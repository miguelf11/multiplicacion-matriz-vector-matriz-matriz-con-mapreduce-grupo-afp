#probando y creando producto entre matriz y vector

# library("parallel") sirve para usar más de un "core"

vxv <- function (vector1,vector2){
  #vector 1 es el vector de la matriz
  #vector 2 es el vector
  sum <- 0
  for (i in 1:length(vector1)){
    sum <- vector1[i] * vector2[i] + sum
  }
  return (sum) 
}

matriz <- "tblAkv3x3.csv"
vector <- "tblxkv3.csv"


limite <- -1
n <- 3


con.matriz <- file(matriz, "r")
con.vector <- file(vector, "r")

tam.matriz <- object.size(readLines(con.matriz,1))

tam.vector <- object.size(readLines(con.vector,1))


close(con.matriz,type="r")
close(con.vector,type="r")



memoria.limite <- memlimit(limite)


# cantidad de M valores que puedo leer tomando en cuenta de que necesito leer n de del vector fila
# de la matriz y M valores del vector a multiplicar
max = as.integer(memoria.limite %/% tam.matriz) / 2
max <- 1 #probando

#vuelvo a abrir la coneccion 
con.matriz <- file(matriz, "r")
con.vector <- file(vector, "r")


con.resultado <- file("resultado_vector.csv", "w")
if (max > n){
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
  
}else{
  # m es cuantos valores del vector se puede leer
  # crear archivo intermedia para ir guardando la suma
  # 
  m <- n/max
  for(j in 1:n){
    for(i in 1:m){
      valores.vector <- as.numeric(unlist(strsplit(readLines(con.vector,max
                                                             ,warn = FALSE),",")))
      valores.vector <- valores.vector[seq(from = 2 , to = n*2 , by = 2)]
      con.intermedio <- file("intermedio.csv", "w")
      valores.matriz <- as.numeric(unlist(strsplit(readLines(con.matriz,max,warn = FALSE),",")))
      valores.matriz <- valores.matriz[seq(from = 3, to = n*3,by = 3 )]
      print(vxv(valores.matriz,valores.vector))
      writeLines(as.character(vxv(valores.matriz,valores.vector)),con.intermedio)
    }
  }
  
  
}




close(con.matriz,type="r")
close(con.vector,type="r")
close(con.resultado,type="w")
close(con.intermedio,type="w")





