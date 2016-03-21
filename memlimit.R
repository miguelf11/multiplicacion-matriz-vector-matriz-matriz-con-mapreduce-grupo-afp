memlimit <- function(size){
  if (size == -1 ){
    return(memory.limit() - 100)
  }else{
    return (size)
  }
}



format(memory.limit(), units = "b")

# if (maximo.leer.matriz > n ) then i can read all vector and all first row of the matriz
# to calculate the first row of the new vector



# if (maximo.leer.matriz < n ) the if a have to split the read and read the vector in parts
# that it read a first split the vector calculate the multiplication for the i,j matriz
# and then 



# rm sirve para eliminar variables del workspace

# object.size(tblxkv10) retorna el tamaño de la variable en bytes 

# memory.limit() devuelve el limite de memoria en para R en Mb(1048576 bytes)

# memory.size() devuelve la cant de memoria en uso actualmente