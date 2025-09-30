%% this script takes "indiv_timecourses" for the COSPAL_timecourses study...
%% and builds a dataframe for machine learning with plMVPA_Lite script
% plMVPA_Lite (and other machine learning code) typically assume all the
% data are in ONE matrix, and there is a separate header row or file which
% labels the conditions.

% our FIR (finite impulse response) model scripts don't store the data this
% way, and so this current conversion script is needed



%% first, load the "indiv_timecourses" file from Liz's code (Linux Workstation)
load("indiv_timecourses_early-late.mat")

%% now create a single matrix per task condition: NEW OL and NOL: early-late
% (OL_new_early, NOL_new_early, OL_new_late, NOL_new_late)

% this code will "unpack" the cell array into a matrix. With the current
% indiv_timecourses_early-late.mat data structure this results in a matrix in the
% correct format for plMVPA_Lite: rows = timecourse features, columns =
% [sub1_roi1, sub1_roi2... sub1_roi6, sub2_roi1, sub2_roi2...
% ...sub20_roi6]

% Add or remove lines depending on the number of experiment conditions in 
% your design (e.g., splitting the task out by early and late learning
% would double the number of conditions)

%in this section, the variables (e.g., indiv_mean_new_ol_early) are referring to
%the variables loaded in from the "indiv_timecourses_early-late.mat" file

Tmp=cat(2,indiv_mean_new_ol_early{:})'; %get new_ol_early matrix
temp_ol_new_early_mat=cell2mat(Tmp.');

Tmp=cat(2,indiv_mean_new_ol_late{:})'; %get new_ol_late matrix
temp_ol_new_late_mat=cell2mat(Tmp.');

Tmp=cat(2,indiv_mean_new_nol_early{:})'; %get new_nol_early matrix
temp_nol_new_early_mat=cell2mat(Tmp.');

Tmp=cat(2,indiv_mean_new_nol_late{:})'; %get new_nol_late matrix
temp_nol_new_late_mat=cell2mat(Tmp.');
% OLD
% Tmp=cat(2,indiv_mean_new_ol{:})'; %get new_ol_new matrix
% temp_olnew_mat=cell2mat(Tmp.');
% 
% Tmp=cat(2,indiv_mean_new_nol{:})'; %get nol_new matrix
% temp_nolnew_mat=cell2mat(Tmp.');
% 
% Tmp=cat(2,indiv_mean_old_ol{:})'; %get ol_old matrix
% temp_olold_mat=cell2mat(Tmp.');
% 
% Tmp=cat(2,indiv_mean_old_nol{:})'; %get nol_old matrix
% temp_nolold_mat=cell2mat(Tmp.');


%% now we need to create a "model file" (names + onsets) for spm + 
% plMVPA_lite to use to indext the patterns for training and testing

% first have code count how many ROIs are in the dataset, then generate 
% condition names that correspond to them (e.g., one subject will have 12 "conditions" 
% in the timecourse dataframe we could analyze:
% Six ol_new_early "conditions" and 6 ol_new_late "conditions"-(two for each ROI)

% roi1 = [bilat_RSComplex];
% roi2 = [bilat_ba2930];
% roi3 = [bilat_hippo];
% roi4 = [bilat_NAcc];
% roi5 = [bilat_caudate];
% roi6 = [bilat_putamen];

% Add or remove lines depending on the number of experiment conditions in 
% your design (e.g., splitting the task out by early and late learning
% would double the number of conditions, i.e., 12 conditions per ROI instead of 6)

for i = 1:length(indiv_mean_new_ol_early{1}) %we arbitrarily look at the first \\
    % subject {1} and count how many tcs there are (which = # of ROIs)
    % <-this variable name is again from indiv_timecourses_early-late.mat 

temp_ol_new_early_names{i} = ['ol_new_early_roi' num2str(i)];
temp_ol_new_late_names{i} = ['ol_new_late_roi' num2str(i)];
temp_nol_new_early_names{i} = ['nol_new_early_roi' num2str(i)];
temp_nol_new_late_names{i} = ['nol_new_late_roi' num2str(i)];

% temp_ol_new_names{i} = ['ol_new_early_roi' num2str(i)];
% temp_nol_new_names{i} = ['nol_new_roi' num2str(i)];e
% temp_ol_old_names{i} = ['ol_old_roi' num2str(i)];
% temp_nol_old_names{i} = ['nol_old_roi' num2str(i)];
end

% now, since our matrix of timecourses is this array of conditions REPEATED
% s times (s=number subjects), let's duplicate the temp names to create a 
% names list that will label ALL the patterns for the number of subjects in 
% our dataframe

s = length(indiv_mean_new_ol_early); % multiplier that counts number of subjects temp_ol_new_early_names
ol_new_early_names_allsubs = repmat(temp_ol_new_early_names, 1, s);
ol_new_late_names_allsubs = repmat(temp_ol_new_late_names, 1, s);
nol_new_early_names_allsubs = repmat(temp_nol_new_early_names, 1, s);
nol_new_late_names_allsubs = repmat(temp_nol_new_late_names, 1, s);

% ol_new_names_allsubs = repmat(temp_ol_new_names, 1, s);
% nol_new_names_allsubs = repmat(temp_nol_new_names, 1, s);
% ol_old_names_allsubs = repmat(temp_ol_old_names, 1, s);
% nol_old_names_allsubs = repmat(temp_nol_old_names, 1, s);


% ok - now, let's concatenate the patterns into one massive dataframe
% patterns from the matrix section above
testmat = [temp_ol_new_early_mat temp_ol_new_late_mat temp_nol_new_early_mat temp_nol_new_late_mat];
%testmat = [temp_olnew_mat temp_nolnew_mat temp_olold_mat temp_nolold_mat];

% the order of the conditions (ol_new, nol_old, etc) doesn't matter, BUT 
% if you edit the code the order MUST be the same as the order of the
% concatenated names that we create next!!!

names = [ol_new_early_names_allsubs ol_new_late_names_allsubs nol_new_early_names_allsubs nol_new_late_names_allsubs];
% names = [ol_new_names_allsubs nol_new_names_allsubs ol_old_names_allsubs nol_old_names_allsubs];

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
save('FeatSet_02.mat','testmat') % let's call this dataframe feature set \\
% #2 for the "early vs late" 
% analyses and that will be a new dataframe or "feature set" for MVPA
save('FeatSet_02_namesfile','names','onsets') %save our "model file" for \\
% plMVPA_Lite with the corresponding name to its feature set
