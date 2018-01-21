function [ cM ] = calcConfusionMatrix( Lclass, Ltrue )
%CALCCONFUSIONMATRIX calculates the confusion matrix from the predicted
%class labels and true class labels
%   Inputs:
%               Lclass  - Predicted class labels
%               Ltrue   - True class labels
%   Output:
%               cM = Confusion Matrix

classes = unique(Ltrue);
numClasses = length(classes);
cM = zeros(numClasses);

for i=1:length(Lclass)
    if Lclass(i)==Ltrue(i)
        index = find(classes==Ltrue(i));
        cM(index,index) = cM(index,index) + 1;
    else
        index_true_class = find(classes==Ltrue(i));
        index_predicted_class = find(classes==Lclass(i));
        cM(index_predicted_class,index_true_class) = cM(index_predicted_class,index_true_class) + 1;
    end
end

end

