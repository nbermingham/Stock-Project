%Calculates predictive value of previous month's 20 day mean of daily
%cumulative volume on the residual returns

disp("Period 1: 1/2010 - 6/2010");
startDate1=201001;
endDate1=201006;
monthBeforeStartDate1 = 200912;
RONVOL(startDate1, endDate1, monthBeforeStartDate1)
disp(" ")

disp("Period 2: 6/2010 - 12/2010");
startDate1=201006;
endDate1=201012;
monthBeforeStartDate1 = 201005;
RONVOL(startDate1, endDate1, monthBeforeStartDate1)
disp(" ")

disp("Period 3: 1/2011 - 6/2011");
startDate1=201101;
endDate1=201106;
monthBeforeStartDate1 = 201012;
RONVOL(startDate1, endDate1, monthBeforeStartDate1)
disp(" ")

disp("Period 4: 6/2011 - 12/2011");
startDate1=201106;
endDate1=201112;
monthBeforeStartDate1 = 201105;
RONVOL(startDate1, endDate1, monthBeforeStartDate1)
disp(" ")

disp("Period 5: 1/2010 - 6/2010");
startDate1=201201;
endDate1=201206;
monthBeforeStartDate1 = 201112;
RONVOL(startDate1, endDate1, monthBeforeStartDate1)
disp(" ")

disp("Period 6: 6/2010 - 12/2010");
startDate1=201206;
endDate1=201212;
monthBeforeStartDate1 = 201205;
RONVOL(startDate1, endDate1, monthBeforeStartDate1)
disp(" ")

disp("Period 7: 1/2011 - 6/2011");
startDate1=201301;
endDate1=201306;
monthBeforeStartDate1 = 201212;
RONVOL(startDate1, endDate1, monthBeforeStartDate1)
disp(" ")

disp("Period 8: 6/2011 - 12/2011");
startDate1=201306;
endDate1=201312;
monthBeforeStartDate1 = 201305;
RONVOL(startDate1, endDate1, monthBeforeStartDate1)
disp(" ")




function beta = RONVOL(startDate1, endDate1, monthBeforeStartDate1)
%calculates beta of a stock using just overnight 

ron1 = loaddata('rtxm_ti5',startDate1,endDate1,1);
rid1 = loaddata('rtxm_ti5',startDate1,endDate1,2);

%extracts the volume of each stock traded on the day
vol1 = loaddata('vol',startDate1,endDate1);

ron1=ron1(:,2:end);
rid1=rid1(:,2:end);
vol1=vol1(:,1:end-1);
preVol1 = loaddata('vol',monthBeforeStartDate1,monthBeforeStartDate1);

%loads the cumulative volume of the time period
vol1 = loaddata('vol_tm26',startDate1,endDate1,1);
vol1=vol1(:,2:end);

%loads the cumulative volume of the month before the given time period
preVol1 = loaddata('vol_tm26',monthBeforeStartDate1,monthBeforeStartDate1,1);

%Computes the 20 day (1 month) mean of the cumulative volume to provide
%reference for future volumes
dayMean20 = mean(preVol1,2,'omitnan');
volValue = log((vol1 ./ dayMean20));

%removes discontinuities in volValue array
volValue(isinf(volValue))=0;

%regression of intraday data and overnight data, and then with both
%overnight and relative volume
X = [flatten(ron1) flatten(ron1.*volValue)];
betaOfMulti = regress(flatten(rid1), X)

%regression of intraday data and overnight data (for comparison)
betaOfRONOnly = regress(flatten(rid1),flatten(ron1))

end