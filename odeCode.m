clear all;
close all;

dataTable= importdata('501TeamBDay2.xlsx');
%dataTable=table2array(dataTable);
time= dataTable(:,1);
T1= dataTable(:,2);
T2= dataTable(:,3);
T3= dataTable(:,[1 4]); %inlet temp tube side
T4= dataTable(:,[1 5]); %exit temp tube side
T5= dataTable(:,[1 6]); %inlet temp shell side
T6= dataTable(:,[1 7]); %outlet temp shell side
T7= dataTable(:,8);
T8= dataTable(:,9);
T9= dataTable(:,10);
T10= dataTable(:,11);
T11= dataTable(:,12);
T12= dataTable(:,13);
T13= dataTable(:,14);
T14= dataTable(:,15);
AmbientTemp= dataTable(:,16);
T15= dataTable(:,17);
Ft= dataTable(:,[1 18]); %tube flow
Fs= dataTable(:,[1 19]); %shell flow
P= dataTable(:,20);

day2fitdata=dataTable(:,[1 5 7]);