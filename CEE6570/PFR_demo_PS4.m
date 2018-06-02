
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


fun = @(S)   1/theta_x + b - ( (Y*q_hat*(S_0-S))/( (S_0-S) + ((1+r)*log((r*S+S_0)/((1+r)*S)))*K  ) );

x0 = [.0001 600]; %interval to search for solutions

S = fzero(fun,x0) %find roots of nonlinear function 
 






