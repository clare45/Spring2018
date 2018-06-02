%% hw5
Q = 8E6;
S0 = 250;
P = 16000;
alpha = 75;

%%% part a
r = 2;
Qhl = 21600;
A = Q*(1+r)/Qhl;
Kg = 50 + 1000* (10^(-.000055*(Q*(1+r)/A)));

%%% part b
Se = 30;
fun = @(H) Kg*log((S0+r*Se)/(Se*(1+r))) + (S0-Se)/(1+r) - P*alpha*A*H/(Q*(1+r));
x0 = [0,10];
H = fzero(fun,x0);

%%% part c

%%% part d
Q_range = linspace(10.^4,10.^7,200);
Kg_range = 50 + 1000* (10.^(-.000055*(Q_range*(1+r)/A)));
figure()
loglog(Q_range,Kg_range)
xlabel('Flow (L/d)')
ylabel('Kg (mg BOD/L')

%%  part e
%find minimum Se for all r's 
%plot Se as fcn of r
r = 0;
while r < 200
r_vec(r+1) = r;
Kg = 50 + 1000* (10^(-.000055*(Q*(1+r)/A)));
funE = @(Se) Kg*log((S0+r*Se)/(Se*(1+r))) + (S0-Se)/(1+r) - P*alpha*A*H/(Q*(1+r));
x0 = [.01,250];
Se1(r+ 1) = fzero(funE,x0);
r = r + 1;
end
figure()
plot(r_vec, Se1)
xlabel('recycle ratios')
ylabel('Effluent BOD')

Se_min = min(Se1);
r_best = r_vec(find(Se1 == Se_min)); %make this work right!

%% Question 2 %%

%%% part d 

%does zero recycle work?
r = 0;
Kg2 = 50 + 1000* (10^(-.000055*(Q*(1+r)/A)));
fun2 = @(Se) Kg2*log((S0+r*Se)/(Se*(1+r))) + (S0-Se)/(1+r) - P*alpha*A*H/(Q*(1+r));
x0 = [.01,1000];
Se2 = fzero(fun2,x0); %85


%no, some recycle is needed.
while Se2 > 30  
    Kg2 = 50 + 1000* (10^(-.000055*(Q*(1+r)/A)));
    fun2 = @(Se) Kg2*log((S0+r*Se)/(Se*(1+r))) + (S0-Se)/(1+r) - P*alpha*A*H/(Q*(1+r));
    x0 = [15, 86];
    Se2 = fzero(fun2,x0);
    r = r + .01;
end 




