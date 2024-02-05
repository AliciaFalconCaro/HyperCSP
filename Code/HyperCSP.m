function [normalizedFeatures_1, normalizedFeatures_2, Labelled] = HyperCSP (fullSegment, SegmentLabel, windowLengthParameter)

% This function performs CSP given a set of EEG segments as explained in
% [1].
%This code has been tested in MATLAB2022b.

%This resource is released under CC BY-NC 4.0.
%Please cite this code as in [1].


%References:
%[1]Falcon-Caro, A., Shirani, S., Ferreira, J. F., Bird, J. J., & Sanei, S. (2024). Formulation of Common Spatial Patterns for Multi-task Hyperscanning BCI. IEEE Transactions on Biomedical Engineering. doi: 10.1109/TBME.2024.3356665. 

%% INPUTS:
%   - FullSegment: NxMxS matrix. N represents the channels of the
%   hyperscanning data. M represents the number of samples per segment. S
%   represents the number of segments.
%   - SegmentLabel: 1xS matrix containing the label of each segment. S
%   represents the number of segments.
%   - windowLengthParameter: Value to be used to decide the Window length

%% OUTPUTS:
%   - normalizedFeatures_1: NxS matrix of features obtained from filtering the EEG signal from the first subject. N is the number of channels from both
%   subjects and S is the number of New HyperCSP window segment.
%   - normalizedFeatures_2: NxS matrix of features obtained from filtering the EEG signal from the second subject. N is the number of channels from both
%   subjects and S is the number of New HyperCSP window segment.
%   - Labelled: 1xS matrix containing the new labels for each window
%   segment.


%% SOURCE CODE
Channels=size(fullSegment,1);
LengthSegment=size(fullSegment,2);
NumberSubSegments=1;
NumberSegments = size(SegmentLabel,2);
targetLength=floor(LengthSegment/windowLengthParameter);

for i=1:NumberSegments
    start_point=1;
    while( start_point + targetLength - 1 <= LengthSegment)

       seg1= fullSegment(1:(Channels/2),start_point:start_point+targetLength-1,i);
       seg2= fullSegment((Channels/2+1):end,start_point:start_point+targetLength-1,i);

        C_1 =  (seg1*seg1.'/trace(seg1*seg1.')) + (seg2*seg2.'/trace(seg2*seg2.'));   % C_1~[C x C] = C_x1 + C_x2
        C_2 = (seg1*seg2.'/trace(seg1*seg2.')); %C_x1,x2

       % calculate the right eigenvectors that maximize w
       [W,L] = eig(C_1, C_1+C_2);

       %sort w in decreasing order based on the eigenvalues
       [eigvals,sidx] = sort(diag(L),'descend');
       W_sorted = W(:,sidx);
       
       % filter the signal segments
       X1_CSP = W_sorted'*seg1; 
       X2_CSP = W_sorted'*seg2;

       % compute feature extraction
       % Compute the logarithm of the variances for each CSP-filtered signal
       logVar_1 = log(var(X1_CSP, 0, 2));
       logVar_2 = log(var(X2_CSP, 0, 2));

       % Normalize the logarithmic variances to have zero mean and unit variance
       normalizedFeatures_1(:,NumberSubSegments) = zscore(logVar_1);
       normalizedFeatures_2 (:,NumberSubSegments) = zscore(logVar_2);

       %labelled data
       Labelled(:,NumberSubSegments)=SegmentLabel(:,i);
       
       % 'normalizedFeatures' now contains the CSP-filtered features
       start_point = start_point + targetLength;
       NumberSubSegments = NumberSubSegments + 1;

    end
end
end
