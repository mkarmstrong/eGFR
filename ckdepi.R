ckdepi <- function(age, sex, cr) {
  # CKD-EPI 2021 equation for eGFR calculation
  # Reference: niddk.nih.gov/research-funding/research-programs/kidney-clinical-research-epidemiology/laboratory/glomerular-filtration-rate-equations/adults
  
  # Initialize output vector
  egfr <- rep(NA, length(cr))
  
  # Find indices with complete data
  complete_cases <- which(!is.na(age) & !is.na(sex) & !is.na(cr))
  
  # Define sex categories
  female_values <- c(0, 2, "female", "Female", "f", "F")
  male_values <- c(1, "male", "Male", "m", "M")
  
  # Constants
  BASE_COEF <- 142
  AGE_COEF <- 0.9938
  FEMALE_ADJ <- 1.012
  
  for(i in complete_cases) {
    # Skip if age < 18
    if(age[i] < 18) {
      next
    }
    
    is_female <- sex[i] %in% female_values
    is_male <- sex[i] %in% male_values
    
    # Skip if sex is not recognized
    if(!is_female && !is_male) {
      next
    }
    
    # Determine k and alpha based on sex and creatinine
    if(is_female) {
      k <- 0.7
      alpha <- if(cr[i] <= 0.7) -0.241 else -1.2
      sex_adj <- FEMALE_ADJ
    } else {  # male
      k <- 0.9
      alpha <- if(cr[i] <= 0.9) -0.302 else -1.2
      sex_adj <- 1
    }
    
    # Calculate eGFR
    egfr[i] <- BASE_COEF * (cr[i] / k)^alpha * AGE_COEF^age[i] * sex_adj
  }
  
  # Count excluded individuals
  n_excluded_age <- sum(age < 18 & !is.na(age), na.rm = TRUE)
  if(n_excluded_age > 0) {
    message(sprintf("%d individual(s) aged <18 set to NA", n_excluded_age))
  }
  
  return(egfr)
}
