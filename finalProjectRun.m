%code to be run in command window

stdates =  [ 20120103 20120702 20130102 20130701 ];
enddates = [ 20120629 20121231 20130628 20131231 ];

stdates =  [ 20100103 20100702 20110102 20110701 20120102 20120701 20130102 20130701 ];
enddates = [ 20100629 20101231 20110628 20111231 20120630 20121231 20130630 20131231 ];

%{
all the time periods we have access to 
type = ''
type = 'lastnt-today';
type = 'yest-today';
type = 'lastnt&yest-today';
type = 'lastnt2-today';
type = 'yest2-today';
type = 'all4-today';
type = 'today-tonight';
type = 'lastnt-tonight';
type = 'today&lastnt-tonight';
type = 'yest-tonight';
type = 'lastnt2-tonight';
type = 'all4-tonight';
%}

%prints metrics for each of the following data types

type = 'lastnt-today';
ps3loop(stdates, enddates, type);
type = 'yest-today';
ps3loop(stdates, enddates, type);
type = 'lastnt&yest-today';
ps3loop(stdates, enddates, type);
type = 'all4-today';
ps3loop(stdates, enddates, type);

type = 'today-tonight';
ps3loop(stdates, enddates, type);
type = 'lastnt-tonight';
ps3loop(stdates, enddates, type);
type = 'today&lastnt-tonight';
ps3loop(stdates, enddates, type);
type = 'all4-tonight';
ps3loop(stdates, enddates, type);


