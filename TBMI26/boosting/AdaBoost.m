% Load face and non-face data and plot a few examples
load faces;
load nonfaces;
faces = double(faces);
nonfaces = double(nonfaces);

figure(1);
colormap gray;
for k=1:25
    subplot(5,5,k), imagesc(faces(:,:,10*k));
    axis image;
    axis off;
end

figure(2);
colormap gray;
for k=1:25
    subplot(5,5,k), imagesc(nonfaces(:,:,10*k));
    axis image;
    axis off;
end

% Generate Haar feature masks
nbrHaarFeatures = 200; % Choose the number of haar features
haarFeatureMasks = GenerateHaarFeatureMasks(nbrHaarFeatures);

figure(3);
colormap gray;
for k = 1:25
    subplot(5,5,k),imagesc(haarFeatureMasks(:,:,k),[-1 2]);
    axis image;
    axis off;
end

% Create a training data set with a number of training data examples
% from each class. Non-faces = class label y=-1, faces = class label y=1
nbrTrainExamples = 1500; % Choose the number of training examples
trainImages = cat(3,faces(:,:,1:nbrTrainExamples),nonfaces(:,:,1:nbrTrainExamples));
xTrain = ExtractHaarFeatures(trainImages,haarFeatureMasks);
yTrain = [ones(1,nbrTrainExamples), -ones(1,nbrTrainExamples)];

%% Implement the AdaBoost training here
%  Use your implementation of WeakClassifier and WeakClassifierError
T = 15; % Number of base classifiers
N = nbrHaarFeatures;
M = size(xTrain,2); % Number of training samples times number of classes

% Initialized values
optimal_threshold = ones(T,1);
optimal_feature = ones(T,1);
optimal_polarity = ones(T,1);
alpha = ones(T,1);
d = ones(1,size(xTrain,2))*1/size(xTrain,2); % Initial weights
p = 1; % Polarity, 1 or -1
training_strongClassifier = zeros(1,size(xTrain,2));
training_error_list = zeros(T,1);
training_accuracy_list = zeros(T,1);

for t=1:T
    Emin = inf; % Minimum classification error
    for k=1:N % Features
        for i=1:M % Training samples
            tau = xTrain(k,i); % Single decision stump
            C = WeakClassifier(tau,p,xTrain(k,:)); % C is classifications for all examples in X.
            E = WeakClassifierError(C,d,yTrain); % Returns the classification error
            
            if(E > 0.5)
                p = -p;
                E = 1 - E;
            end
            
            if E < Emin
                Emin = E;
                optimal_threshold(t) = tau;
                optimal_feature(t) = k;
                optimal_polarity(t) = p;
                C_optimal = WeakClassifier(tau,p,xTrain(k,:));
            end
        end
    end
    
    alpha(t) = 1/2*log((1-Emin+eps)/(Emin+eps));
    d = d.*exp(-alpha(t)*yTrain.*C_optimal);
    d = d/sum(d);
    d = d/sum(d);
    training_strongClassifier = training_strongClassifier + C_optimal*alpha(t);
    training_error = sign(training_strongClassifier) ~= yTrain;
    training_error_list(t) = sum(training_error)/length(training_error);
    training_accuracy_list(t) = 1-training_error_list(t);
end

%% Extract test data

nbrTestExamples = 3416; % Choose the number of test examples

testImages  = cat(3,faces(:,:,(nbrTrainExamples+1):(nbrTrainExamples+nbrTestExamples)),...
                    nonfaces(:,:,(nbrTrainExamples+1):(nbrTrainExamples+nbrTestExamples)));
xTest = ExtractHaarFeatures(testImages,haarFeatureMasks);
yTest = [ones(1,nbrTestExamples), -ones(1,nbrTestExamples)];

%% Evaluate your strong classifier here
%  You can evaluate on the training data if you want, but you CANNOT use
%  this as a performance metric since it is biased. You MUST use the test
%  data to truly evaluate the strong classifier.

test_error_list = zeros(T,1);
test_accuracy_list = zeros(T,1);
test_strongClassifier = zeros(1,size(xTest,2));

for t=1:T
    C = WeakClassifier(optimal_threshold(t),optimal_polarity(t),xTest(optimal_feature(t),:));
    test_strongClassifier = test_strongClassifier + C*alpha(t);

    test_error = sign(test_strongClassifier) ~= yTest;

    test_error_list(t) = sum(test_error)/length(test_error);
    test_accuracy_list(t) = 1-test_error_list(t);
end



%% Plot the error of the strong classifier as  function of the number of weak classifiers.
%  Note: you can find this error without re-training with a different
%  number of weak classifiers.

figure(4);
hold on
plot(1:T, test_error_list);
plot(1:T, training_error_list');

legend('Test error', 'Training error');
xlabel('Base classifier');
ylabel('Error');

hold off

%% Plot the error of the strong classifier as  function of the number of weak classifiers.
figure(5);
hold on
plot(1:T, test_accuracy_list);
plot(1:T, training_accuracy_list');

legend('Test accuracy', 'Training accuracy');
xlabel('Base classifier');
ylabel('Accuracy');

hold off


%% For the report

%find indices of bad classifications
wrongClassifications = find(test_error); 

figure(6); %plot bad classified images
colormap gray;
for k=1:25
    subplot(5,5,k), imagesc(faces(:,:,wrongClassifications(k)));
    axis image;
    axis off;
end

figure(7);
colormap gray;
for k=1:25
    subplot(5,5,k), imagesc(nonfaces(:,:,wrongClassifications(k)));
    axis image;
    axis off;
end


