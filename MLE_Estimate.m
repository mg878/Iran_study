% This script computes a maximum likelihood estimate for the COVID-19 
% outbreak size in Iran based on a Binomial distribution.
%Only the first part of the code is commented because the rest is a
% duplicate of the first part with different variable names.
%% Global variables
close all;
% Catchment population
M = 2.78e7;
% Detection accuracy
Detection = 0.6250;
% Variation in airplane seating capacity
Airplane_cap =0.75;
% Exposure time
t=10;
%% Oman
% Increment in outbreak size
Index = 100:100:5e6;
% Exposure time
% Daily passenger flux
D_oman = Airplane_cap*2660/7;
% Probability of a passenger being infected
p_oman = t*D_oman/M;
% Confirmed cases
n_oman = ceil(2/Detection);
% The likelihood function
f_oman = @(x) nchoosek(x,n_oman)*(p_oman^n_oman)*(1-p_oman)^(x-n_oman);
% Counter for easier implementation
counter = 1;
% The likelihood vector
y_oman = zeros(1,length(Index));
% This loop computes the likelihood of finding those reported number of
% cases with variations in the outbreak size
for i=100:100:Index(end)
    y_oman(counter) = f_oman(i);
    counter = counter +1;
end
% Finding the 95% CI
sum_o = 0;
integ = sum(y_oman);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y_oman(counter);
    if (sum_o>2.3e-2*integ) && (sum_o<2.7e-2*integ)
        lower_bound _om = Index(counter);
    elseif (sum_o>97.3e-2*integ) && (sum_o<97.7e-2*integ)
        upper_bound _om = Index(counter);
    end
    counter = counter+1;
end
% Finding the maximum likelihood estimate

[Est_om,Est_om _i] = max(y_oman);
figure;
subplot(3,2,1);
I = find(Index>= lower_bound _om & Index <= upper_bound _om);
X = Index(min(I):max(I));
Y = y_oman(min(I):max(I));
area(X,Y,'DisplayName','$$95\%$$ CI',...
    'FaceColor',[0.843137254901961 0.894117647058824 0.968627450980392],...
    'EdgeColor','none');
hold on;
plot(Index,y_oman,'DisplayName','Likelihood','LineWidth',2);
ylabel('Likelihood','FontSize',14,'Interpreter','latex'); 
xlabel('Outbreak Size $$\lambda$$','FontSize',14,'Interpreter','latex');
title('Likelihood Function - Oman','FontSize',14,'Interpreter','latex');
clc;

%% UAE
clear lower_bound;
clear upper_bound;
D_UAE = Airplane_cap*13430/7;
p_UAE = t*D_UAE/M;
n_UAE = ceil(2/Detection);
f_UAE = @(x) nchoosek(x,n_UAE)*(p_UAE^n_UAE)*(1-p_UAE)^(x-n_UAE);
counter = 1;
y_U = zeros(1,length(Index));
for i=100:100:Index(end)
    y_U(counter) = f_UAE(i);
    counter = counter +1;
end
sum_o=0;
integ = sum(y_U);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y_U(counter);
    if (sum_o>2e-2*integ) && (sum_o<3e-2*integ)
        lower_bound _U = Index(counter);
    elseif (sum_o>97.35e-2*integ) && (sum_o<97.65e-2*integ)
        upper_bound _U = Index(counter);
    end
    counter = counter+1;
end
[Est_UAE,Est_UAE _i] = max(y_U);
subplot(3,2,2);
I = find(Index>= lower_bound _U & Index <= upper_bound _U);
X = Index(min(I):max(I));
Y = y_U(min(I):max(I));
area(X,Y,'DisplayName','$$95\%$$ CI',...
    'FaceColor',[0.843137254901961 0.894117647058824 0.968627450980392],...
    'EdgeColor','none');
hold on;
plot(Index,y_U,'DisplayName','Likelihood','LineWidth',2);
ylabel('Likelihood','FontSize',14,'Interpreter','latex'); 
xlabel('Outbreak Size $$\lambda$$','FontSize',14,'Interpreter','latex');
title('Likelihood Function - UAE','FontSize',14,'Interpreter','latex');
clc;
%% Kuwait
clear lower_bound;
clear upper_bound;
D_Ku = Airplane_cap*4025/7;
p_Ku = t*D_Ku/M;
n_Ku = ceil(3/Detection);
f_Ku = @(x) nchoosek(x,n_Ku)*(p_Ku^n_Ku)*(1-p_Ku)^(x-n_Ku);
counter = 1;
y_K = zeros(1,length(Index));
for i=100:100:Index(end)
    y_K(counter) = f_Ku(i);
    counter = counter +1;
end
sum_o=0;
integ = sum(y_K);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y_K(counter);
    if (sum_o>2.3e-2*integ) && (sum_o<2.7e-2*integ)
        lower_bound _K = Index(counter);
    elseif (sum_o>97.3e-2*integ) && (sum_o<97.7e-2*integ)
        upper_bound _K = Index(counter);
    end
    counter = counter+1;
end
[Est_Ku,Est_Ku _i] = max(y_K);
subplot(3,2,3);
I = find(Index>= lower_bound _K & Index <= upper_bound _K);
X = Index(min(I):max(I));
Y = y_K(min(I):max(I));
area(X,Y,'DisplayName','$$95\%$$ CI',...
    'FaceColor',[0.843137254901961 0.894117647058824 0.968627450980392],...
    'EdgeColor','none');
hold on;
plot(Index,y_K,'DisplayName','Likelihood','LineWidth',2);
ylabel('Likelihood','FontSize',14,'Interpreter','latex'); 
xlabel('Outbreak Size $$\lambda$$','FontSize',14,'Interpreter','latex');
title('Likelihood Function - Kuwait','FontSize',14,'Interpreter','latex');
clc;
%% Iraq
clear lower_bound;
clear upper_bound;
D_Ir = Airplane_cap*16254/7;
p_Ir = t*D_Ir/M;
n_Ir = ceil(1/Detection);
f_Ir = @(x) nchoosek(x,n_Ir)*(p_Ir^n_Ir)*(1-p_Ir)^(x-n_Ir);
counter = 1;
y_I = zeros(1,length(Index));
for i=100:100:Index(end)
    y_I(counter) = f_Ir(i);
    counter = counter +1;
end
sum_o=0;
integ = sum(y_I);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y_I(counter);
    if (sum_o>1.5e-2*integ) && (sum_o<3.5e-2*integ)
        lower_bound _I = Index(counter);
    elseif (sum_o>97.3e-2*integ) && (sum_o<97.7e-2*integ)
        upper_bound _I = Index(counter);
    end
    counter = counter+1;
end
[Est_Ir,Est_Ir _i] = max(y_I);
subplot(3,2,4);
I = find(Index>= lower_bound _I & Index <= upper_bound _I);
X = Index(min(I):max(I));
Y = y_I(min(I):max(I));
area(X,Y,'DisplayName','$$95\%$$ CI',...
    'FaceColor',[0.843137254901961 0.894117647058824 0.968627450980392],...
    'EdgeColor','none');
hold on;
plot(Index,y_I,'DisplayName','Likelihood','LineWidth',2);
ylabel('Likelihood','FontSize',14,'Interpreter','latex'); 
xlabel('Outbreak Size $$\lambda$$','FontSize',14,'Interpreter','latex');
title('Likelihood Function - Iraq','FontSize',14,'Interpreter','latex');
clc;
%% China
D_Ch = Airplane_cap*4500/7;
p_Ch = t*D_Ch/M;
n_Ch = ceil(28/Detection);
% Normal Approximation
f_Ch = @(x) exp(-0.5*(((n_Ch-x*p_Ch)^2)/(x*p_Ch*(1-p_Ch))));
counter = 1;
y_C = zeros(1,length(Index));
for i=100:100:Index(end)
    y_C(counter) = f_Ch(i);
    counter = counter +1;
end
sum_o=0;
integ = sum(y_C);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y_C(counter);
    if (sum_o>2.3e-2*integ) && (sum_o<2.7e-2*integ)
        lower_bound _C = Index(counter);
    elseif (sum_o>97.3e-2*integ) && (sum_o<97.7e-2*integ)
        upper_bound _C = Index(counter);
    end
    counter = counter+1;
end
[Est_Ch,Est_Ch _i] = max(y_C);
subplot(3,2,5); grid;
I = find(Index>= lower_bound _C & Index <= upper_bound _C);
X = Index(min(I):max(I));
Y = y_C(min(I):max(I));
area(X,Y,'DisplayName','$$95\%$$ CI',...
    'FaceColor',[0.843137254901961 0.894117647058824 0.968627450980392],...
    'EdgeColor','none');
hold on;
plot(Index,y_C,'DisplayName','Likelihood','LineWidth',2);
ylabel('Likelihood','FontSize',14,'Interpreter','latex'); 
xlabel('Outbreak Size $$\lambda$$','FontSize',14,'Interpreter','latex');
title('Likelihood Function - China','FontSize',14,'Interpreter','latex');
clc;
%% Lebanon
clear lower_bound;
clear upper_bound;
D_Lb = Airplane_cap*800/7;
p_Lb = t*D_Lb/M;
n_Lb = ceil(1/Detection);
f_Lb = @(x) nchoosek(x,n_Lb)*(p_Lb^n_Lb)*(1-p_Lb)^(x-n_Lb);
counter = 1;
y_L = zeros(1,length(Index));
for i=1000:100:Index(end)
    y_L(counter) = f_Lb(i);
    counter = counter +1;
end
sum_o=0;
integ = sum(y_L);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y_L(counter);
    if (sum_o>2.3e-2*integ) && (sum_o<2.7e-2*integ)
        lower_bound _L = Index(counter);
    elseif (sum_o>97.3e-2*integ) && (sum_o<97.7e-2*integ)
        upper_bound _L = Index(counter);
    end
    counter = counter+1;
end
[Est_Lb,Est_Lb _i] = max(y_L);
subplot(3,2,6);
subplot(3,2,6);
I = find(Index>= lower_bound _L & Index <= upper_bound _L);
X = Index(min(I):max(I));
Y = y_L(min(I):max(I));
area(X,Y,'DisplayName','$$95\%$$ CI',...
    'FaceColor',[0.843137254901961 0.894117647058824 0.968627450980392],...
    'EdgeColor','none');
hold on;
plot(Index,y_L,'DisplayName','Likelihood','LineWidth',2);
ylabel('Likelihood','FontSize',14,'Interpreter','latex'); 
xlabel('Outbreak Size $$\lambda$$','FontSize',14,'Interpreter','latex');
title('Likelihood Function - Lebanon','FontSize',14,'Interpreter','latex');
clc;
%% Overall likelihood for Feb
y_overallf = y_K.*y_L.*y_oman.*y_U;
y_overallf = y_overallf/sum(y_overallf);
% Find the CI 
sum_o=0;
counter =1;
[Est_O,Est_O _i] = max(y_overallf);
while counter<length(Index)
    sum_o = sum_o + y_overallf(counter);
    if (sum_o>2e-2) && (sum_o<3e-2)
        lower_bound = Index(counter);
    elseif (sum_o>97.3e-2) && (sum_o<97.7e-2)
        upper_bound = Index(counter);
    end
    counter = counter+1;
end
figure;
I = find(Index>= lower_bound & Index <= upper_bound);
X = Index(min(I):max(I));
Y = y_overallf(min(I):max(I));
area(X,Y,'DisplayName','$$95\%$$ CI',...
    'FaceColor',[0.843137254901961 0.894117647058824 0.968627450980392],...
    'EdgeColor','none');
hold on;
plot(Index(1:600),y_overallf(1:600),'DisplayName','Likelihood','LineWidth',2);
ylabel('Likelihood','FontSize',14,'Interpreter','latex'); 
xlabel('Outbreak Size $$\lambda$$','FontSize',14,'Interpreter','latex');
title('Feb','FontSize',14,'Interpreter','latex');
%% Printing The MLEs and CIs
fprintf('Oman \n');
fprintf('% d (% d - % d)\n',Index(Est_om _i),lower_bound _om,upper_bound _om);
fprintf('UAE \n');
fprintf('% d (% d - % d)\n',Index(Est_UAE _i),lower_bound _U,upper_bound _U);
fprintf('Kuwait \n');
fprintf('% d (% d - % d)\n',Index(Est_Ku _i),lower_bound _K,upper_bound _K);
fprintf('Iraq \n');
fprintf('% d (% d - % d)\n',Index(Est_Ir _i),lower_bound _I,upper_bound _I);
fprintf('Lebanon \n');
fprintf('% d (% d - % d)\n',Index(Est_Lb _i),lower_bound _L,upper_bound _L);
fprintf('China \n');
fprintf('% d (% d - % d)\n',Index(Est_Ch _i),lower_bound _C,upper_bound _C);
fprintf('Overall \n');
fprintf('% d (% d - % d)\n',Index(Est_O _i),lower_bound,upper_bound);
