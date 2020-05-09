% to get the hilbert matrix of n dim
H = hilb(16);
disp(H)

% generating y
y = []
for x = 1:16
    y(x) = 1/sqrt(x)
end
disp(y')
b = H*y'
z = H\b

(norm(H*z - b))/(norm(b))
cond(H)

(norm(H*z - b))/(norm(b)) * cond(H)