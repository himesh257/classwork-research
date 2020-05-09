%    Script: A quick introduction to matlab

%    To clear the command window, we can use clc
clc
%%    Use matlab as a calcuator
1+2;

%    To supress the output, we can use semicolon ';'
1-2;

%    variable and assignment
a = 1;
b = 2;
c = a+b;
a^2; 


%%    Matlab has a long list of built in functions

%    sin, cos
sin(pi/2);
cos(pi);

%    natural log

log(10);

%    help and doc command
help log;
% doc log

%%   Matrix and Vector

A = [1,2;3,4];

v = [5,6];     % row vector
w = [5;6];      % column vector

%    size of matrix and length of vector


%    Matrix multiplication

A * w;
v * A;

%    Matrix transpose
A';
A * v';

%    dot product
v * w;

%    element wise product
v;
u = [1,2];
v .* u;      % NOTE THAT '.*' denotes the element wise product



%%   Define functions

%    In matlab, there are two ways to define a function. 
%    First, define a function in a separate m file, see sigmoid.m as an
%    example

%    Second, define a function as a handle

sigma = @(x) 1./(1+exp(-x));

%    Evaluate sigma at x = 0
sigma(0);

%%   Plot 

x = linspace(-10,10, 21);      %  discrete the interval [-1,1] into 20 subintervals
y = sigmoid(x);              %  evaluate the sigmoid function at the points x_i

%    To plot the function y = sigmoid(x)

plot(x,y)
legend('sigmoid function')
title('Plot sigmoid function')





