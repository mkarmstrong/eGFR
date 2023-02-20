cgegfr_adjus <- function(cr, age, sex, wt_kg, ht_cm) {
  
  # Calculate variables
  bmi <- round((wt_kg/(ht_cm*ht_cm))*10000, 1)
  ht_in <- ht_cm/2.54
  
  # ideal body weight
  ibw <- ifelse(sex == 1, 
               50+(2.3*(ht_in-60)),
               45.5+(2.3*(ht_in-60))
               )
  
  # adjusted body weight kg
  abw <- ibw+0.4*(wt_kg-ibw)
  
  # initialize empty data
  egfr <- rep(NA, length(cr))
  
  # find all non-NA values
  list <- list(which(!is.na(age)), 
               which(!is.na(sex)), 
               which(!is.na(cr)),
               which(!is.na(wt_kg)),
               which(!is.na(ht_cm)))
  non_na <- Reduce(intersect, list)

  # calculate creatnine
  for(i in non_na) {
    if (bmi[i] < 18.5 & sex[i] == 1) {
      egfr[i] <- (140 - age[i]) * (wt_kg[i]) / (72 * cr[i])
    } else if (bmi[i] < 18.5 & sex[i] == 0) {
      egfr[i] <- (140 - age[i]) * (wt_kg[i]) * (0.85) / (72 * cr[i])
    } else if (bmi[i] >= 18.5 & bmi[i] < 24.9 & sex[i] == 1) {
      egfr[i] <- (140 - age[i]) * (ibw[i]) / (72 * cr[i])
    } else if (bmi[i] >= 18.5 & bmi[i] < 24.9 & sex[i] == 0) {
      egfr[i] <- (140 - age[i]) * (ibw[i]) * (0.85) / (72 * cr[i])
    } else if (bmi[i] >= 25 & sex[i] == 1) {
      egfr[i] <- (140 - age[i]) * (abw[i]) / (72 * cr[i])
    } else if (bmi[i] >= 25 & sex[i] == 0) {
      egfr[i] <- (140 - age[i]) * (abw[i]) * (0.85) / (72 * cr[i])
    }
  }

    return(as.numeric(egfr))
}
