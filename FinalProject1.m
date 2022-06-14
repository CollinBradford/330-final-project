%% Physics 330 Final Project
clear; close all;

% file name that describes the run so that the variables can be saved.
runName = "run-one";

%global vars
global m;
global k;
global forcingFunction;
m = [1,2,3];
k = [1,2,2];

% multiplies the timestep by this value so that we can use the wgn
% generator to get white noise. The multiplication is needed so that the
% timestep can be changed into an int which allows accessing the array. 
global tfactor;
tfactor = 1e1;

% time info
tinit = 1;
tfinal = 1000;
timestep = 0.001;

forcingFunction = wgn(tfinal*tfactor,1,10);

%initial conditions
u0=zeros(6,1);

%standard options
options=odeset('RelTol',1e-3);

%numerical solver
[t,u]=ode45(@rhsF_1,tinit:timestep:tfinal,u0,options);

% sort the x vals into an array
u=transpose(u);
numMasses = size(u);
numMasses = numMasses(1)/2;
xvals = zeros(numMasses,length(u(1,:)));
for i=1:2:numMasses*2
    xvals(ceil(i/2),:) = u(i,:);
end

% calculate initial power spectrum
powerinit = abs(fft(forcingFunction)).^2;

% calculate the angular frequency scale
tau = tfactor^-1; 
N = length(forcingFunction);
% Find dw
dw=2*pi/(N*tau);
%w=0:dw:2*pi/tau-dw;
winit = -(N/2)*dw:dw:dw*(N/2-1);

% calculate the angular frequency scale for masses
tau = tfinal/length(t);
N = length(t);
% Find dw
dw=2*pi/(N*tau);
%w=0:dw:2*pi/tau-dw;
wMasses = -(N/2)*dw:dw:dw*(N/2-1);

% calculate the power spectrum for each mass
powerMasses = zeros(numMasses,length(u));
for i=1:numMasses
    powerMasses(i,:) = abs(fft(xvals(i,:))).^2;
end

clear dw i N options tau u0

% save everything for future use
save(runName + "_variables.mat")

%% figures
close all;
clear

% run name is the run name of the file that will be accessed and plotted.
runName = "run-one";

% load data
load(runName + "_variables.mat")

% plot forcing function
figure()
tx = 0:tfactor^-1:tfinal;
plot(tx(1:end-1),forcingFunction)
title("forcing function") 
xlabel("time")
ylabel("amplitude")

% plot mass positions
for i=1:numMasses
    figure()
    plot(t,xvals(i,:))
    title("Mass " + int2str(i))
    xlabel("time")
    ylabel("amplitude")
end

% plot power spectrum of forcing function
figure()
semilogy(winit,powerinit);
title("Initial Power Spectrum")
xlabel("angular frequency")
ylabel("power")

% plot power spectra of masses
for i=1:numMasses
    figure()
    semilogy(wMasses,powerMasses(i,:));
    title("Power Spectrum Mass " + int2str(i))
    xlabel("angular frequency")
    ylabel("power")
end
