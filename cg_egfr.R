cgegfr <- function(age, weight, sex, cr) {

  # Cockcroft-Gault CrCl, mL/min
  # age years
  # weight kg
  # sex 0 female
  # cr mg/dL
  
  cg <- ifelse(sex == 0, 
               (140-age)*(weight)*(0.85)/(72*cr),
               (140-age)*(weight)/(72*cr))
  
  return(as.numeric(cg))
}
