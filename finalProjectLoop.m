%prints relevant metrics of a stock 

function res = ps3loop(stdates, enddates, type)
%function res = ps3loop(stdates, enddates, type)

global G;

%sets up table to display
nsets = numel(stdates);%number of time periods to be displayed
clear tbl;
tbl.name = type;
tbl.colnames = {'NDPs' 'Coef1' 'Coef2' 'Coef3' 'Coef4' 'IC' 'MR' 'SF' 'N1' 'P(Rt)' 'P(Rt)-Mean' 'P(Rt)-Stdev'};
tbl.dec = [ 0 3 3 3 3 2 2 2 2 2 2 2 ];%sets number of decimals to display
tbl.mult = [ 1 1 1 1 1 100 G.const.bps 1 G.const.bps 100 100 100 ];
tbl.prcnt = [ 0 0 0 0 0 1 0 0 0 1 1 1 ];
tbl.rownames = cell(nsets, 1);
tbl.data = tbldata(tbl);

prvcoef = NaN;

for (ii = 1:nsets)
  %converts dates to printable format
  curunstr = sprintf('%d-%d', stdates(ii), enddates(ii));
  out = ps3func(stdates(ii), enddates(ii), type, prvcoef);
  prvcoef = out.coef;
  tbl.rownames{ii} = curunstr;
  tbl.data(ii, 1) = out.ndps;
  tbl.data(ii, 2) = out.coef(1);
  if (out.npreds >= 2) tbl.data(ii, 3) = out.coef(2); end;
  if (out.npreds >= 3) tbl.data(ii, 4) = out.coef(3); end;
  if (out.npreds >= 4) tbl.data(ii, 5) = out.coef(4); end;
  if (ii > 1)
    tbl.data(ii, 6) = out.icout.ic;%information coefficient
    tbl.data(ii, 7) = out.icout.mr;%market return
    tbl.data(ii, 8) = out.icout.sf;
    tbl.data(ii, 9) = out.icout.n1;
    tbl.data(ii, 10) = out.probright;
    tbl.data(ii, 11) = mean(out.probrightbyday);%mean percent chance right
    tbl.data(ii, 12) = std(out.probrightbyday);%std dev of percent right
  end;
end;

prntline;
dc(prnttable(tbl));

res = tbl;

end
