/* 04_ANALYSIS.SAS - Business analysis and visualization */
%let project=%sysget(HOME)/Banking_ETL_Analytics;
libname clean "&project/data/clean";

proc freq data=clean.bank_etl;
    tables y / missing;
run;

proc freq data=clean.bank_etl; tables job*y / chisq; run;
proc freq data=clean.bank_etl; tables education*y / chisq; run;
proc freq data=clean.bank_etl; tables marital*y / chisq; run;
proc freq data=clean.bank_etl; tables housing*y / chisq; run;
proc freq data=clean.bank_etl; tables loan*y / chisq; run;

proc means data=clean.bank_etl mean median min max std;
    var age balance duration campaign previous;
run;

proc means data=clean.bank_etl mean median std;
    class y;
    var age balance duration campaign previous;
run;

proc sql;
    select count(*) as Total_Customers,
           sum(case when y='yes' then 1 else 0 end) as Subscribers,
           calculated Subscribers / calculated Total_Customers * 100
               as Subscription_Rate format=8.2
    from clean.bank_etl;
quit;

proc sgplot data=clean.bank_etl;
    vbar y / datalabel;
    title "Term Deposit Subscription";
run;

proc sgplot data=clean.bank_etl;
    vbar education / group=y groupdisplay=cluster;
    title "Subscription by Education";
run;

proc sgplot data=clean.bank_etl;
    vbar housing / group=y groupdisplay=cluster;
    title "Subscription by Housing Loan";
run;

proc sgplot data=clean.bank_etl;
    histogram age;
    title "Customer Age Distribution";
run;

proc sgplot data=clean.bank_etl;
    histogram balance;
    title "Account Balance Distribution";
run;

title;
