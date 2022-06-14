%% Physics 330 Final Project
clear; close all;

% file name that describes the run so that the variables can be saved.
runName = "run-one";

%global vars
global m;
global k;
global forcingFunction;
m = [1,2,1];
k = [1,1,3];

% multiplies the timestep by this value so that we can use the wgn
% generator to get white noise. The multiplication is needed so that the
% timestep can be changed into an int which allows accessing the array. 
global tfactor;
tfactor = 1e3;

% time info
tinit = 1;
tfinal = 1000;
timestep = 0.01;

forcingFunction = wgn(tfinal*tfactor,1,10);

%initial conditions
u0=zeros(6,1);

%standard options
options=odeset('RelTol',1e-3);

%numerical solver
[t,u]=ode45(@rhsF_1,tinit:timestep:tfinal,u0,options);

% sort the x vals into an array
x2=u(:,1);
x3=u(:,3);
x4=u(:,5);

% calculate initial power spectrum
powerinit = abs(fft(forcingFunction)).^2;

% calculate the angular frequency scale
tau = tfactor^-1; 
N = length(forcingFunction);
% Find dw
dw=2*pi/(N*tau);
%w=0:dw:2*pi/tau-dw;
winit = 0:dw:2*pi/tau-dw;

N=2^14;
tau=200/(N-1);
te=0:tau:200;

x2e=interp1(t,x2,te,'spline');
x3e=interp1(t,x3,te,'spline');
x4e=interp1(t,x4,te,'spline');

f2=ft(x2e,tau);
f3=ft(x3e,tau);
f4=ft(x4e,tau);

P2=abs(f2).^2;
P3=abs(f3).^2;
P4=abs(f4).^2;

dw=2*pi/(N*tau);
w=0:dw:2*pi/tau-dw;

figure
semilogy(w,P2)
title('Power Spectrum Mass 2')
xlabel('w')
ylabel('P(w)')
figure
semilogy(w,P3)
title('Power Spectrum Mass 3')
xlabel('w')
ylabel('P(w)')
figure
semilogy(w,P4)
title('Power Spectrum Mass 4')
xlabel('w')
ylabel('P(w)')
figure
semilogy(winit,powerinit)
title('Power Spectrum Whitenoise Function')
xlabel('w')
ylabel('P(w)')
