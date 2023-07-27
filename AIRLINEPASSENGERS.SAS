proc import datafile='/home/u63491031/KIGEA/AirPassengers.csv'
    dbms=csv
    out=airpassengers
    replace;
    getnames=yes;
run;

proc summary data=airpassengers nway;
  class YEAR;
  var AIRPASSENGERS;
  output out=PassengerStats(drop=_:) 
         min=Min_Passengers 
         max=Max_Passengers;
run;


proc means data=airpassengers noprint;
  class YEAR;
  var AIRPASSENGERS;
  output out=YearStats(drop=_:) 
         mean=Mean_Passengers 
         std=Std_Passengers;
run;


data FinalOutput;
  merge PassengerStats(in=a) YearStats(in=b);
  by YEAR;
  if a and b;
run;


proc print data=FinalOutput;
  title "Passenger Statistics by Year";
run;
