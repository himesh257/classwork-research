format short e

% function (given in question)
f=@(x) (1-cos(x))./(x.^2);

% dynamically passing the value of x and raising it to the base of 10
x=-1:-1:-8; % starting from -1 and goes till -8
x=10.^x;  % 10^-1, 10^-2, ..., 10^-8

% running a for loop until 10^-8 is reached
for i=1:length(x)
    
    % num2str method is used in order to convert numbers to characters
    % abs method is used to get the absolute value
    disp(['x = ' num2str(x(i)) ', f(x)=' num2str(f(x(i))) ' |f(x)-1/2| is ' num2str(abs(f(x(i))-1/2))]);
end