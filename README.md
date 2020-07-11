# Electronic-Waste-Quant

```
Initial AIC: 477.36
Final   AIC: 437.57
```

*Regression Coefficients for Logistic Regression Models for predicting whether people miss their devices, based on other variables* 
```
Coefficients:
                  Estimate Std. Error z value Pr(>|z|)    
(Intercept)       -1.22237    0.26395  -4.631 3.64e-06 ***
dump_within[<1mn] -0.48466    0.27502  -1.762  0.07802 .  
dump_within[<6mn] -0.27973    0.12457  -2.246  0.02473 *  
dump_within[<1yr] -0.22649    0.07637  -2.966  0.00302 ** 
dump_within[<2yr] -0.09543    0.06711  -1.422  0.15502    
dump_within[<4yr]  0.08528    0.09866   0.864  0.38735    
did_with_device_Y -0.55128    0.32105  -1.717  0.08596 .  
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

**Description of Variables**:

***dump_within*** - helmert coded. So, the coefficients curate (level[k] - avg of levels upto[1..k] ). So, we can get an estimate how each duration is important. *dump_within1* means average feeling of missing devices during first month of discarding device. Similarly *dump_within2* means average feeling of missing devices during 1-6 of discarding device. *dump_within3* means average feeling of missing devices during 6 months - 1 year of discarding device. As we see, log odds keeps increasing *(-.48 < -0.28 < -0.23)* during this period. Which means, people tend to miss devices more and more as time passes. [The result becomes more and more significant during this period. ] But, this doesnt go unbound. No significant effect for feeling miss_device for time beyond that [This corelates with our guts. That people doesnt feel that much bad after a certain period of time.] But, this is important to note that, not significant, but still implicative that the log-odd keeps increasing as time passes by. Which means, the more time passes, the more people miss their devices.


***did_with_device_Y*** - whether the device is (kept home/dustbin) vs (sold/parts sold/sold to recycler). So, whether any economic or non-economic activity. Simple binary variable. With *p<0.1* predicts that if economic activity was done, then device is *43%* less likely to be missed later (log odd -0.55)


***memory_with_device*** - whether the participant could write a memory with the device s/he used. This was a qualitative field. Ability to writing a memory with the device increases the odd of missing device * \math{326% (log odd 1.45)}*.

***dump_reason_X/Y/Z*** - reason (theft/break/slow) and whether the device is being missed. The order is important. Theft indicates, the device is still probably being used (just in the state the user was using that). This has the highest log-odd among reasons *(1.1)*. Then comes device broken unfortunately/somehow. Although, the device is not usable, the device is unusable [suddenly from a usable state]. This has a lower odd ration than ***theft***. Which can be explained because the utility was diminished not by some random thief, but the owner. So, although, odd ratio is *>1*, it is not as much as theft. Finally, when the device has grown slow/unusable, the device is still being missed, *significantly*, but the odd ration is the lowest in the lot.


```
Call:
glm(formula = miss_dev ~ . - X, family = binomial, data = df)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-2.0368  -0.8999  -0.2849   0.9042   2.5634  

Coefficients: (1 not defined because of singularities)
                            Estimate Std. Error z value Pr(>|z|)    
(Intercept)               -1.353e+01  2.007e+03  -0.007  0.99462    
division1                  1.033e+00  6.819e-01   1.515  0.12973    
division2                 -4.114e-01  4.627e-01  -0.889  0.37387    
division3                 -2.467e-01  3.180e-01  -0.776  0.43786    
division4                  3.888e-01  5.361e-01   0.725  0.46830    
division5                 -2.414e+00  1.231e+00  -1.962  0.04975 *  
division6                  2.193e+00  1.116e+00   1.966  0.04932 *  
division7                  4.123e-02  4.672e-01   0.088  0.92968    
age1                      -4.695e+00  7.584e+02  -0.006  0.99506    
age2                      -3.656e+00  7.584e+02  -0.005  0.99615    
age3                      -2.818e+00  7.584e+02  -0.004  0.99703    
age4                       1.477e+01  1.514e+03   0.010  0.99222    
genderWoman                3.326e-01  3.243e-01   1.026  0.30505    
eduBachelors              -3.846e-01  3.284e-01  -1.171  0.24161    
eduMasters                -1.378e+00  6.069e-01  -2.270  0.02321 *  
occupationBusiness         1.772e+01  2.400e+03   0.007  0.99411    
occupationDoctor           1.500e+01  2.400e+03   0.006  0.99501    
occupationFreelancing      3.225e+01  3.393e+03   0.010  0.99242    
occupationHomemaking       1.166e+00  3.393e+03   0.000  0.99973    
occupationJob              1.613e+01  2.400e+03   0.007  0.99464    
occupationjournalist      -2.957e-01  3.393e+03   0.000  0.99993    
occupationLabor            3.336e+01  3.393e+03   0.010  0.99216    
occupationLawyer           9.891e-03  3.393e+03   0.000  1.00000    
occupationRetired                 NA         NA      NA       NA    
occupationStudent          1.647e+01  2.400e+03   0.007  0.99452    
occupationTeacher          1.727e+01  2.400e+03   0.007  0.99426    
occupationTechnical Works  1.567e+01  2.400e+03   0.007  0.99479    
occupationUnemployed       1.728e+01  2.400e+03   0.007  0.99425    
device_count_5_yr.L        6.281e-01  1.007e+00   0.624  0.53276    
device_count_5_yr.Q       -5.667e-01  9.248e-01  -0.613  0.54004    
device_count_5_yr.C       -3.204e-01  8.552e-01  -0.375  0.70788    
device_count_5_yr^4       -2.191e-01  7.621e-01  -0.287  0.77374    
device_count_5_yr^5        1.199e+00  6.957e-01   1.724  0.08473 .  
device_count_5_yr^6        4.260e-01  6.142e-01   0.693  0.48801    
device_count_5_yr^7        6.199e-02  4.470e-01   0.139  0.88970    
last_dumped_device1        1.086e-01  2.531e-01   0.429  0.66793    
last_dumped_device2       -1.957e-02  4.118e-01  -0.048  0.96210    
last_dumped_device3       -3.473e-02  4.645e-01  -0.075  0.94040    
last_dumped_device4        1.841e-01  3.901e-01   0.472  0.63695    
dump_within1              -2.230e-01  3.212e-01  -0.694  0.48755    
dump_within2              -2.170e-01  1.445e-01  -1.502  0.13301    
dump_within3              -2.277e-01  8.870e-02  -2.566  0.01027 *  
dump_within4              -1.130e-01  7.610e-02  -1.485  0.13766    
dump_within5               9.650e-02  1.185e-01   0.814  0.41537    
did_with_device2          -4.456e-01  3.778e-01  -1.180  0.23819    
did_with_data2             1.183e-01  2.958e-01   0.400  0.68919    
memory_devY                1.795e+00  3.241e-01   5.539 3.05e-08 ***
miss_anotherY             -5.316e-01  3.114e-01  -1.707  0.08778 .  
dump_reason_new           -6.973e-02  3.377e-01  -0.206  0.83644    
dump_reason_old           -9.947e-02  3.409e-01  -0.292  0.77046    
dump_reason_break          9.745e-01  3.249e-01   2.999  0.00271 ** 
dump_reason_theft          7.293e-01  5.746e-01   1.269  0.20433    
dump_reason_slow           1.336e+00  4.720e-01   2.830  0.00465 ** 
dump_reason_lag           -1.332e-01  3.381e-01  -0.394  0.69353    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 485.33  on 350  degrees of freedom
Residual deviance: 371.36  on 298  degrees of freedom
AIC: 477.36
```