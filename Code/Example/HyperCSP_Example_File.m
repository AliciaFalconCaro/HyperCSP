%This example performs hyperCSP on the given dataset and then calculates
%KNN, LDA and SVM as explained in [1].

%This resource is released under CC BY-NC 4.0.
%Please cite this code as in [1].


%% PRE-REQUISITES FOR THIS CODE:
%Parts of this example make use of some EEGLAB [2] functions so please, add
%EEGLAB to the MATLAB path before running this example. 
%The file 'Standard-10-20-Cap32_hyperscanning_channelLocations.locs'
%constains the EEG Channel location for the 64 channels (32 from each
%subject). This file also needs to be added to the MATLAB path together
%with the dataset folder.

%References:
%[1]A. Falcon-Caro, S. Shirani, J. F. Ferreira, J. J. Bird and S. Sanei, "Formulation of Common Spatial Patterns for Multi-task Hyperscanning BCI," in IEEE Transactions on Biomedical Engineering, doi: 10.1109/TBME.2024.3356665. 
%[2] A. Delorme and S. Makeig, "EEGLAB: an open source toolbox for analysis of single-trial EEG dynamics including independent component analysis", Journal of Neuroscience Methods, vol. 134, no. 1, pp. 9–21, 2004.



%% SOURCE CODE
clear all; clc; close all;
filepath=fullfile("Dataset"); 
EEGdata = fileDatastore(filepath,"ReadFcn",@load,IncludeSubFolders=true);
%p=endsWith(Ds.Files,"data.mat");
%EEGdata = subset(Ds,p);

%constants and parameters
Parameters.fs=250; %sampling frequency in Hz
Parameters.windowLengthParameter=1.5;
Parameters.LowFilter=50;
Parameters.HighFilter=1;
Parameters.NumNeighborsKNN=3;
Parameters.ChannelLocationFilePath='Standard-10-20-Cap32_hyperscanning_channelLocations.locs';

% Set the ratio for train-test split
Parameters.trainRatio=0.75;  
Parameters.TestingRatio=0.1;
Parameters.TimesModelTrained=10;

%Preprocessing and hyperCSP calculation
k=1;
reset(EEGdata);
while hasdata(EEGdata)
    clearvars -except Ds EEGdata Parameters k FullData
    data=read(EEGdata);

    FullData(k).hyperscanningData=data.y(1:64,:);
    FullData(k).Labels=data.y(66,:);

% Data labelling and preprocessing
    if (contains(EEGdata.Files{k,1},"Experiment3") || contains(EEGdata.Files{k,1},"Experiment4") || contains(EEGdata.Files{k,1},"Experiment5")) %To label Experiments 3,4 and 5

        [FullData(k).fullSegment,FullData(k).SegmentLabel]=LabellingDataExperiment345 (FullData(k).hyperscanningData, FullData(k).Labels);
            
    else
        
        [FullData(k).fullSegment,FullData(k).SegmentLabel]=LabellingData (FullData(k).hyperscanningData, FullData(k).Labels);
    end
   
    hyperscanningData = FullData(k).fullSegment;
    [FullData(k).ProcessedDataSegments] = DataPreprocessing (Parameters.fs,hyperscanningData, Parameters.LowFilter, Parameters.HighFilter,Parameters.ChannelLocationFilePath);

k=k+1;
end

%% Compute hyperCSP and classify the obtain features
NumberSubjects =size(FullData,2);
%Perform hyperCSP on segments to obtain the feature matrices.
for i=1:NumberSubjects
    [FullData(i).NormalizedFeatures_Subject1, FullData(i).NormalizedFeatures_Subject2, FullData(i).LabelledHyperCSPSegments] = HyperCSP (FullData(i).ProcessedDataSegments, FullData(i).SegmentLabel,Parameters.windowLengthParameter);
end
%Re-arrange the features and labels into a single matrix to perform
%classification.
FeaturesAndLabels=[];
for i=1:NumberSubjects
    Features = [FullData(i).NormalizedFeatures_Subject1, FullData(i).NormalizedFeatures_Subject2];
    Labels= [FullData(i).LabelledHyperCSPSegments,FullData(i).LabelledHyperCSPSegments]; %the segments from the first and second subject has the same labels
    FeaturesClass=[Features;Labels]';
    FeaturesAndLabels=cat(1,FeaturesAndLabels,FeaturesClass);
end
%%
disp('HyperCSP Classification:');
[SVMModel,LDAModel,KNNModel, X_test, y_test] = FeatureClassification (Parameters,FeaturesAndLabels);
%% Classify the testing data
disp('HyperCSP Testing:');
[accuracySVMTest, accuracyLDATest, accuracyKNNTest] = FeatureTesting (SVMModel, LDAModel, KNNModel, X_test, y_test);

