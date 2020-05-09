% to get the hilbert matrix of n dim
H = hilb(8);
disp(H)

% generating y
y = []
for x = 1:8
    y(x) = 1/sqrt(x)
end
disp(y')
b = H*y'
z = H\b
x = y
(norm(H*z - b))/(norm(b))
cond(H)
(norm(H*z - b))/(norm(b)) * cond(H)
(norm(x - z))/(norm(x))