%% homework 3 question 5
Q = 10^8; %L/day
S0 = 200; %mg/LBOD
XV0 = 100; %mg/L VSS
fd = .8; 
Y = .5; %g Xa/g BOD
b = 0.1; %per day
q_hat = 8; %g BOD/L
K = 25; %mg BOD/L

theta_min = (K+S0)/(S0*(Y*q_hat - b) - b*K);
Xi0 = (1-fd)*XV0;
theta = linspace(theta_min, 20, 200);

for i = 1:size(theta,2)
    fun = 1+(b*theta(i));
    term1 = (1+((1-fd)*(b*theta(i)))/(fun));
    term2 = S0 - ((K*fun)/((Y*q_hat*theta(i))-(fun)));
    combo(i) = Q*(Xi0 + (Y*term1*term2));
end
figure
 combo = combo/100000; %to make it from  mg to kg
plot(theta, combo)


for i = 1:size(theta,2)
    fun = 1+(b*theta(i));
    term1 = (K*fun)/(Y*q_hat*theta(i) - fun);
    term2 = (S0 - term1)*fd/fun;
    xaq(i) = Q*Y*term2;
end
hold on
 xaq = xaq/100000; %to make it from  mg to kg
plot(theta, xaq)
title('X_a and X_v in waste')
ylabel('mass per day (kg/day)')
xlabel('theta_x (days)')
legend('X_v', 'X_a', 'Location', 'EAST')

    