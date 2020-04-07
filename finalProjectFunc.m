%extracts appropriate stock data depending on dates and type

function res = ps3func(stdate, enddate, type, oldcoef)

rtxm = loaddata('rtxm_ti5', stdate, enddate, 1:2);

%extracts all the 'good' stocks (have good data for at least one date
%during the given period). This is a stat provided in the data set
good = loaddata('good', stdate, enddate);

%number of days
ndays = size(rtxm, 2);
dayidx = 1:ndays;

%number of previous data sets, depending on type
npreds = 0;

%creating the arrays to be filled with previous stock data, depending on type
preddata1 = [];
preddata2 = [];
preddata3 = [];
preddata4 = [];

%extracts appropriate stock data
if (strcmp(type, 'lastnt-today'))
  depdata = rtxm(:, dayidx, 2);
  depgood = good(:, dayidx);
  npreds = 1;
  preddata1 = rtxm(:, dayidx, 1);
  predgood1 = good(:, dayidx);
elseif (strcmp(type, 'yest-today'))
  depdata = rtxm(:, dayidx(2:end), 2);
  depgood = good(:, dayidx(2:end));
  npreds = 1;
  preddata1 = rtxm(:, dayidx(1:end-1), 2);
  predgood1 = good(:, dayidx(1:end-1));
elseif (strcmp(type, 'lastnt2-today'))
  depdata = rtxm(:, dayidx(2:end), 2);
  depgood = good(:, dayidx(2:end));
  npreds = 1;
  preddata1 = rtxm(:, dayidx(1:end-1), 1);
  predgood1 = good(:, dayidx(1:end-1));
elseif (strcmp(type, 'yest2-today'))
  depdata = rtxm(:, dayidx(3:end), 2);
  depgood = good(:, dayidx(3:end));
  npreds = 1;
  preddata1 = rtxm(:, dayidx(1:end-2), 2);
  predgood1 = good(:, dayidx(1:end-2));
elseif (strcmp(type, 'lastnt&yest-today'))
  depdata = rtxm(:, dayidx(2:end), 2);
  depgood = good(:, dayidx(2:end));
  npreds = 2;
  preddata1 = rtxm(:, dayidx(2:end), 1);
  predgood1 = good(:, dayidx(2:end));
  preddata2 = rtxm(:, dayidx(1:end-1), 2);
  predgood2 = good(:, dayidx(1:end-1));
elseif (strcmp(type, 'all4-today'))
  depdata = rtxm(:, dayidx(3:end), 2);
  depgood = good(:, dayidx(3:end));
  npreds = 4;
  preddata1 = rtxm(:, dayidx(3:end), 1);
  predgood1 = good(:, dayidx(3:end));
  preddata2 = rtxm(:, dayidx(2:end-1), 2);
  predgood2 = good(:, dayidx(2:end-1));
  preddata3 = rtxm(:, dayidx(2:end-1), 1);
  predgood3 = good(:, dayidx(2:end-1));
  preddata4 = rtxm(:, dayidx(1:end-2), 2);
  predgood4 = good(:, dayidx(1:end-2));

elseif (strcmp(type, 'today-tonight'))
  depdata = rtxm(:, dayidx(2:end), 1);
  depgood = good(:, dayidx(2:end));
  npreds = 1;
  preddata1 = rtxm(:, dayidx(1:end-1), 2);
  predgood1 = good(:, dayidx(1:end-1));
elseif (strcmp(type, 'lastnt-tonight'))
  depdata = rtxm(:, dayidx(2:end), 1);
  depgood = good(:, dayidx(2:end));
  npreds = 1;
  preddata1 = rtxm(:, dayidx(1:end-1), 1);
  predgood1 = good(:, dayidx(1:end-1));
elseif (strcmp(type, 'yest-tonight'))
  depdata = rtxm(:, dayidx(3:end), 1);
  depgood = good(:, dayidx(3:end));
  npreds = 1;
  preddata1 = rtxm(:, dayidx(1:end-2), 2);
  predgood1 = good(:, dayidx(1:end-2));
elseif (strcmp(type, 'lastnt2-tonight'))
  depdata = rtxm(:, dayidx(3:end), 1);
  depgood = good(:, dayidx(3:end));
  npreds = 1;
  preddata1 = rtxm(:, dayidx(1:end-2), 1);
  predgood1 = good(:, dayidx(1:end-2));
elseif (strcmp(type, 'today&lastnt-tonight'))
  depdata = rtxm(:, dayidx(2:end), 1);
  depgood = good(:, dayidx(2:end));
  npreds = 2;
  preddata1 = rtxm(:, dayidx(1:end-1), 2);
  predgood1 = good(:, dayidx(1:end-1));
  preddata2 = rtxm(:, dayidx(1:end-1), 1);
  predgood2 = good(:, dayidx(1:end-1));
elseif (strcmp(type, 'all4-tonight'))
  depdata = rtxm(:, dayidx(3:end), 1);
  depgood = good(:, dayidx(3:end));
  npreds = 4;
  preddata1 = rtxm(:, dayidx(2:end-1), 2);
  predgood1 = good(:, dayidx(2:end-1));
  preddata2 = rtxm(:, dayidx(2:end-1), 1);
  predgood2 = good(:, dayidx(2:end-1));
  preddata3 = rtxm(:, dayidx(1:end-2), 2);
  predgood3 = good(:, dayidx(1:end-2));
  preddata4 = rtxm(:, dayidx(1:end-2), 1);
  predgood4 = good(:, dayidx(1:end-2));
else
  error('ps3func: illegal type %s', type);
end;


use = depgood == 1 & ~isnan(depdata);
use = use & predgood1 == 1 & ~isnan(preddata1);
if (npreds >= 2)
  use = use & predgood2 == 1 & ~isnan(preddata2);
end;
if (npreds >= 3)
  use = use & predgood3 == 1 & ~isnan(preddata3);
end;
if (npreds >= 4)
  use = use & predgood4 == 1 & ~isnan(preddata4);
end;

depreg = depdata(use);
predreg = preddata1(use);
if (npreds >= 2)
  predreg = [ predreg preddata2(use) ];
end;
if (npreds >= 3)
  predreg = [ predreg preddata3(use) ];
end;
if (npreds >= 4)
  predreg = [ predreg preddata4(use) ];
end;

coef = regress(depreg, predreg);

res.coef = coef;
res.npreds = npreds;
res.ndps = summat(use);

if (~isnan(oldcoef(1)))
  fcast = predreg * oldcoef;
  icout = iccalc(fcast, depreg);
  res.icout = icout;
  res.nright = sum(fcast .* depreg > 0);
  res.nwrong = sum(fcast .* depreg < 0);
  res.probright = res.nright / (res.nright + res.nwrong);
  
  ndatadays = size(depdata, 2);
  probright = NaN(ndatadays, 1);
  for (ii = 1:ndatadays)
    cudepday = depdata(use(:, ii), ii);
    cupredday = preddata1(use(:, ii), ii);
    if (npreds >= 2)
      cupredday = [ cupredday preddata2(use(:, ii), ii) ];
    end;
    if (npreds >= 3)
      cupredday = [ cupredday preddata3(use(:, ii), ii) ];
    end;
    if (npreds >= 4)
      cupredday = [ cupredday preddata4(use(:, ii), ii) ];
    end;
    cufcast = cupredday * oldcoef;
    cunright = sum(cufcast .* cudepday > 0);
    cunwrong = sum(cufcast .* cudepday < 0);
    probright(ii) = cunright / (cunright + cunwrong);
  end;
  res.probrightbyday = probright;
end;
  
end
 


