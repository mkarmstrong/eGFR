# Calculate eGFR in R

The included R functions can be used to calculate estimated glomerular filtration rate (eGFR). Calculation requires (at least), serum creatinine (mg/dL), age (years) and sex (0 = female, 1 = male).

These functions work on vectors and can be used as follows:

```R
# Calculate 2021 CKDepi
egfr_ckdepi <- ckdepi(data$age, data$sex, data$creatinine)

# Calculate Cockroft-Gault
df$cg_gfr <- cgegfr(df$age, df$weight, df$sex, df$creatinine)

# Calculate weight adjusted Cockroft-Gault
df$cg_gfr_v2 <- cgegfr_adjus(df$creatinine, df$age, df$sex, df$weight, df$height)
```

Refs:
1. Cockcroft DW, Gault MH. Prediction of creatinine clearance from serum creatinine. Nephron. 1976;16(1):31-41. PubMed PMID: 1244564.
2. Winter MA, Guhr KN, Berg GM. Impact of various body weights and serum creatinine concentrations on the bias and accuracy of the Cockcroft-Gault equation. Pharmacotherapy. 2012 Jul;32(7):604-12. doi:10.1002/j.1875-9114.2012.01098.x. Epub 2012 May 10. PubMed PMID: 22576791.
3. Brown DL, Masselink AJ, Lalla CD. Functional range of creatinine clearance for renal drug dosing: a practical solution to the controversy of which weight to use in the Cockcroft-Gault equation. Ann Pharmacother. 2013 Jul-Aug;47(7-8):1039-44. doi: 10.1345/aph.1S176. Epub 2013 Jun 11. Review. PubMed PMID: 23757387.
