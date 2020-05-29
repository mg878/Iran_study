%This script computes a maximum likelihood estimate for the COVID-19 
%outbreak size in Iran based on a Binomial distribution.
%Only the first part of the code is commented because the rest is a
%duplicate of the first part with different variable names.
%% Global variables
close all;
% Catchment population
M = 5.56e7;
% Detection accuracy
Detection = 0.3;
% Variation in airplane seating capacity
Airplane_cap =0.9;
%% Oman
% Increment in outbreak size
Index = 100:100:5e4;
% Exposure time
t_oman = 54;
% Daily passenger flux
D_oman = Airplane_cap*2660/7;
% Probability of a passenger being infected
p_oman = t_oman*D_oman/M;
% Confirmed cases
n_oman = ceil(2/Detection);
% The likelihood function
f_oman = @(x) nchoosek(x,n_oman)*(p_oman^n_oman)*(1-p_oman)^(x-n_oman);
% Counter for easier implementation
counter = 1;
% The likelihood vector
y = zeros(1,length(Index));
% This loop computes the likelihood of finding those reported number of
% cases with variations in the outbreak size
for i=100:100:5e4
    y(counter) = f_oman(i);
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
figure;
subplot(3,2,1);
scatter(Index,y); title('Oman (a)','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_om_i),Est_om,'r','filled');
hold on;
scatter(lower_bound,f_oman(lower_bound),'r','filled');
hold on;
scatter(upper_bound,f_oman(upper_bound),'r','filled');
clc;
% Perfect Detection scenario
clear upper_bound;
clear lower_bound;
Index = 100:100:5e4;
t_oman = 54;
D_oman = 2660/7;
p_oman = t_oman*D_oman/M;
n_oman = 2;
f_oman = @(x) nchoosek(x,n_oman)*(p_oman^n_oman)*(1-p_oman)^(x-n_oman);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:5e4
    y(counter) = f_oman(i);
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
[Est_om,Est_om_i] = max(y);
hold on;
scatter(Index,y,'g'); 
hold on;
scatter(Index(Est_om_i),Est_om,'r','filled');
hold on;
scatter(lower_bound,f_oman(lower_bound),'r','filled');
hold on;
scatter(upper_bound,f_oman(upper_bound),'r','filled');
clc;

%% UAE
clear lower_bound;
clear upper_bound;
Index = 100:100:5e4;
t_UAE = 52;
D_UAE = Airplane_cap*13430/7;
p_UAE = t_UAE*D_UAE/M;
n_UAE = ceil(2/Detection);
f_UAE = @(x) nchoosek(x,n_UAE)*(p_UAE^n_UAE)*(1-p_UAE)^(x-n_UAE);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:5e4
    y(counter) = f_UAE(i);
    counter = counter +1;
end
sum_o=0;
integ = sum(y);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y(counter);
    if (sum_o>2e-2*integ) && (sum_o<3e-2*integ)
        lower_bound = Index(counter);
    elseif (sum_o>97.35e-2*integ) && (sum_o<97.65e-2*integ)
        upper_bound = Index(counter);
    end
    counter = counter+1;
end
[Est_UAE,Est_UAE_i] = max(y);
subplot(3,2,2);
scatter(Index,y); title( 'UAE (b)','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_UAE_i),Est_UAE,'r','filled');
hold on;
scatter(lower_bound,f_UAE(lower_bound),'r','filled');
hold on;
scatter(upper_bound,f_UAE(upper_bound),'r','filled');
clc;

% Perfect
clear lower_bound;
clear upper_bound;
Index = 100:100:5e4;
t_UAE = 52;
D_UAE = 13430/7;
p_UAE = t_UAE*D_UAE/M;
n_UAE = ceil(2/1);
f_UAE = @(x) nchoosek(x,n_UAE)*(p_UAE^n_UAE)*(1-p_UAE)^(x-n_UAE);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:5e4
    y(counter) = f_UAE(i);
    counter = counter +1;
end
sum_o=0;
integ = sum(y);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y(counter);
    if (sum_o>1.5e-2*integ) && (sum_o<3.5e-2*integ)
        lower_bound = Index(counter);
    elseif (sum_o>97.35e-2*integ) && (sum_o<97.65e-2*integ)
        upper_bound = Index(counter);
    end
    counter = counter+1;
end
[Est_UAE,Est_UAE_i] = max(y);
hold on;
scatter(Index,y,'g'); 
hold on;
scatter(Index(Est_UAE_i),Est_UAE,'r','filled');
hold on;
scatter(lower_bound,f_UAE(lower_bound),'r','filled');
hold on;
scatter(upper_bound,f_UAE(upper_bound),'r','filled');
clc;
%% Kuwait
clear lower_bound;
clear upper_bound;
Index = 100:100:5e4;
t_Ku = 55;
D_Ku = Airplane_cap*4025/7;
p_Ku = t_Ku*D_Ku/M;
n_Ku = ceil(3/Detection);
f_Ku = @(x) nchoosek(x,n_Ku)*(p_Ku^n_Ku)*(1-p_Ku)^(x-n_Ku);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:5e4
    y(counter) = f_Ku(i);
    counter = counter +1;
end
sum_o=0;
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
scatter(Index,y); title('Kuwait (c)','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_Ku_i),Est_Ku,'r','filled');
hold on;
scatter(lower_bound,f_Ku(lower_bound),'r','filled');
hold on;
scatter(upper_bound,f_Ku(upper_bound),'r','filled');
clc;

%Perfect Sc
clear lower_bound;
clear upper_bound;
Index = 100:100:5e4;
t_Ku = 55;
D_Ku = 1*4025/7;
p_Ku = t_Ku*D_Ku/M;
n_Ku = ceil(3/1);
f_Ku = @(x) nchoosek(x,n_Ku)*(p_Ku^n_Ku)*(1-p_Ku)^(x-n_Ku);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:5e4
    y(counter) = f_Ku(i);
    counter = counter +1;
end
sum_o=0;
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
hold on;
scatter(Index,y,'g');
hold on;
scatter(Index(Est_Ku_i),Est_Ku,'r','filled');
hold on;
scatter(lower_bound,f_Ku(lower_bound),'r','filled');
hold on;
scatter(upper_bound,f_Ku(upper_bound),'r','filled');
clc;
%% Iraq
clear lower_bound;
clear upper_bound;
Index = 100:100:5e4;
t_Ir = 54;
D_Ir = Airplane_cap*16254/7;
p_Ir = t_Ir*D_Ir/M;
n_Ir = ceil(1/Detection);
f_Ir = @(x) nchoosek(x,n_Ir)*(p_Ir^n_Ir)*(1-p_Ir)^(x-n_Ir);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:30000
    y(counter) = f_Ir(i);
    counter = counter +1;
end
sum_o=0;
integ = sum(y);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y(counter);
    if (sum_o>1.5e-2*integ) && (sum_o<3.5e-2*integ)
        lower_bound = Index(counter);
    elseif (sum_o>97.3e-2*integ) && (sum_o<97.7e-2*integ)
        upper_bound = Index(counter);
    end
    counter = counter+1;
end
[Est_Ir,Est_Ir_i] = max(y);
subplot(3,2,4);
scatter(Index,y); title('Iraq (d)','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_Ir_i),Est_Ir,'r','filled');
hold on;
scatter(lower_bound,f_Ir(lower_bound),'r','filled');
hold on;
scatter(upper_bound,f_Ir(upper_bound),'r','filled');
clc;

%Perfect Sc
clear lower_bound;
clear upper_bound;
Index = 100:100:5e4;
t_Ir = 54;
D_Ir = 1*16254/7;
p_Ir = t_Ir*D_Ir/M;
n_Ir = ceil(1/1);
f_Ir = @(x) nchoosek(x,n_Ir)*(p_Ir^n_Ir)*(1-p_Ir)^(x-n_Ir);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:30000
    y(counter) = f_Ir(i);
    counter = counter +1;
end
sum_o=0;
integ = sum(y);
counter =1;
while counter<length(Index)
    sum_o = sum_o + y(counter);
    if  (sum_o<10e-2*integ)
        lower_bound = Index(counter);
    elseif (sum_o>97.3e-2*integ) && (sum_o<97.7e-2*integ)
        upper_bound = Index(counter);
    end
    counter = counter+1;
end
[Est_Ir,Est_Ir_i] = max(y);
hold on;
scatter(Index,y,'g'); 
hold on;
scatter(Index(Est_Ir_i),Est_Ir,'r','filled');
hold on;
scatter(lower_bound,f_Ir(lower_bound),'r','filled');
hold on;
scatter(upper_bound,f_Ir(upper_bound),'r','filled');
clc;
%% China
Index = 100:100:3e5;
t_Ch = 65;
D_Ch = Airplane_cap*4500/7;
p_Ch = t_Ch*D_Ch/M;
n_Ch = ceil(28/Detection);
% Normal Approximation
f_Ch = @(x) exp(-0.5*(((n_Ch-x*p_Ch)^2)/(x*p_Ch*(1-p_Ch))));
counter = 1;
y = zeros(1,length(Index));
for i=100:100:3e5
    y(counter) = f_Ch(i);
    counter = counter +1;
end
sum_o=0;
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
subplot(3,2,5); grid;
scatter(Index,y); title('China (e)','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_Ch_i),Est_Ch,'r','filled');
hold on;
scatter(lower_bound,f_Ch(lower_bound),'r','filled');
hold on;
scatter(upper_bound,f_Ch(upper_bound),'r','filled');
clc;

%Perfect Sc
% China
Index = 100:100:3e5;
t_Ch = 65;
D_Ch = 1*6700/7;
p_Ch = t_Ch*D_Ch/M;
n_Ch = ceil(28/1);
% Normal Approximation
f_Ch = @(x) exp(-0.5*(((n_Ch-x*p_Ch)^2)/(x*p_Ch*(1-p_Ch))));
counter = 1;
y = zeros(1,length(Index));
for i=100:100:3e5
    y(counter) = f_Ch(i);
    counter = counter +1;
end
sum_o=0;
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
hold on;
scatter(Index,y,'g'); 
hold on;
scatter(Index(Est_Ch_i),Est_Ch,'r','filled');
hold on;
scatter(lower_bound,f_Ch(lower_bound),'r','filled');
hold on;
scatter(upper_bound,f_Ch(upper_bound),'r','filled');
clc;
%% Lebanon
clear lower_bound;
clear upper_bound;
Index = 100:100:1e5;
t_Lb = 51;
D_Lb = Airplane_cap*800/7;
p_Lb = t_Lb*D_Lb/M;
n_Lb = ceil(1/Detection);
f_Lb = @(x) nchoosek(x,n_Lb)*(p_Lb^n_Lb)*(1-p_Lb)^(x-n_Lb);
counter = 1;
y = zeros(1,length(Index));
for i=1000:100:100000
    y(counter) = f_Lb(i);
    counter = counter +1;
end
sum_o=0;
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
[Est_Lb,Est_Lb_i] = max(y);
subplot(3,2,6);
scatter(Index,y); title('Lebanon (f)','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_Lb_i),Est_Lb,'r','filled');
hold on;
scatter(lower_bound,f_Lb(lower_bound),'r','filled');
hold on;
scatter(upper_bound,f_Lb(upper_bound),'r','filled');
clc;

% Perfect
clear lower_bound;
clear upper_bound;
Index = 100:100:1e5;
t_Lb = 51;
D_Lb = 1*800/7;
p_Lb = t_Lb*D_Lb/M;
n_Lb = ceil(1/1);
f_Lb = @(x) nchoosek(x,n_Lb)*(p_Lb^n_Lb)*(1-p_Lb)^(x-n_Lb);
counter = 1;
y = zeros(1,length(Index));
for i=1000:100:100000
    y(counter) = f_Lb(i);
    counter = counter +1;
end
sum_o=0;
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
[Est_Lb,Est_Lb_i] = max(y);
hold on;
scatter(Index,y,'g'); 
hold on;
scatter(Index(Est_Lb_i),Est_Lb,'r','filled');
hold on;
scatter(lower_bound,f_Lb(lower_bound),'r','filled');
hold on;
scatter(upper_bound,f_Lb(upper_bound),'r','filled');
clc;
%% UAE+Oman+Kuwait+Lebanon
clear lower_bound;
clear upper_bound;
Index = 1000:100:30000;
sum_o=0;
t_o = 40;
D_o = Airplane_cap*26815/7;
p_o = t_o*D_o/M;
n_o = ceil(9/Detection);
f_o = @(x) nchoosek(x,n_o)*(p_o^n_o)*(1-p_o)^(x-n_o);
counter = 1;
y = zeros(1,length(Index));
for i=1000:100:30000
    y(counter) = f_o(i);
    counter = counter +1;
end
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

[Est_o,Est_o_i] = max(y);
figure;
scatter(Index,y); title('Likelihood Function','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_o_i),Est_o,'r+');
hold on;
scatter(lower_bound,f_o(lower_bound),'r+');
hold on;
scatter(upper_bound,f_o(upper_bound),'r+');
clc;
clear lower_bound;
clear upper_bound;
Index = 1000:100:30000;
sum_o=0;
t_o = 40;
D_o = 1*26815/7;
p_o = t_o*D_o/M;
n_o = ceil(9/1);
f_o = @(x) nchoosek(x,n_o)*(p_o^n_o)*(1-p_o)^(x-n_o);
counter = 1;
y = zeros(1,length(Index));
for i=1000:100:30000
    y(counter) = f_o(i);
    counter = counter +1;
end
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

[Est_o,Est_o_i] = max(y);
hold on;
scatter(Index,y,'g'); title('Likelihood Function','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_o_i),Est_o,'r+');
hold on;
scatter(lower_bound,f_o(lower_bound),'r+');
hold on;
scatter(upper_bound,f_o(upper_bound),'r+');
clc;
