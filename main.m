% ELM code
clc;
close all;
clear all;
 
tr_data = csvread('pima_n.csv');


L = 0; 
res11 =[];
res11_f=[];

for j=1:50
L = L + 20;
for i = 1:5

data1 = tr_data(randperm(size(tr_data,1)),:);
data = [zscore(data1(:,1:end-1)),data1(:,end)];
train_set = data(1:512,1:end);
test_set = data(513:end,1:end);
[res, training_time, C] = ELM(train_set,test_set,1,L, 'sig');
[res_f, training_time_f, C_f] = ELM_fraction(train_set,test_set,1,L, 'sig');
res1 = [res, training_time,C];
res1_f = [res_f, training_time,C];
res11 = [res11; res1 ];
res11_f = [res11_f; res1_f  ];
dlmwrite ('results.csv',res1, '-append');
dlmwrite ('results_f.csv',res1_f, '-append');
end

% res_total = csvread('results.csv');
std_dev = std(res11(:,1));


res_mean =  [mean(res11), std_dev ];
dlmwrite ('finRESULTS.csv', res_mean, '-append');

% res_total_f = csvread('results_f.csv');
std_dev_f = std(res11_f(:,1));


res_mean_f =  [mean(res11_f), std_dev_f ];
dlmwrite ('finRESULTS_f.csv', res_mean_f, '-append');

end
