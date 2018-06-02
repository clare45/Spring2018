%%hw3 biodeg and biocat
Xi  = 1E6; %cells/L
Si = 200; %umoles/L
Q = .25; %L/day
S0 = 200; %umoles,day
K = 0.1; %umole/L
qmax = 5.38E-9; %umoles/cells/day
Y = 1.6E8; %cellsX/umolesTCE
b = 0.05;% per day
V = 1; %liter
min = 10*24*60;
deltat = 0.00208333333; %three minutes in days
t = (0:deltat:12)';  %time from 0 to 10 days
S(1) = Si;
X(1) = Xi;
ds_dt(1) = 0;
dx_dt(1) = 0;
for i = 2:length(t)
    ds_dt(i) = (Q*Si/V) - (Q*S(i-1)/V) - (Y*qmax*S(i-1)*X(i-1)/(K+S(i-1)));
    S(i) = S(i-1) - (ds_dt(i)*deltat);
    dx_dt(i) = 0 -Q*X(i-1)/V + (Y*ds_dt(i) - b*X(i-1));
    X(i) = X(i-1) + dx_dt(i)*deltat;
end
figure()
plot(t,S)
figure()
plot(t,X)











%% Batch: ugh
 %this is three minutes in days
part1 = K/(Xi+ (Y*Si));
part2 = part1 + (1/Y);
part3 = log(Xi)/Y;
s_t(1) = Si;
x_t(1) = Xi;
for i = 2:length(t)
   fun = @(S) -t(i)+ (((part2*log(Xi + Y*Si - Y*S)) - ((part1)*log(S*Xi/Si)) - (part3)))/qmax;
   x0 = [3, 200];
   s_t(i) = fzero(fun, x0);
   x_t(i) = Xi +  Y*(Si-s_t(i)) - b*t(i)*x_t(i-1);
end
figure()
plot(t, s_t)
xlabel('time in days')
ylabel('Substrate concentration in umoles/L')
figure()
plot(t, x_t)
xlabel('time in days')
ylabel('cells/ L')

%above is all for a batch reactor which is really really not what we're
%doing









%%% do this tomorrow when you go in to lab...so go early 
