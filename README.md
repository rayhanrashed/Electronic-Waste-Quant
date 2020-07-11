# Electronic-Waste-Quant


*Regression Coefficients for Logistic Regression Models for predicting whether people miss their devices, based on other variables*
```
Coefficients:
                  Estimate Std. Error z value Pr(>|z|)    
(Intercept)       -1.22237    0.26395  -4.631 3.64e-06 ***
dump_within1      -0.48466    0.27502  -1.762  0.07802 .  
dump_within2      -0.27973    0.12457  -2.246  0.02473 *  
dump_within3      -0.22649    0.07637  -2.966  0.00302 ** 
dump_within4      -0.09543    0.06711  -1.422  0.15502    
dump_within5       0.08528    0.09866   0.864  0.38735    
did_with_device2  -0.55128    0.32105  -1.717  0.08596 .  
memory_devY        1.45145    0.24657   5.887 3.94e-09 ***
dump_reason_break  1.02806    0.25616   4.013 5.99e-05 ***
dump_reason_theft  1.11285    0.47485   2.344  0.01910 *  
dump_reason_slow   0.90000    0.38924   2.312  0.02077 *  
---
    Signif. codes:  0 ‘(***)’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

    (Dispersion parameter for binomial family taken to be 1)

    Null deviance: 485.33  on 350  degrees of freedom
    Residual deviance: 415.57  on 340  degrees of freedom
    AIC: 437.57
```
Final Fitted Model:

Description of Variables:
--*dump_within* - helmert coded. So, the coefficients curate (level[k] - avg of levels upto[1..k] ). So, we can get an estimate how each duration is important. *dump_within1* means average feeling of missing devices during first month of discarding device. Similarly *dump_within2* means average feeling of missing devices during 1-6 of discarding device. *dump_within3* means average feeling of missing devices during 6 months - 1 year of discarding device. As we see, log odds keeps increasing (-.48<-0.28<-0.23) during this period. Which means, people tend to miss devices more and more as time passes. [The result becomes more and more significant during this period. ] But, this doesnt go unbound. No significant effect for feeling miss_device for time beyond that [This corelates with our guts. That people doesnt feel that much bad after a certain period of time.] But, this is important to note that, not significant, but still implicative that the log-odd keeps increasing as time passes by. Which means, the more time passes, the more people miss their devices.