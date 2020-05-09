function [m,y_final] = q4(A,x)
m=2;
n=length(x);
y_final=x;
tol=1e-10; 
while(1)
     y_old=y_final; 
     y_final=A*y_final;
     if abs(m) < tol && norm(y_final-y_old,2) < tol %// Change - Check for both
         break;
     end
end
end

%A = [6 4 4 1;4 6 1 4;4 1 6 4;1 4 4 6];
%x = [1;0;0;0];
