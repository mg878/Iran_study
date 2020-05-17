%% This Script generates Likelihood plots for outbreak size estimation in Iran for Covid-19 
% The estimate is based on likelihood maximisation but it could be
% incorporated with a prior fo MAP. The estimates and plots are generated
% based on the countries outside Iran that have reported infected
% passengers arriving.
%% Global variables 
M = 5.56e7;
Detection = 0.5;
Airplane_cap =0.9;
%% Oman
Index = 100:100:30000;
t_oman = 54;
D_oman = Airplane_cap*2660/7;
p_oman = t_oman*D_oman/M;
n_oman = ceil(2/Detection);
f_oman = @(x) nchoosek(x,n_oman)*(p_oman^n_oman)*(1-p_oman)^(x-n_oman);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:30000
    y(counter) = f_oman(i);
    counter = counter +1;
end
[Est_om,Est_om _i] = max(y);
figure;
subplot(3,2,1);
scatter(Index,y); title('Likelihood Function - Oman','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_om _i),Est_om,'r');
%% UAE
t_UAE = 52;
D_UAE = Airplane_cap*13430/7;
p_UAE = t_UAE*D_UAE/M;
n_UAE = ceil(3/Detection);
f_UAE = @(x) nchoosek(x,n_UAE)*(p_UAE^n_UAE)*(1-p_UAE)^(x-n_UAE);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:30000
    y(counter) = f_UAE(i);
    counter = counter +1;
end
[Est_UAE,Est_UAE _i] = max(y);
subplot(3,2,2);
scatter(Index,y); title('Likelihood Function - UAE','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_UAE _i),Est_UAE,'r');
%% Kuwait
t_Ku = 55;
D_Ku = Airplane_cap*4025/7;
p_Ku = t_Ku*D_Ku/M;
n_Ku = ceil(3/Detection);
f_Ku = @(x) nchoosek(x,n_Ku)*(p_Ku^n_Ku)*(1-p_Ku)^(x-n_Ku);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:30000
    y(counter) = f_Ku(i);
    counter = counter +1;
end
[Est_Ku,Est_Ku _i] = max(y);
subplot(3,2,3);
scatter(Index,y); title('Likelihood Function - Kuwait','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_Ku _i),Est_Ku,'r');
%% Iraq
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
[Est_Ir,Est_Ir _i] = max(y);
subplot(3,2,4);
scatter(Index,y); title('Likelihood Function - Iraq','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_Ir _i),Est_Ir,'r');
%% China
Index = 100:1000:100000;
t_Ch = 65;
D_Ch = Airplane_cap*4500/7;
p_Ch = t_Ch*D_Ch/M;
n_Ch = ceil(28/Detection);
f_Ch = @(x) nchoosek(x,n_Ch)*(p_Ch^n_Ch)*(1-p_Ch)^(x-n_Ch);
counter = 1;
y = zeros(1,length(Index));
for i=100:1000:100000
    y(counter) = f_Ch(i);
    counter = counter +1;
end
[Est_Ch,Est_Ch _i] = max(y);
subplot(3,2,5); grid; 
scatter(Index,y); title('Likelihood Function - China','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_Ch _i),Est_Ch,'r');
%% Lebanon
Index = 100:100:100000;
t_Lb = 51;
D_Lb = Airplane_cap*800/7;
p_Lb = t_Lb*D_Lb/M;
n_Lb = ceil(1/Detection);
f_Lb = @(x) nchoosek(x,n_Lb)*(p_Lb^n_Lb)*(1-p_Lb)^(x-n_Lb);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:100000
    y(counter) = f_Lb(i);
    counter = counter +1;
end
[Est_Lb,Est_Lb _i] = max(y);
subplot(3,2,6);
scatter(Index,y); title('Likelihood Function - Lebanon','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_Lb _i),Est_Lb,'r');
%% UAE+Oman+Kuwait+Lebanon 
Index = 100:100:150000;
sum_o=0;
t_o = 65;
D_o = Airplane_cap*6700/7;
p_o = t_o*D_o/M;
n_o = ceil(28/Detection);
f_o = @(x) nchoosek(x,n_o)*(p_o^n_o)*(1-p_o)^(x-n_o);
counter = 1;
y = zeros(1,length(Index));
for i=100:100:150000
    y(counter) = f_o(i);
    sum_o = sum_o+y(counter);
    counter = counter +1;
    if (sum_o>2.3e-2*sum(y)) && (sum_o<2.7e-2*sum(y))
        lower_bound = Index(counter);
    elseif (sum_o>97.3e-2*sum(y)) && (sum_o<97.7e-2*sum(y))
        upper_bound = Index(counter);
    end
end
[Est_o,Est_o _i] = max(y);
figure;
scatter(Index,y); title('Likelihood Function','Interpreter','latex'); ylabel('Likelihood','Interpreter','latex'); xlabel('Outbreak Size $$\lambda$$','Interpreter','latex');
hold on;
scatter(Index(Est_o _i),Est_o,'r');
hold on; 
scatter(lower_bound,f_o(lower_bound),'r');
hold on;
scatter(upper_bound,f_o(upper_bound),'r');