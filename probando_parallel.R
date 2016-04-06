library("parallel")
library("doParallel")
library("foreach")
no_cores <- detectCores()
setwd("C:/Users/Alex/Documents/R/Proy_ICD/Proyecto")


parallel.vxv <- function (vector1,vector2){
  cl<-makeCluster(no_cores)
  registerDoParallel(cl)
  result<- foreach(x=vector1,y=vector2, .inorder = TRUE,.combine = sum)  %dopar%  
  {
    x*y
  }
  stopCluster(cl)
  return (result)
}

single.vxv <- function (vector1,vector2){
  #vector 1 es el vector de la matriz
  #vector 2 es el vector
  sum <- 0
  for (i in 1:length(vector1)){
    sum <- vector1[i] * vector2[i] + sum
  }
  return (sum) 
}


v1 <- 1:1000
v2 <- 1:1000


parallel.vxv(v1,v2)

single.vxv(v1,v2)

system.time(parallel.vxv(v1,v2))
system.time(single.vxv(v1,v2))


# el tiempo del single.vxv ( es decir sin usar parallel) es mucho más eficiente
# que haciendo esta función con parallel.. creo que tal vez haya que paralelizar
# de otra forma.. 
