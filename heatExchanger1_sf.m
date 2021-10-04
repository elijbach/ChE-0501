function [sys,x0,str,ts] = heatExchanger_sf(t,x,u,flag)


%SFUNTMPL General M-file S-function template
%   With M-file S-functions, you can define you own ordinary differential 
%   equations (ODEs), discrete system equations, and/or just about
%   any type of algorithm to be used within a Simulink block diagram.

%   Copyright (c) 1990-97 by The MathWorks, Inc.
%   $Revision: 1.9 $
%
switch flag

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0
    [sys,x0,str,ts]=mdlInitializeSizes;

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case 1
    sys=mdlDerivatives(t,x,u);

  %%%%%%%%%%
  % Update %
  %%%%%%%%%%
  case 2
    sys=mdlUpdate(t,x,u);

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3
    sys=mdlOutputs(t,x,u);

  %%%%%%%%%%%%%%%%%%%%%%%
  % GetTimeOfNextVarHit %
  %%%%%%%%%%%%%%%%%%%%%%%
  case 4
    sys=mdlGetTimeOfNextVarHit(t,x,u);

  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  case 9
    sys=mdlTerminate(t,x,u);

  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes

sizes = simsizes;

% ChE 0500
sizes.NumContStates  = 8; % number of ordinary differential
                          % equations in the model
sizes.NumDiscStates  = 0; % number of discrete difference equations
                          % in the model [typically 0 for ChE 0500/0501]
sizes.NumOutputs     = 8; % number of outputs FROM THE S-FUNCTION.
                          % this is equal to the number of
                          % measured variables plus any other
                          % outputs you want to yield.
sizes.NumInputs      = 12; % number of inputs TO THE S-FUNCTION
                          % this is equal to the number of
                          % manipulated variables plus the number
                          % of disturbance variables, plus the
                          % number of (constant) parameter values
                          % you are passing to the model
sizes.DirFeedthrough = 0; % value 0, if u(i) does NOT appear in the
                          % output block (flag = 3); value 1 if
                          % u(i) (for any i) IS used in the output block
sizes.NumSampleTimes = 1; % number of sample times [typically 1 for 500/501]

sys = simsizes(sizes);




%
% ChE 0500:  initial values for the ordinary differential equations
%
x0  = [53.025;23.777;47;28;43;35;38;42]; %Tti, Tsi

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [0 0];

% end mdlInitializeSizes

%
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys=mdlDerivatives(t,x,u)

% ChE 0500:  assign parameter values here

% ChE 0500:  then specify state definitions - this section remains
%            as comments but is good for remembering what things are
  % input (u) and state (x) assignment
  % u(1) = 
  % u(2) = 
  % and so on
  % x(1) = 
  % x(2) = 
  % and so on
Vt=.001856;
Vs=.008031;
%%Ea=11843;
rho=1;
Cp=4200; 

Ttin=u(1); %inlet tube
Tt4=u(2); %outlet tube
Ts4=u(3); %outlet shell
Ft=u(4);
Fs=u(5);

Tt1f=u(6);
UA=u(7);
Ts1f=u(8);
Ts2=u(9);
Tt2=u(10);
Tt3=u(11);
Ts3=u(12);

Tt1=x(1);
Ts1=x(2);
dTt2=x(3);
dTs2=x(4);
dTt3=x(5);
dTs3=x(6);
dTt4=x(7);
dTs4=x(8);

% ChE 0500:  finally, write ordinary differential equations
  % dx(1) = 
  dx(1)=4*Ft/Vt*(Ttin-Tt1f)-((4*UA)/(rho*Cp*Vt))*(Tt1f-Ts1f);
dx(2)=4*(Fs/Vs)*(Ts4-Ts1f)+((4*UA)/(rho*Cp*Vs))*(Tt1f-Ts1f);
  dx(3)=4*Ft/Vt*(Tt1f-Tt2)-((4*UA)/(rho*Cp*Vt))*(Tt2-Ts2);
dx(4)=4*(Fs/Vs)*(Ts4-Ts2)+((4*UA)/(rho*Cp*Vs))*(Tt2-Ts2);
  dx(5)=4*Ft/Vt*(Tt2-Tt3)-((4*UA)/(rho*Cp*Vt))*(Tt3-Ts3);
dx(6)=4*(Fs/Vs)*(Ts2-Ts3)+((4*UA)/(rho*Cp*Vs))*(Tt3-Ts3);
  dx(7)=4*Ft/Vt*(Tt3-Tt4)-((4*UA)/(rho*Cp*Vt))*(Tt4-Ts4);
dx(8)=4*(Fs/Vs)*(Ts2-Ts4)+((4*UA)/(rho*Cp*Vs))*(Tt4-Ts4);
  % and so on
  
  sys=[dx];

% end mdlDerivatives

%
%=============================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=============================================================================
%
function sys=mdlUpdate(t,x,u)

sys = [];

% end mdlUpdate

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u)

% ChE 0500:  place outputs here - x means all states (ODEs)
sys = [x];

% end mdlOutputs

%
%=============================================================================
% mdlGetTimeOfNextVarHit
% Return the time of the next hit for this block.  Note that the result is
% absolute time.  Note that this function is only used when you specify a
% variable discrete-time sample time [-2 0] in the sample time array in
% mdlInitializeSizes.
%=============================================================================
%
function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later. 
sys = t + sampleTime;

% end mdlGetTimeOfNextVarHit

%
%=============================================================================
% mdlTerminate
% Perform any end of simulation tasks.
%=============================================================================
%
function sys=mdlTerminate(t,x,u)

sys = [];

% end mdlTerminate
