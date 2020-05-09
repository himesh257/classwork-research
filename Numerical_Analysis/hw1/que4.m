format long

%Used functions
f=@(x)([x(1)-x(1).^2-x(2).^2;x(2)-x(1).^2+x(2).^2]);
J=@(x)([1-2*x(1) -2*x(2);-2*x(1) 1-2*x(2)]);

%initial guess starting with x=0.5 and y=0.5 (from the question):
init_guess=[.5;.5];
fprintf('Initial guess: \n x = %.2f, y = %.2f ',init_guess(1),init_guess(2))

%tolerence
tol = 10e-14;

% iteration variable initialized to 1 and will be incremented in the loop
iteration = 1; 
error=1;  

while (error>tol)
    % x_before is the old value meaning the initail guess of the function
    x_before = init_guess;
    
    %equation of newton's method
    init_guess = init_guess - J(init_guess); 
    
    % error is the difference between older value of x and initial guess
    error = norm(init_guess-x_before);
    fprintf('\nIteration = %2i \n f(x) = [%20.15f ,%20.15f] ',[iteration;f(init_guess)])
    iteration = iteration+1;
end

fprintf('Solution (comparing till 14 decimal places): ')
x=init_guess(1)
y=init_guess(2)
format