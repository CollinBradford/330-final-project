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
F(2)=-k(1)/m(2)*(u(1)-x1(t))+k(2)/m(2)*(u(3)-u(1));

F(3)=u(4);

F(4)=-k(2)/m(3)*(u(3)-u(1));
