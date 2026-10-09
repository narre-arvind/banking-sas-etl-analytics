/* 03_ETL.SAS - Transform banking customer data */
%let project=%sysget(HOME)/Banking_ETL_Analytics;
libname clean "&project/data/clean";

data clean.bank_etl;
    set clean.bank_clean;

    if y="yes" then target=1;
    else if y="no" then target=0;
    else target=.;

    length age_group $10 balance_group $10 campaign_group $10
           contact_group $10 previous_contact $3;

    if age < 30 then age_group="Young";
    else if age < 50 then age_group="Middle";
    else age_group="Senior";

    if balance < 0 then balance_group="Negative";
    else if balance=0 then balance_group="Zero";
    else if balance <= 1000 then balance_group="Low";
    else balance_group="High";

    if campaign=1 then campaign_group="First";
    else if campaign <= 3 then campaign_group="Few";
    else campaign_group="Many";

    if contact="cellular" then contact_group="Mobile";
    else if contact="telephone" then contact_group="Telephone";
    else contact_group="Unknown";

    if previous=0 then previous_contact="No";
    else previous_contact="Yes";
run;

proc contents data=clean.bank_etl; run;
proc print data=clean.bank_etl(obs=10); run;

proc means data=clean.bank_etl n mean median min max;
    var age balance duration campaign previous target;
run;

proc freq data=clean.bank_etl;
    tables y target age_group balance_group campaign_group
           contact_group previous_contact;
run;

proc sql;
    select count(*) as Total_Records from clean.bank_etl;
quit;
