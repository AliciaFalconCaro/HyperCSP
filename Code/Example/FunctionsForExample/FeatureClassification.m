function [SVMModel,LDAModel,KNNModel, X_test, y_test] = FeatureClassification (Parameters,LabelledData)

%This function will be used to calculate the SVM, LDA and KNN models given
%the feature matrix. The data will be divided into training, validation and
%testing data as explained in [1].

%References:
%[1]A. Falcon-Caro, S. Shirani, J. F. Ferreira, J. J. Bird and S. Sanei, "Formulation of Common Spatial Patterns for Multi-task Hyperscanning BCI," in IEEE Transactions on Biomedical Engineering, doi: 10.1109/TBME.2024.3356665. 
%% SOURCE CODE
% Shuffle the labelled data randomly
shuffledData = LabelledData(randperm(size(LabelledData, 1)), :);

numSamples = size(shuffledData, 1);
numTestSamples=floor(Parameters.TestingRatio * numSamples);
numTrainSamples = floor(Parameters.trainRatio * numSamples);
numValSamples = numSamples-numTestSamples-numTrainSamples;

X_test = shuffledData(1:numTestSamples, 1:end-1);  % Features for training
y_test = shuffledData(1:numTestSamples, end);  % Labels for training

%training and validation
X_TrainVal=shuffledData(numTestSamples+1:end, 1:end-1);
Y_trainVal=shuffledData(numTestSamples+1:end, end);

ClassPerformanceLDA = classperf(Y_trainVal);
ClassPerformanceSVM = classperf(Y_trainVal);
ClassPerformanceKNN = classperf(Y_trainVal);

%Cross-validate the model X times
for j=1:Parameters.TimesModelTrained
    [train,validationTest]=crossvalind('LeaveMOut',Y_trainVal,numValSamples);
    
    KNNModel = fitcknn(X_TrainVal(train,:),Y_trainVal(train),'NumNeighbors',Parameters.NumNeighborsKNN,'Standardize',1);
    SVMModel = fitcsvm(X_TrainVal(train,:),Y_trainVal(train));
    LDAModel = fitcdiscr(X_TrainVal(train,:),Y_trainVal(train));

    y_predKNNVal = predict(KNNModel, X_TrainVal(validationTest,:));
    y_predSVMVal = predict(SVMModel, X_TrainVal(validationTest,:));
    y_predLDAVal = predict(LDAModel, X_TrainVal(validationTest,:));
    
    classperf(ClassPerformanceKNN,y_predKNNVal,validationTest);
    classperf(ClassPerformanceSVM,y_predSVMVal,validationTest);
    classperf(ClassPerformanceLDA,y_predLDAVal,validationTest);

    % Evaluate the classification performance
    accuracyValidationSVM(j) = sum(y_predSVMVal == Y_trainVal(validationTest)) / numel(Y_trainVal(validationTest));
    accuracyValidationLDA(j) = sum(y_predLDAVal == Y_trainVal(validationTest)) / numel(Y_trainVal(validationTest));
    accuracyValidationKNN(j) = sum(y_predKNNVal == Y_trainVal(validationTest)) / numel(Y_trainVal(validationTest));

end

disp(['Performance SVM: ']);ClassPerformanceSVM
disp(['Performance LDA: ' ]);ClassPerformanceLDA
disp(['Performance KNN: ' ]);ClassPerformanceKNN

SVMAccuracy = mean(accuracyValidationSVM);
LDAAccuracy = mean(accuracyValidationLDA);
KNNAccuracy = mean(accuracyValidationKNN);
disp(['Mean Accuracy SVM: ' num2str(SVMAccuracy)]);
disp(['Mean Accuracy LDA: ' num2str(LDAAccuracy)]);
disp(['Mean Accuracy KNN: ' num2str(KNNAccuracy)]);

SVMAccuracyMAX = max(accuracyValidationSVM);
LDAAccuracyMAX = max(accuracyValidationLDA);
KNNAccuracyMAX = max(accuracyValidationKNN);
disp(['Max Accuracy SVM: ' num2str(SVMAccuracyMAX)]);
disp(['Max Accuracy LDA: ' num2str(LDAAccuracyMAX)]);
disp(['Max Accuracy KNN: ' num2str(KNNAccuracyMAX)]);

end
