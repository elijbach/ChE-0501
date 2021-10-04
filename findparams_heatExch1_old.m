% data file - 1st column is time, 2nd col. is concentration,3rd col. is temperature
load day2fitdata.mat
%%
% parameter initial guess
params=[53,150,23,28,47,43,35]; %guess tt1 UA ts1 ts2 tt2 tt3 ts3

optoptions = optimset('Display','iter');
% constraints on the parameter(s)
lsqlb = 0 * params; % lower bound, assumed zero
lsqub = inf * params; % upper bound, assumed "unbounded"

% read 'help lsqnonlin' for assistance w/ this call
%pass.tydata = tydata;
pass.tydata = day2fitdata;
save fitci pass
[lnX,lnRESNORM,lnRESIDUAL,lnEXITFLAG,lnOUTPUT,lnLAMBDA,lnJACOBIAN]=lsqnonlin(@fp_lsqobj_old_exch1,params,lsqlb,lsqub,optoptions);
lnX,
% calculate confidence intervals for the estimated parameters
CIBETA = nlparci(lnX,lnRESIDUAL,'jacobian',lnJACOBIAN),

% assign final parameter values
Tt1f = lnX(1);
UA = lnX(2);
Ts1f=lnX(3);
Ts2=lnX(4);
Tt2=lnX(5);
Tt3=lnX(6);
Ts3=lnX(7);

siminput=[day2fitdata(1,1) Tt1f UA Ts1f Ts2 Tt2 Tt3 Ts3;day2fitdata(size(day2fitdata,1),1) Tt1f UA Ts1f Ts2 Tt2 Tt3 Ts3]; 

% set necessary simulation options
simopts = simset('SrcWorkspace','current','OutputPoints','specified');
% run simulation and generate data at specified points
[t,x,y]=sim('HeatExch1_sf_sim',[day2fitdata(:,1)],simopts,siminput); %first input is the block diagram .mdl file


% Exit concentration
subplot(211);
plot(day2fitdata(:,1),day2fitdata(:,2),'ro');
hold;
plot(t,y(:,1),'b-');
xlabel('Time (hr)');
ylabel('Tube Temp in (kgmol/m^3)')
hold;
% Reactor temperature
subplot(212);
plot(day2fitdata(:,1),day2fitdata(:,3),'ro',t,y(:,2),'b-');
xlabel('Time (hr)');
ylabel('Shell temp in? (K)')

txt=['Best estimate of Tt1f = ' num2str(Tt1f) '  C']
txt=['Best estimate of UA = ' num2str(UA) '  J/(m^2 min C)']
txt=['Best estimate of Ts1f = ' num2str(Ts1f) '  C']
txt=['Best estimate of Ts2 = ' num2str(Ts2) '  C']
txt=['Best estimate of Tt2 = ' num2str(Tt2) '  C']
txt=['Best estimate of Tt3 = ' num2str(Tt3) '  C']
txt=['Best estimate of Ts3 = ' num2str(Ts3) '  C']

