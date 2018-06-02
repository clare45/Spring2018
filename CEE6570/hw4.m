
%solids retention time
theta_x = .4;

%kinetic constants
b = .05;
Y = .5;
q_hat = 15;
K = 30;
S_0 = 500;
Q = 10000;
Qr = 15000;
r = Qr/Q

%% CSTR
theta_min_c = (K+S_0)/((S_0*(Y*q_hat - b)) - b*K)

%% PFR
fun = @(S)   1/theta_x + b - ( (Y*q_hat*(S_0-S))/( (S_0-S) + ((1+r)*log((r*S+S_0)/((1+r)*S)))*K  ) );

x0 = [.0001 600]; %interval to search for solutions

S = fzero(fun,x0) %find roots of nonlinear function 

%if "no" treatment is occuring
S = 499.9999999999999;
fun2 = @(theta_x)   1/theta_x + b - ( (Y*q_hat*(S_0-S))/( (S_0-S) + ((1+r)*log((r*S+S_0)/((1+r)*S)))*K  ) );
x1 = [.0001 600]; %interval to search for solutions
theta_min_p = fzero(fun2,x1); %find roots of nonlinear function 
%.1342 days/.1423 if you don't get ridiculous with the 9's

%% plotting (part iii)
 
thetas = linspace(theta_min_c, .4, 100);

for i = 1:length(thetas)
    fun = @(S)   1/thetas(i) + b - ( (Y*q_hat*(S_0-S))/( (S_0-S) + ((1+r)*log((r*S+S_0)/((1+r)*S)))*K  ) );
    s_pfr(i) = fzero(fun,x0);
    s_cstr(i) = K*(1+(b*thetas(i)))/((Y*q_hat*thetas(i) - (1 + (b*thetas(i)))));
end
figure()
plot(thetas, s_pfr, thetas, s_cstr)
xlabel('theta_x (days)')
ylabel('Effluent substrate concentration (mg/L)')
legend('PFR', 'CSTR')

%% plots (part iv)
theta = 0.3;
r_var = [0.5, 1.5, 5]; 
s_pfr_r_var = zeros(1, length(r_var));

%r_var = linspace(.5, 200, 300);
for i = 1:length(r_var)
    fun = @(S)   1/theta + b - ( (Y*q_hat*(S_0-S))/( (S_0-S) + ((1+r_var(i))*log((r_var(i)*S+S_0)/((1+r_var(i))*S)))*K  ) );
    s_pfr_r_var(i) = fzero(fun,x0);
end
figure()
plot(r_var, s_pfr_r_var,'o')
xlabel('recycle ratio')
ylabel('effluent substrate concentrations')
axis([0 inf 0 inf]) 
%levels off (~24.61!, though at 5 it looks like it keeps increasing.

%change in gradient when getting clearer influent

%

%% 


