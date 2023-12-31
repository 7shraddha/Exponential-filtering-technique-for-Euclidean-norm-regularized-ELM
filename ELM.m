function [res,TrainingTime,C] = ELM(TrainingData_File, TestingData_File, Elm_Type, NumberofHiddenNeurons, ActivationFunction)



CLASSIFIER=1;

%Load training dataset
train_data=TrainingData_File;
T=train_data(:,end)';
train_label = train_data(:,end)'; 

P=train_data(:,1:size(train_data,2)-1)';
clear train_data;                                   %   Release raw training data array

% Load testing dataset
test_data=TestingData_File;
TV.T=test_data(:,end)';
test_label= test_data(:,end)';

TV.P=test_data(:,1:size(test_data,2)-1)';
clear test_data;                                    %   Release raw testing data array

NumberofTrainingData=size(P,2);
NumberofTestingData=size(TV.P,2);
NumberofInputNeurons=size(P,1);

if Elm_Type~=REGRESSION
    % Preprocessing the data of classification
    sorted_target=sort(cat(2,T,TV.T),2);
    label=zeros(1,1);                               %   Find and save in 'label' class label from training and testing data sets
    label(1,1)=sorted_target(1,1);
    j=1;
    for i = 2:(NumberofTrainingData+NumberofTestingData)
        if sorted_target(1,i) ~= label(1,j)
            j=j+1;
            label(1,j) = sorted_target(1,i);
        end
    end
    number_class=j;
    NumberofOutputNeurons=number_class;
       
    %Processing the targets of training
    temp_T=zeros(NumberofOutputNeurons, NumberofTrainingData);
    for i = 1:NumberofTrainingData
        for j = 1:number_class
            if label(1,j) == T(1,i)
                break; 
            end
        end
        temp_T(j,i)=1;
    end
    T=temp_T*2-1;

    % Processing the targets of testing
    temp_TV_T=zeros(NumberofOutputNeurons, NumberofTestingData);
    for i = 1:NumberofTestingData
        for j = 1:number_class
            if label(1,j) == TV.T(1,i)
                break; 
            end
        end
        temp_TV_T(j,i)=1;
    end
    TV.T=temp_TV_T*2-1;

end                                                 %   end if of Elm_Type

%Calculate weights & biases
start_time_train=cputime;

% Random generate input weights InputWeight (w_i) and biases BiasofHiddenNeurons (b_i) of hidden neurons
InputWeight=rand(NumberofHiddenNeurons,NumberofInputNeurons)*2-1;
BiasofHiddenNeurons=rand(NumberofHiddenNeurons,1);
tempH=InputWeight*P;
clear P;                                            %   Release input of training data 
ind=ones(1,NumberofTrainingData);
BiasMatrix=BiasofHiddenNeurons(:,ind);              %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
tempH=tempH+BiasMatrix;

% Calculate hidden neuron output matrix H
switch lower(ActivationFunction)
    case {'sig','sigmoid'}
        %%%%%%%% Sigmoid 
        H = 1 ./ (1 + exp(-tempH));
    case {'sin','sine'}
        %%%%%%%% Sine
        H = sin(tempH);    
    case {'hardlim'}
        %%%%%%%% Hard Limit
        H = double(hardlim(tempH));
    case {'tribas'}
        %%%%%%%% Triangular basis function
        H = tribas(tempH);
    case {'radbas'}
        %%%%%%%% Radial basis function
        H = radbas(tempH);
        %%%%%%%% More activation functions can be added here                
end
clear tempH;                                        %   Release the temparary array for calculation of hidden neuron output matrix H

% Calculate output weights OutputWeight (beta_i)

ill_cond = cond(H');
dlmwrite ('ill_condition.csv', ill_cond, '-append');

[U,s,V] = csvd(H');
delta = 10^(-6);


[reg_min,G,reg_param] = gcv(U,s,train_label','Tikh');
C = 1/reg_min;

OutputWeight=(eye(size(H,1))/C+H * H') \ H * T';      % faster method 2 //refer to 2012 IEEE TSMC-B paper

end_time_train=cputime;
TrainingTime=end_time_train-start_time_train;        %   Calculate CPU time (seconds) spent for training ELM

%Calculate the training accuracy
Y=(H' * OutputWeight)';                             %   Y: the actual output of the training data
if Elm_Type == REGRESSION
    TrainingAccuracy=sqrt(mse(T - Y));               %   Calculate training accuracy (RMSE) for regression case
end
clear H;

% Calculate the output of testing input
start_time_test=cputime;
tempH_test=InputWeight*TV.P;
clear TV.P;             %   Release input of testing data             
ind=ones(1,NumberofTestingData);
BiasMatrix=BiasofHiddenNeurons(:,ind);              %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
tempH_test=tempH_test + BiasMatrix;
switch lower(ActivationFunction)
    case {'sig','sigmoid'}
        % Sigmoid 
        H_test = 1 ./ (1 + exp(-tempH_test));
    case {'sin','sine'}
        % Sine
        H_test = sin(tempH_test);        
    case {'hardlim'}
        % Hard Limit
        H_test = hardlim(tempH_test);        
    case {'tribas'}
        % Triangular basis function
        H_test = tribas(tempH_test);        
    case {'radbas'}
        % Radial basis function
        H_test = radbas(tempH_test);        
        % More activation functions can be added here        
end
TY=(H_test' * OutputWeight)';                       %   TY: the actual output of the testing data
end_time_test=cputime;

TestingTime=end_time_test-start_time_test;           %   Calculate CPU time (seconds) spent by ELM predicting the whole testing data

if Elm_Type == REGRESSION
    TestingAccuracy=sqrt(mse(TV.T - TY))            %   Calculate testing accuracy (RMSE) for regression case
end

if Elm_Type == CLASSIFIER
% Calculate training & testing classification accuracy
    [value,computed_label] = max(TY);
    
    [conf_mat_test1,Result]= confusion.getMatrix(test_label,computed_label);

% conf_mat_test1
    accuracy_p=100 * Result.Accuracy;
    precision_p = 100 * Result.Precision;
    Recall_p = 100 * Result.Sensitivity;
    Specificity_p =  100 * Result.Specificity;
    f1_measure_p = 100 * Result.F1_score;
    res = [accuracy_p, precision_p, Recall_p,Specificity_p,f1_measure_p];
 
end