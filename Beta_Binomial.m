%This script computes a maximum likelihood estimate for the COVID-19 
%outbreak size in Iran based on a Beta-Binomial distribution.
%Only the first part of the code is commented because the rest is a
%duplicate of the first part with different variable names.
%% Global variables
close all;
% Catchment population
M_min = 4e7;
M_max = 5.56e7;
% Detection accuracy
Detection = 0.5;
% Variation in airplane seating capacity
Airplane_cap =0.9;
% Marginal integration step
l = 100;
% Beta distribution shape parameters
alpha_o = 2;
beta_o = 2;
% Exposure time 
t_min = 24;
t_max = 54;
%% Oman
% Increment in outbreak size
Index = 100:100:5e4;
% Daily passenger flux 
D_oman = Airplane_cap*2660/7;
% Support for p (zeta in the paper)
p_min = D_oman*t_min/M_max;
p_max = D_oman*t_max/M_min;
% Number of confirmed cases
n_oman = ceil(2/Detection);
% Counter for easier implementation
counter = 1;
% The likelihood vector 
y = zeros(1,length(Index));
% This loop calculates the likelihood by performing a marginal integration
% on the Beta distribution. The integration is done in the function name
% mrgint.m
for i=100:100:5e4
    y(counter) = mrgint(i,n_oman,alpha_o,beta_o,p_min,p_max,l);
    counter = counter +1;
end
% Finding the 95% CI
sum_o = 0;
integ = sum(y);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y(counter);
    if (sum_o>2.3e-2*integ) && (sum_o<2.7e-2*integ)
        lower_bound = Index(counter);
    elseif (sum_o>97.3e-2*integ) && (sum_o<97.7e-2*integ)
        upper_bound = Index(counter);
    end
    counter = counter+1;
end
% Finding the maximum likelihood estimate
[Est_om,Est_om_i] = max(y);
subplot(3,2,1);
scatter(Index,y);title('Likelihood Function - Oman','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_om_i),Est_om,'r','filled');
hold on;
scatter(lower_bound,mrgint(lower_bound,n_oman,alpha_o,beta_o,p_min,p_max,l),'r','filled');
hold on;
scatter(upper_bound,mrgint(upper_bound,n_oman,alpha_o,beta_o,p_min,p_max,l),'r','filled');
clc;
%% UAE 
clear lower_bound;
clear upper_bound;
Index = 100:100:2e4;
D_UAE = Airplane_cap*13430/7;
p_min = D_UAE*t_min/M_max;
p_max = D_UAE*t_max/M_min;
n_UAE = ceil(2/Detection);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:2e4
    y(counter) = mrgint(i,n_UAE,alpha_o,beta_o,p_min,p_max,l);
    counter = counter +1;
end
sum_o = 0;
integ = sum(y);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y(counter);
    if (sum_o>2e-2*integ) && (sum_o<3e-2*integ)
        lower_bound = Index(counter);
    elseif (sum_o>97.3e-2*integ) && (sum_o<97.7e-2*integ)
        upper_bound = Index(counter);
    end
    counter = counter+1;
end
[Est_UAE,Est_UAE_i] = max(y);
subplot(3,2,2); 
scatter(Index,y);title('Likelihood Function - UAE','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_UAE_i),Est_UAE,'r','filled');
hold on;
scatter(lower_bound,mrgint(lower_bound,n_UAE,alpha_o,beta_o,p_min,p_max,l),'r','filled');
hold on;
scatter(upper_bound,mrgint(upper_bound,n_UAE,alpha_o,beta_o,p_min,p_max,l),'r','filled');
clc;
%% Kuwait
clear lower_bound;
clear upper_bound;
Index = 100:100:5e4;
D_Ku = Airplane_cap*4025/7;
p_min = D_Ku*t_min/M_max;
p_max = D_Ku*t_max/M_min;
n_Ku = ceil(3/Detection);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:5e4
    y(counter) = mrgint(i,n_Ku,alpha_o,beta_o,p_min,p_max,l);
    counter = counter +1;
end
sum_o = 0;
integ = sum(y);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y(counter);
    if (sum_o>2.3e-2*integ) && (sum_o<2.7e-2*integ)
        lower_bound = Index(counter);
    elseif (sum_o>97.3e-2*integ) && (sum_o<97.7e-2*integ)
        upper_bound = Index(counter);
    end
    counter = counter+1;
end
[Est_Ku,Est_Ku_i] = max(y);
subplot(3,2,3); 
scatter(Index,y);title('Likelihood Function - Kuwait','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_Ku_i),Est_Ku,'r','filled');
hold on;
scatter(lower_bound,mrgint(lower_bound,n_Ku,alpha_o,beta_o,p_min,p_max,l),'r','filled');
hold on;
scatter(upper_bound,mrgint(upper_bound,n_Ku,alpha_o,beta_o,p_min,p_max,l),'r','filled');
clc;
%% Iraq
clear lower_bound;
clear upper_bound;
Index = 100:100:2e4;
D_Ir = Airplane_cap*16254/7;
p_min = D_UAE*t_min/M_max;
p_max = D_UAE*t_max/M_min;
n_Ir = ceil(1/Detection);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:2e4
    y(counter) = mrgint(i,n_Ir,alpha_o,beta_o,p_min,p_max,l);
    counter = counter +1;
end
sum_o = 0;
integ = sum(y);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y(counter);
    if (sum_o<5e-2*integ)
        lower_bound = Index(counter);
    elseif (sum_o>97.3e-2*integ) && (sum_o<97.7e-2*integ)
        upper_bound = Index(counter);
    end
    counter = counter+1;
end
[Est_Ir,Est_Ir_i] = max(y);
subplot(3,2,4); 
scatter(Index,y);title('Likelihood Function - Iraq','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_Ir_i),Est_Ir,'r','filled');
hold on;
scatter(lower_bound,mrgint(lower_bound,n_Ir,alpha_o,beta_o,p_min,p_max,l),'r','filled');
hold on;
scatter(upper_bound,mrgint(upper_bound,n_Ir,alpha_o,beta_o,p_min,p_max,l),'r','filled');
clc;
%% China
clear lower_bound;
clear upper_bound;
Index = 100:100:3e5;
t_min = t_min-10;
t_max = t_max+10;
D_Ch = Airplane_cap*6700/7;
p_min = D_Ch*t_min/M_max;
p_max = D_Ch*t_max/M_min;
n_Ch = ceil(28/Detection);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:3e5
    y(counter) = mrgint(i,n_Ch,alpha_o,beta_o,p_min,p_max,l);
    counter = counter +1;
end
sum_o = 0;
integ = sum(y);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y(counter);
    if (sum_o>2.3e-2*integ) && (sum_o<2.7e-2*integ)
        lower_bound = Index(counter);
    elseif (sum_o>97.3e-2*integ) && (sum_o<97.7e-2*integ)
        upper_bound = Index(counter);
    end
    counter = counter+1;
end
[Est_Ch,Est_Ch_i] = max(y);
subplot(3,2,5); 
scatter(Index,y);title('Likelihood Function - China','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_Ch_i),Est_Ch,'r','filled');
hold on;
scatter(lower_bound,mrgint(lower_bound,n_Ch,alpha_o,beta_o,p_min,p_max,l),'r','filled');
hold on;
scatter(upper_bound,mrgint(upper_bound,n_Ch,alpha_o,beta_o,p_min,p_max,l),'r','filled');
clc;

%% Lebanon
clear lower_bound;
clear upper_bound;
Index = 100:100:1e5;
t_min = 24;
t_max = 54;
D_L = Airplane_cap*800/7;
p_min = D_L*t_min/M_max;
p_max = D_L*t_max/M_min;
n_L = ceil(1/Detection);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:1e5
    y(counter) = mrgint(i,n_L,alpha_o,beta_o,p_min,p_max,l);
    counter = counter +1;
end
sum_o = 0;
integ = sum(y);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y(counter);
    if (sum_o>2.3e-2*integ) && (sum_o<2.7e-2*integ)
        lower_bound = Index(counter);
    elseif (sum_o>97.3e-2*integ) && (sum_o<97.7e-2*integ)
        upper_bound = Index(counter);
    end
    counter = counter+1;
end
[Est_Le,Est_Le_i] = max(y);
subplot(3,2,6); 
scatter(Index,y);title('Likelihood Function - Lebanon','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_Le_i),Est_Le,'r','filled');
hold on;
scatter(lower_bound,mrgint(lower_bound,n_L,alpha_o,beta_o,p_min,p_max,l),'r','filled');
hold on;
scatter(upper_bound,mrgint(upper_bound,n_L,alpha_o,beta_o,p_min,p_max,l),'r','filled');
clc;
%% Total 
clear lower_bound;
clear upper_bound;
Index = 100:100:5e4;
t_min = 24;
t_max = 54;
D_t = Airplane_cap*7485/7;
p_min = D_t*t_min/M_max;
p_max = D_t*t_max/M_min;
n_t = ceil(6/Detection);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:5e4
    y(counter) = mrgint(i,n_t,alpha_o,beta_o,p_min,p_max,l);
    counter = counter +1;
end
sum_o = 0;
integ = sum(y);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y(counter);
    if (sum_o>2.3e-2*integ) && (sum_o<2.7e-2*integ)
        lower_bound = Index(counter);
    elseif (sum_o>97.3e-2*integ) && (sum_o<97.7e-2*integ)
        upper_bound = Index(counter);
    end
    counter = counter+1;
end
figure1 = figure;
axes1 = axes(figure1);
I = find(Index>= lower_bound & Index <= upper_bound);
X = Index(min(I):max(I));
Y = y(min(I):max(I));
area(X,Y,'DisplayName','$$95\%$$ CI',...
    'FaceColor',[0.843137254901961 0.894117647058824 0.968627450980392],...
    'EdgeColor','none');
hold on;
plot(Index,y,'DisplayName','Likelihood','LineWidth',2);
ylabel('Likelihood','FontSize',14,'Interpreter','latex'); 
xlabel('Outbreak Size $$\lambda$$','FontSize',14,'Interpreter','latex');
title('25th Feb (a)','FontSize',15,'Interpreter','latex');
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'LineWidth',1);
% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Interpreter','latex','FontSize',11);
clear figure1;
%% China for 6th March
clear lower_bound;
clear upper_bound;
Index = 100:100:3e5;
t_min = t_min-10;
t_max = t_max+10;
D_Ch = Airplane_cap*6700/7;
p_min = D_Ch*t_min/M_max;
p_max = D_Ch*t_max/M_min;
n_Ch = ceil(28/Detection);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:3e5
    y(counter) = mrgint(i,n_Ch,alpha_o,beta_o,p_min,p_max,l);
    counter = counter +1;
end
sum_o = 0;
integ = sum(y);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y(counter);
    if (sum_o>2.3e-2*integ) && (sum_o<2.7e-2*integ)
        lower_bound = Index(counter);
    elseif (sum_o>97.3e-2*integ) && (sum_o<97.7e-2*integ)
        upper_bound = Index(counter);
    end
    counter = counter+1;
end
figure1 = figure;
axes1 = axes(figure1);
I = find(Index>= lower_bound & Index <= upper_bound);
X = Index(min(I):max(I));
Y = y(min(I):max(I));
area(X,Y,'DisplayName','$$95\%$$ CI',...
    'FaceColor',[0.843137254901961 0.894117647058824 0.968627450980392],...
    'EdgeColor','none');
hold on;
plot(Index,y,'DisplayName','Likelihood','LineWidth',2);
ylabel('Likelihood','FontSize',14,'Interpreter','latex');
xlabel('Outbreak Size $$\lambda$$','FontSize',14,'Interpreter','latex');
title('6th March (b)','FontSize',15,'Interpreter','latex');
box(axes1,'on');
set(axes1,'LineWidth',1);
legend2 = legend(axes1,'show');
set(legend2,'Interpreter','latex','FontSize',11);
