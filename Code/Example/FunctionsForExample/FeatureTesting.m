function [accuracySVMTest, accuracyLDATest, accuracyKNNTest] = FeatureTesting (svmModel, LDAModel, KNNModel, X_test, y_test)

%This function will be used to evaluate the performance of the obtained SVM, LDA and KNN models as explained in [1].

%References:
%[1]A. Falcon-Caro, S. Shirani, J. F. Ferreira, J. J. Bird and S. Sanei, "Formulation of Common Spatial Patterns for Multi-task Hyperscanning BCI," in IEEE Transactions on Biomedical Engineering, doi: 10.1109/TBME.2024.3356665. 

y_predSVMTest = predict(svmModel, X_test);
y_predLDATest = predict(LDAModel, X_test);
y_predKNNTest = predict(KNNModel, X_test);

% Evaluate the classification performance
accuracySVMTest = sum(y_predSVMTest == y_test) / numel(y_test);
accuracyLDATest = sum(y_predLDATest == y_test) / numel(y_test);
accuracyKNNTest = sum(y_predKNNTest == y_test) / numel(y_test);

% Display the results
disp(['Classification Accuracy SVM Testing: ' num2str(accuracySVMTest)]);

disp(['Classification Accuracy LDA Testing: ' num2str(accuracyLDATest)]);

disp(['Classification Accuracy KNN Testing: ' num2str(accuracyKNNTest)]);

end
