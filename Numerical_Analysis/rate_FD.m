%      Script:    rate of convergence of finite difference method applied
%      on sin(x) at x = pi/3

%      Step 1:    find the finite difference for step size h = [0.1, 0.01, ..., 1e^-16]

format short e
h = logspace(-1, -15, 15);
d = zeros(1, 15);
for i = 1:15
    d(i) = (sin(pi/3 + h(i)) - sin(pi/3))/h(i);
end


%      Step 2:    Compute the error 

err = d - cos(pi/3)

% Observation:  for h = 1e-1, ... 1e-8, the error convergence O(h) as
% predicted in the theory
% However, as h decrease further, the error starts to increase. 
% Why? 



