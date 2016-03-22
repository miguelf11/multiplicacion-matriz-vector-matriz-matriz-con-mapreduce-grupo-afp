vxv <- function (vector1,vector2){
  #vector 1 es el vector de la matriz
  #vector 2 es el vector
  sum <- 0
  for (i in 1:length(vector1)){
    sum <- vector1[i] * vector2[i] + sum
  }
  return (sum) 
}