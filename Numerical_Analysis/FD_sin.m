%    Script:   Finite difference method

n = 100;
x = linspace(-pi, pi, n+1);      % discretize the interval [-pi, pi] into n+1 subintervals
h = 2*pi/n;                      % h = step size

d = zeros(1,n+1);                % Initialize the derivatives as a n+1 dimensional row vector

for i = 1:(n+1)
    d(i) = (sin(x(i) + h) - sin(x(i)))/h;
end

%   Plot the derivative 

plot(x, d)
hold on
%  We also plot the analytic derivative of sin(x)

plot(x, cos(x))
legend('numerical', 'analytic')