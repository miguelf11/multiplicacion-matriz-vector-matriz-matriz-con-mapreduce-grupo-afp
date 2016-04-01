setwd("C:/Users/Alex/Documents/R/Proy_ICD/Proyecto")

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
n <- 3
max <- 1 #probando




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
  rm(suma)
  writeLines(c,con.resultado)
  rm(c)
}


close(con.matriz,type="r")
close(con.resultado,type="w")






