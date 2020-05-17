%% calculating the frequency of first digit occurance in the data of reported
% cases and deaths for Iran, the US, and the UK and comparing to the 
% Benford distribution to examine irregularities in data

clear; close all

%% data of reported cases and reported deaths for Iran, the US, and the UK
data = struct('ind',{[],[],[]});

iran_case = [2,5,18,29,43,61,95,139,245,388,593,978,1501,2336,2922,3513,4747,5823,6566,7161,8042,9000,10075,11364,12729,13938,14991,16169,17361,18407,19644,20610,21638,23049,24811,27017,29406,32332,35408,38309,41495,44605,47593]; % Iran reported cases from Feb19 to Apr1
iran_death = [2,2,4,6,8,12,16,19,26,34,43,54,66,77,92,108,124,145,194,237,291,354,429,514,611,724,853,988,1135,1284,1433,1556,1685,1812,1934,2077,2234,2378,2517,2640,2757,2898,3036,3160,3294,3452,3603,3739,3872,3993,4110,4232]; % Iran reported deaths from Feb19 to Apr10
iran_data = [iran_case iran_death]; % combining total reported cases and deaths into one larger data set

us_case = [15,15,35,35,35,53,57,60,60,63,68,75,100,124,158,221,319,435,541,704,994,1301,1630,2183,2771,3617,4604,6357,9317,13898,19551,24418,33840,44189,55398,68905,86379,105217,124788,144980,168177,193353,220295]; % US reported cases from Feb19 to Apr1
us_death = [1,1,6,9,11,12,15,19,22,26,30,38,41,48,58,73,95,121,171,239,309,374,509,689,957,1260,1614,2110,2754,3251,4066,5151,6394,7576,8839,10384,11793,13298,15526,17691,19802,22038]; % US reported deaths from Feb29 to Apr10
us_data = [us_case us_death]; % combining total reported cases and deaths into one larger data set
    
uk_case = [9,9,13,13,13,13,16,20,23,36,39,51,87,116,164,209,278,321,383,460,590,798,1140,1391,1543,1950,2626,3269,3983,5018,5683,6650,8077,9529,11658,14543,17089,19522,22141,25150,29474]; % UK reported cases from Feb21 to Apr1
uk_death = [1,2,2,3,5,6,8,10,11,21,35,55,71,104,144,177,233,281,335,422,463,578,759,1019,1228,1408,1789,2352,2921,3605,4313,4934,5373,6159,7097,7978,8958]; % UK reported deaths from Mar5 to Apr10
uk_data = [uk_case uk_death]; %c ombining total reported cases and deaths into one larger data set
    
data(1).ind = iran_data;
data(2).ind = us_data;
data(3).ind = uk_data;


%% begin sampling of data and counting the frequency of first digits
loops = 5; %number of times we sample the data
num = 40; %size of sample

firstdig_stat = zeros(loops,9,size(data,2));

for counts = 1:size(data,2)
    
    for iters = 1:loops
        
        r = randperm(size(data(counts).ind,2)); % to randomly sample data of each country
        
        firstdig = zeros(num,1);
        
        %% finding the first digit and counting it's frequency of occurance
        for i = 1:num
            x = data(counts).ind(r(i));
            y = num2str(x);
            firstdig(i) = str2num(y(1));
        end
        
        for j = 1:9
            temp = find(firstdig==j);
            firstdig_stat(iters,j,counts) = size(temp,1);
        end
        
    end
end

%% finding the mean and standard deviation of the frequency of first digit occurance over the number of times we samle the data and normalizing them by the sample size
firstdig_stat_avgs = zeros(3,9);
firstdig_stat_stds = zeros(3,9);

for i =1:size(data,2)
    
firstdig_stat_avgs(i,:) = mean(firstdig_stat(:,:,i))/num;
firstdig_stat_stds(i,:) = std(firstdig_stat(:,:,i))/num;
    
end

%% Benford distribution
ben = zeros(1,9);
for j = 1:9 
    ben(j) = log10(1+(1/j));
end

%% plot the probability distributions and the error bars
bpcombined = [firstdig_stat_avgs(1,:); firstdig_stat_avgs(2,:); firstdig_stat_avgs(3,:); ben(1,:)]';
std_dev = [firstdig_stat_stds(1,:); firstdig_stat_stds(2,:); firstdig_stat_stds(3,:); zeros(1,9)]';
num = 9; % number of different subcategories
horizontal = 1:num;

figure;
hold on

hb = bar(horizontal, bpcombined, 'grouped');

% Errorbar
errH1 = errorbar(horizontal-0.265,bpcombined(:,1),std_dev(:,1),'.','Color','k');
errH2 = errorbar(horizontal-0.09,bpcombined(:,2),std_dev(:,2),'.','Color','k');
errH3 = errorbar(horizontal+0.09,bpcombined(:,3),std_dev(:,3),'.','Color','k');

errH1.LineWidth = 1;
errH2.LineWidth = 1;
errH3.LineWidth = 1;

axis([0 9.9 0 0.4])
xticks([1 2 3 4 5 6 7 8 9])

set(gca,'LineWidth',2); % changes the boarder line width
set(gca,'FontSize',25); % changes the axis markers font size
set(gca,'FontName','Times');
set(gca,'FontWeight','Demi');
set(gca,'Box','on');

set(get( gca, 'XLabel' ), 'Interpreter', 'latex' );
set(get( gca, 'YLabel' ), 'Interpreter', 'latex' );

ylabel('Probability','FontSize',25);
xlabel('First digit','FontSize',25);

legend({'Iran', 'USA', 'UK', 'BL probability distribution'});

