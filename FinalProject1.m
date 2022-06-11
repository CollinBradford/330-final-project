%% Physics 330 Final Project
clear; close all;

%global vars
global m;
global k;
global x1;
m = [1,2];
k = [1,2];

tinit = 1;
tfinal = 1000;

x1 = wgn(tfinal*10000,1,10);

%initial conditions
u0=zeros(4,1);
u0(1)=0;
u0(2)=0;
u0(3)=0;
u0(4)=0;

%standard options
options=odeset('RelTol',1e-3);

%numerical solver
[t,u]=ode45(@rhsF_1,[tinit:1:tfinal],u0,options);

x = u(:,3);

%% figures

figure()
plot(t,x)
title("Mass 2")
xlabel("time")
ylabel("amplitude")
figure()
tx = 0:0.0001:tfinal;
plot(tx(1:end-1),x1)
title("driving function") 
xlabel("time")
ylabel("amplitude")

%% power spectrums 

powerinit = abs(fft(x1)).^2;
powerfinal = abs(fft(x)).^2;

tau = 0.0001;
N = length(x1);
% Find dw
dw=2*pi/(N*tau);
%w=0:dw:2*pi/tau-dw;
winit = -(N/2)*dw:dw:dw*(N/2-1);

tau = tfinal/length(t);
N = length(t);
% Find dw
dw=2*pi/(N*tau);
%w=0:dw:2*pi/tau-dw;
wfinal = -(N/2)*dw:dw:dw*(N/2-1);

figure()
semilogy(winit,powerinit);
title("Initial Power Spectrum")
xlabel("angular frequency")
ylabel("power")
figure()
semilogy(wfinal,powerfinal);
title("Initial Power Spectrum")
xlabel("angular frequency")
ylabel("power")
