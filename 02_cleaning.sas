/* 02_CLEANING.SAS - Remove exact duplicate rows */
%let project=%sysget(HOME)/Banking_ETL_Analytics;
libname clean "&project/data/clean";

proc sort data=clean.bank_raw out=work.bank_sorted
          nodupkey dupout=work.duplicates;
    by _all_;
run;

data clean.bank_clean;
    set work.bank_sorted;
run;

proc sql;
    select count(*) as Duplicate_Records from work.duplicates;
    select count(*) as Cleaned_Records from clean.bank_clean;
quit;

proc contents data=clean.bank_clean; run;
