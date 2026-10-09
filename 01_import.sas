/* 01_IMPORT.SAS - Import raw banking data */
%let project=%sysget(HOME)/Banking_ETL_Analytics;
libname clean "&project/data/clean";

proc import datafile="&project/data/raw/bank-full.csv"
    out=clean.bank_raw dbms=csv replace;
    delimiter=';';
    getnames=yes;
    guessingrows=max;
run;

proc contents data=clean.bank_raw; run;
proc print data=clean.bank_raw(obs=10); run;

proc sql;
    select count(*) as Total_Records from clean.bank_raw;
quit;
