# FinancialModeling_timeSeriesAnalysis_longShortPositioning
Time series analysis of an underlying security using Matlab.

The script assumes that for a given day an udnerlying security has the following values

Opening Price Oi, High Price Hi
Low Price Li
Closing Price 𝐶i
Volume Vi

The ease of movement (EoM) analysis is calculated as


<img width="276" alt="image" src="https://github.com/Sameenrjb/FinancialModeling_timeSeriesAnalysis_longShortPositioning/assets/144177153/d44a77ad-6f7c-45ab-a2b6-49a78d23fc48">

To minimize wild swings in the EoM, it is typically smoothed using an n-day (trailing) moving average,

<img width="274" alt="image" src="https://github.com/Sameenrjb/FinancialModeling_timeSeriesAnalysis_longShortPositioning/assets/144177153/94112d5b-4c2c-4dff-9a45-b03780f74eb7">

The underlying security is assumed to be overbought, and a sell signal is generated, when the 𝐸𝑜𝑀𝑠𝑖
falls below zero. Similarly, the stock is assumed to be oversold, and a long signal is generated, when the EoMi
rises above zero. Given appropriate inputs, your function must generate a visualization similar to that shown in following figure. The
upper axis shows the values for both 𝐸𝑜𝑀𝑖 and EoMi. The lower axis shows the closing price overlaid with buy and a short signal is genereated.



<img width="820" alt="image" src="https://github.com/Sameenrjb/FinancialModeling_timeSeriesAnalysis_longShortPositioning/assets/144177153/748ea076-7f4e-4685-abed-65ffcdce7bfc">

