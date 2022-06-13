function F=rhsF_1(t,u)
%pre-allocate memory for f
F=zeros(length(u),1);
%global vars needed
global m;
global k;
global forcingFunction;
global tfactor;

F(1)=u(2);
F(2)=-k(1)/m(1)*(u(1)-forcingFunction(round(t*tfactor)))+k(2)/m(1)*(u(3)-u(1));
F(3)=u(4);
F(4)=-k(2)/m(2)*(u(3)-u(1))+k(3)/m(3)*(u(5)-u(3));
F(5)=u(6);
F(6)=-k(3)/m(3)*(u(5)-u(3));
