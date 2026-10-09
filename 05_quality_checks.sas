/* 05_QUALITY_CHECKS.SAS - Data quality validation */
%let project=%sysget(HOME)/Banking_ETL_Analytics;
libname clean "&project/data/clean";

proc contents data=clean.bank_etl; run;
proc means data=clean.bank_etl n nmiss; run;

proc freq data=clean.bank_etl;
    tables y target / missing;
run;

proc freq data=clean.bank_etl;
    tables job marital education housing loan contact poutcome / missing;
run;

proc means data=clean.bank_etl min max mean median;
    var age balance duration campaign previous;
run;

proc sort data=clean.bank_etl out=work.bank_check
          nodupkey dupout=work.duplicates;
    by _all_;
run;

proc sql;
    select count(*) as Exact_Duplicate_Records from work.duplicates;
    select count(*) as Final_Record_Count from clean.bank_etl;
quit;

proc sql;
    select count(*) as Total_Records,
           sum(case when target=1 then 1 else 0 end) as Subscribers,
           sum(case when target=0 then 1 else 0 end) as Non_Subscribers,
           sum(case when target not in (0,1) or target is missing
                    then 1 else 0 end) as Invalid_Target_Records,
           sum(case when y='yes' then 1 else 0 end)
               / count(*) * 100 as Subscription_Rate format=8.2
    from clean.bank_etl;
quit;

/* Character missing-value scan; review the Log for messages. */
data _null_;
    set clean.bank_etl;
    array chars {*} _character_;
    do i=1 to dim(chars);
        if missing(chars{i}) then
            put "NOTE: Missing character value at observation " _n_
                " variable " vname(chars{i});
    end;
run;
