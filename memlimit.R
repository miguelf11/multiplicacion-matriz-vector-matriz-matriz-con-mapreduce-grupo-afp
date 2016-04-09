memlimit <- function(size){
  if (size == -1 ){
    return(memory.limit() - 100)
  }else{
    return (size)
  }
}



