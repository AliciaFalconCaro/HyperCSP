function [AllData] = DataPreprocessing (fs, hyperscanningData, LowFreqFilter, HighFreqFilter,ChannelLocationFile)

%This fucntion make use of some EEGLAB2021 [1] functions.

%References:
%[1] A. Delorme and S. Makeig, "EEGLAB: an open source toolbox for analysis of single-trial EEG dynamics including independent component analysis", Journal of Neuroscience Methods, vol. 134, no. 1, pp. 9–21, 2004.


[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_importdata('dataformat','array','nbchan',0,'data','hyperscanningData','setname','data1','srate',fs,'pnts',0,'xmin',0,'chanlocs',ChannelLocationFile);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_eegfiltnew(EEG, 'locutoff',LowFreqFilter,'hicutoff',HighFreqFilter,'plotfreqz',8); %Apply a FIR bandpass filter of 1-50Hz to each epoch
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG, 'nochannel',{'P8_0','Oz_0','P8_1','Oz_1'}); %remove bad channels (Channels 27 and 32 from both subjects)
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, [],'interpchan',[]); %Average Re-referencing
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'gui','off'); 

close all;

AllData=EEG.data;

end
