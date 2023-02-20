ckdepi <- function(age, sex, cr) {
 
  a <- NA
  b <- NA
  egfr <- rep(NA, length(cr))

  # find all non-NA values
  list <- list(which(!is.na(age)), 
               which(!is.na(sex)), 
               which(!is.na(cr)))
  non_na <- Reduce(intersect, list)
  
  # low is <=0.7
  for(i in non_na) {
    
    if(cr[i] <= 0.7 & sex[i] == 0) {
      a <- 0.7
      b <- -0.241
      egfr[i] <- 142 * (cr[i] / a)^b * 0.9938 ^ age[i] * (1.012)
    } else if (cr[i] <= 0.7 & sex[i] == 1) {
      a <- 0.9
      b <- -0.302
      egfr[i] <- 142 * (cr[i] / a)^b * 0.9938 ^ age[i]
    } else if (cr[i] > 0.7 & sex[i] == 0) {
      a <- 0.7
      b <- -1.2
      egfr[i] <- 142 * (cr[i] / a)^b * 0.9938 ^ age[i] * (1.012)
    } else if (cr[i] > 0.7 & sex[i] == 1) {
      a <- 0.9
      b <- -1.2
      egfr[i] <- 142 * (cr[i] / a)^b * 0.9938 ^ age[i]
    }
  
  }
  
  return(as.numeric(egfr))
}
