prompt = ('Enter the initial balance ');
x = input(prompt);
prompt1 = ('Enter the rate as a percentage ');
y = input(prompt1);

p = round((x*((y)/100)*12)-5,6);
q = p - x;

prompt2 = ('New balance');
disp(['New Balance ', num2str(p-5)])
prompt3 = ('Interest Gained');
disp(['Interest Gained ', num2str(q)])
disp('Note that a $5 checking fee was deducted')