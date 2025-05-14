%% this script takes "indiv_timecourses" for the COSPAL_timecourses study...
%% and builds a dataframe for machine learning with plMVPA_Lite
% plMVPA_Lite (and other machine learning code) typically assume all the
% data are in ONE matrix, and there is a separate header row or file which
% labels the conditions.

% our FIR (finite impulse response) model scripts don't store the data this
% way, and so this current conversion script is needed



%% first, load the "indiv_timecourses" file from Liz's code
load("indiv_timecourses.mat")

%% now create a single matrix per task condition (OL_new, NOL_new, OL_old,
% NOL_old)

% this code will "unpack" the cell array into a matrix. With the current
% indiv_timecourses.mat data structure this results in a matrix in the
% correct format for plMVPA_Lite: rows = timecourse features, columns =
% [sub1_roi1, sub1_roi2... sub1_roi6, sub2_roi1, sub2_roi2...
% ...sub20_roi6]

% Add or remove lines depending on the number of experiment conditions in 
% your design (e.g., splitting the task out by early and late learning
% would double the number of conditions)

Tmp=cat(2,indiv_mean_new_ol{:})'; %get ol_new matrix
temp_olnew_mat=cell2mat(Tmp.');

Tmp=cat(2,indiv_mean_new_nol{:})'; %get nol_new matrix
temp_nolnew_mat=cell2mat(Tmp.');

Tmp=cat(2,indiv_mean_old_ol{:})'; %get ol_old matrix
temp_olold_mat=cell2mat(Tmp.');

Tmp=cat(2,indiv_mean_old_nol{:})'; %get nol_old matrix
temp_nolold_mat=cell2mat(Tmp.');


%% now we need to create a "model file" (names + onsets) for spm + 
% plMVPA_lite to use to indext the patterns for training and testing

% first have code count how many ROIs are in the dataset, then generate 
% condition names that correspond to them (e.g., one subject will have 6 
% ol_new "conditions" in the timecourse dataframe we could analyze - one 
% for each ROI)

% Add or remove lines depending on the number of experiment conditions in 
% your design (e.g., splitting the task out by early and late learning
% would double the number of conditions)

for i = 1:length(indiv_mean_new_ol{1}) %we arbitrarily look at the first \\
    % subject {1} and count how many tcs there are (which = # of ROIs)
temp_ol_new_names{i} = ['ol_new_roi' num2str(i)];
temp_nol_new_names{i} = ['nol_new_roi' num2str(i)];
temp_ol_old_names{i} = ['ol_old_roi' num2str(i)];
temp_nol_old_names{i} = ['nol_old_roi' num2str(i)];
end

% now, since our matrix of timecourses is this array of conditions REPEATED
% s times (s=number subjects), let's duplicate the temp names to create a 
% names list that will label ALL the patterns for the number of subjects in 
% our dataframe

s = length(indiv_mean_new_ol); % multiplier that counts number of subjects
ol_new_names_allsubs = repmat(temp_ol_new_names, 1, s);
nol_new_names_allsubs = repmat(temp_nol_new_names, 1, s);
ol_old_names_allsubs = repmat(temp_ol_old_names, 1, s);
nol_old_names_allsubs = repmat(temp_nol_old_names, 1, s);

% ok - now, let's concatenate the patterns into one massive dataframe
testmat = [temp_olnew_mat temp_nolnew_mat temp_olold_mat temp_nolold_mat]; 
% the order of the conditions (ol_new, nol_old, etc) doesn't matter, BUT 
% if you edit the code the order MUST be the same as the order of the
% concatenated names that we create next!!!

names = [ol_new_names_allsubs nol_new_names_allsubs ol_old_names_allsubs nol_old_names_allsubs];

% finally, create an "onsets" vector - for an analysis like this in
%plMVPA_Lite we use the "existpatmat" flag in that code and it assumes
%these are like "beta maps" where there is ONE onset per "event" in the
%dataframe (as opposed to many, in a case with raw BOLD data where we are
%extracting a pattern from a bold timeseries that averages over multiple 
% TRs).
% Thus, we can simply use integers to label each pattern with a sequential
% number as its "onset time" in our dataframe
for i = 1:length(names)
onsets{i} = i; % each onset NAME (from names) will get a corresponding \\
% number for its "onset time" to be used by plMVPA_Lite
end


%% save our work for analysis in plMVPA_Lite
save('FeatSet_01.mat','testmat') % let's call this dataframe feature set \\
% #1, since we will likely do the same thing with the "early vs late" 
% analyses and that will be a new dataframe or "feature set" for MVPA
save('FeatSet_01_namesfile','names','onsets') %save our "model file" for \\
% plMVPA_Lite with the corresponding name to its feature set
