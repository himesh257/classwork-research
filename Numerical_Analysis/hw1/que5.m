% fcnns function (given)
fcnns=@(x) [x(1)-x(1)^2-x(2)^2;x(2)-x(1)^2+x(2)^2];

% from the code given in the question
options = optimset('Display', 'iter');
x0 = [0.5,0.5];
[x,fval] = fsolve(fcnns,x0,options)
