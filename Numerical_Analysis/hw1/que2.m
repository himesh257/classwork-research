% BISECTION METHOD
% given function
f = @(x) x^3+x-4;
e=1e-3;

% a is the left endpoint of interval containing the root
a=1;

% b is the right endpoint of interval containing the root
b=4;
iteration = 0;

% checking if the root exists
if f(a)*f(b)>=0
    disp('No Root')
else
    previous1 = (a+b)/2;
    previous2=a;
    
    % checking if the value of (a+b)/2 is bigger than e and if so, running the loop
    while (abs(previous2-previous1)>e)
        % swapping
        previous1=previous2;

        % incrementing the iteration
        iteration =iteration+ 1;
        previous2 = (a+b)/2;

        % if (a+b)/2 is zero, then breaking out of the loop
        if f(previous2) == 0
            break;
        end

        if f(a)*f(previous2)<0
            b = previous2;
        else
            a = previous2;
        end
        fprintf('Iteration %d\n root=%2.8f \n',iteration,previous2);
        
        % if desired accuracy is not found by 100th iteration, then stop
        if(iteration==50)
            disp('\naccuracy not found');
        end
    end 
end

% displaying total number of iteration and final approaximation
disp('Number of iterations for Bisection method')
disp(iteration)
disp('Final approaximation (Bisection method)')
disp(previous2)

disp('------------------------------------------------------------------')

% NEWTON'S METHOD
% given functions
f = @(x) x^3+x-4;
g=@(x) 3*x^2+1;

% initializing the variables
x=1;
e=1e-3;

% maximum number (limit)
maximum=50;

% swapping
y=x;
x=0;
Number=0;
while 1
    % checking if the difference is bigger than the error
    if abs((y-x))>e
        x=y;
        y=x-(f(x)/g(x));
        
        % increamenting the variable
        Number=Number+1;
        
        % printing out the results
        fprintf('Iteration %d\n root=%2.8f \n',Number,y);
    else
        break;
    end
    
    % if the maximum number is reached then breaking out of the loop
    if(Number == maximum)
        break;
    end

end

root=y;
iter=Number;
disp('Number of iteration for Newton method')
disp(iter)
disp('Final approaximation (Newton method)')
disp(root)

