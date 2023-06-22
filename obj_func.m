function out  = obj_func(alpha,A,lam,b,given_lab)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
x=((A'*A)^((alpha+1)/2)+lam*eye(size(A'*A)))\ ((A'*A)^((alpha-1)/2))*A'*b;
TY = (A*real(x))';
[M,computed_lab] = max(TY);

[conf_MAT,Result] = confusionmat(given_lab,computed_lab);
[conf_mat_test1,Result]= confusion.getMatrix(given_lab,computed_lab);
out = 1- (Result.Accuracy *  Result.Sensitivity * Result.Specificity);
% Accuracy = (sum(diag(conf_MAT))/sum(conf_MAT(:)));
% out = 1-Accuracy;
end

