%% Physics 330 Final Project
clear; close all;

%global vars
global m;
global k;
global x1;
m = [0,0];
k = [0,0];

tinit = 0;
tfinal = 1000;

t = 0:1:tfinal;
x1 = wgn(length(t),1,10);

%initial conditions
u0=zeros(4,1);
u0(1)=0;
u0(2)=0;
u0(3)=0;
u0(4)=0;

%standard options
options=odeset('RelTol',1e-8);

%numerical solver
[t,u]=ode45(@rhsF_1,t,u0,options);