Beta Analysis
Model/Prediction/Evaluation:
Approaching this project, I was fascinated by the analysis and residual returns uncovered in previous coursework. In particular, looking at the last night return to predict the following day’s intraday return seemed lucrative. For this project I decided to focus efforts on incorporating each stock’s relative trading volume into the model, and figuring out if I was able to obtain a better beta coefficient.
Initially, I thought to look at the trading volume of each stock the day before, in addition to the overnight return, to find a strong signal for the following day’s intraday return. However, after some careful thought I realized it wouldn’t be so easy: such a method ignored the distinction between stocks that had a lot of daily trading volume and those that were not so heavily traded each day (take for example Apple vs Joe’s Hardware Store). To correct for error, I calculated a 20 day average volume for each stock. Then I calculated each stock’s relative volume by taking the log of its previous day volume divided by the 20 day average I calculated before. This gave us a second variable to include in the regression. I ran a multivariable regression using a stocks relative volume and last night returns, calculating the resulting coefficients for the following day’s intraday returns. Finally, I used the “iccalc” function to calculate the relevant statistics of the model. 
From there, I decided to shift focus from the previous day volume to the trading volume in the first 15 minutes of each trading day. I thought this would yield a more relevant result to predict investor consensus for each stock’s trading day. Again, I divided that morning’s volume by the 20 day mean and logged the solution. Finally, I created one more model that incorporated both the previous day trading volume and the trading volume of the first 15 minutes of the trading day. After this model’s completion, I began to analyze results. 

Results:
	As mentioned above, I was able to use the “iccalc” function to retrieve relevant metrics about each of the models. Therefore, I was able to run the model on multiple time periods at once and output relevant statistics in a nice format. 
	To best analyze the models, I have retrieved the results from each of their runs. First I started with the simplest: “lastnt-today.” Then I moved on to combining it with yesterday’s volume. Next I moved on to combining “lastnt-today” with the morning-of’s volume. Lastly, I combined both the morning-of’s volume and yestereday’s volume with “lastnt-today.” Each of the model’s results are outputted below. It is important to note that using volume did in fact help predict residual returns and offered a nice coefficient to represent their value; however, when combining both volume metrics they yielded an unsavory result since the two were closely correlated at roughly “0.61.” 
  
 
 


Cheating Analysis:
Before arriving at my final models, I discovered a couple ways in which I cheated. I discovered my errors when the model outputs and potential returns were suspiciously high, this forced us to dive deeper into the details of the code. My suspicions were also confirmed by Professor Smallwood, who suggested that I was in fact cheating.
Upon further analysis, I discovered a few errors: 
●	The model unintentionally used a two month period when calculating the 20 day mean volume for each stock. This was fixed with a few numerical changes
●	The model unintentionally used the volume of the current day, and not the volume of the day before. This is an obvious example of cheating, as I was predicting stock values using information on that same day, which wouldn’t be possible. 
●	When tweaking each model’s volume analysis from previous day to same day, I needed to repeatedly adjust the time periods so as to not use incorrect dates as described above. Eventually I hit the correct time frames. 
Other Desired Data/Potential Opportunities:
-	Could have explored different data sets with the volume calculations I made. For example: ‘yest-today’, ‘lastnt&yest-day’, etc. could have had the volume models applied to them. The model may have yielded better coefficients by using these alternative data sets. 
-	I believe it may have been interesting to combine different variables into the model as well. For example using things such volatility, dividend announcements, and splits.


