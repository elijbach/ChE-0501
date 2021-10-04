function [f] = fp_lsqobj_old_exch1(pvec)

%load fitci
load day2fitdata.mat

% pvec - vector of parameters we are solving for
% tyd - tydata

%tyd = pass.tydata;
tyd=day2fitdata;

% define parameters used in simulink diagram
Tt1f=pvec(1,1);
UA = pvec(1,2);
Ts1f= pvec(1,3);
Ts2=pvec(1,4);
Tt2=pvec(1,5);
Tt3=pvec(1,6);
Ts3=pvec(1,7);
% define input to simulation to address changing value of UA at each
% iteration of the optimization
% format (by column):  [time parameter1 parameter2 ...]
% format (rows):  minimimum 2 needed for start and stop times
% CAUTION:  MATLAB will interpolate/extrapolate; if you have different
% values on consecutive rows, MATLAB will use a straight line between those
% parameter values (ramp, not a step)

input=[tyd(1,1) Tt1f UA Ts1f Ts2 Tt2 Tt3 Ts3;tyd(size(tyd,1),1) Tt1f UA Ts1f Ts2 Tt2 Tt3 Ts3];

% set necessary simulation options
simopts = simset('SrcWorkspace','current','OutputPoints','specified','solver','ode23s');
% run simulation and generate data at specified points
[t,x,y] = sim('HeatExch1_sf_sim',[tyd(:,1)],simopts,input);

% calculate residual error vector - data minus model prediction
e1 = (tyd(:,2)-y(:,1));
e2 = tyd(:,3)-y(:,2);
% stack all errors into a single vector (lsqnonlin requirement)
e = [e1;e2];

% objective:  residual error
f = e;
