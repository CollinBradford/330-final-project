function F=rhsF_1(t,u)
%pre-allocate memory for f
F=zeros(length(u),1);
%global vars needed
global m;
global k;
global x1;

%dtheta/dt=thetadot
F(1)=u(2);
%dthetadot/dt=given function
floor(t * 10000)
F(2)=-k(1)/m(1)*(u(1)-x1(floor(t*10000)))+k(2)/m(1)*(u(3)-u(1));

F(3)=u(4);

F(4)=-k(2)/m(2)*(u(3)-u(1));
