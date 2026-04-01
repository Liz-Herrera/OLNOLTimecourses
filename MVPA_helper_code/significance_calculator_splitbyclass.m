
%% --- Batch Analysis Script for All Featset Files ---

% --- Input & Output folders ---
inFolder = 'C:\Users\ellave3\OneDrive - Georgia Institute of Technology\Documents\GitHub\OLNOLTimecourses\mvpa_output_files';
outFolder = 'C:\Users\ellave3\OneDrive - Georgia Institute of Technology\Documents\GitHub\OLNOLTimecourses\significance_calculator_ttest_output_files';

if ~exist(outFolder, 'dir')
    mkdir(outFolder);
end

% --- Find all files ending in "_Featset01.mat" or "_Featset02.mat" (no matter what s before) in the input folder ---
files = dir(fullfile(inFolder, '*_Featset01.mat')); % change to 1 or 2 depending on the results you want to analyze (1= all trials, 2=early/late)

fprintf('Found %d files to process.\n', numel(files));

% --- Loop through each file ---
for f = 1:numel(files)
    % Load file
    inFile = fullfile(inFolder, files(f).name);
    fprintf('\nProcessing file: %s\n', files(f).name);

     % Safely load file
    S = load(inFile);
    if ~isfield(S, 'res')
        warning('Skipping %s — missing variable "res".', files(f).name);
        continue;
    end
    res = S.res;

%%commenting this out but not sure i'll work. Added a new chunk in line 23
    % load(inFile, 'res'); % assumes the structure is named 'res'
    

    %% === ANALYSIS SECTION ===

%accuracy calculator by subject

featureset = 2; % change to 1 or 2 depending on the results you want to analyze (1= all trials, 2=early/late)

%first, read in performance for every test
acc= [];

for i = 1:length(res.subj{1,featureset}.penalty.nVox.weights.iter{1,1}.iterations) %Path: look at 'iterations'
acc = [acc res.subj{1,featureset}.penalty.nVox.weights.iter{1,1}.iterations(i).perf]; %Grab the 'perf'value

end

%then, read in test indices so we can group results by the person/pattern
test_indices= [];

for i = 1:length(res.subj{1,featureset}.penalty.nVox.weights.iter{1,1}.iterations)
test_indices = [test_indices res.subj{1,featureset}.penalty.nVox.weights.iter{1,1}.iterations(i).test_idx]; %Grab the 'test idx' values


end


%now, read in the condition (OL,NOL) for each test index
conditionlbl= [];

for i = 1:length(res.subj{1,featureset}.penalty.nVox.weights.iter{1,1}.iterations)
conditionlbl = [conditionlbl res.subj{1,featureset}.penalty.nVox.weights.iter{1,1}.iterations(i).perfmet.desireds]; %grab the desireds (OL/NOL) values per individual (within the perfmet column)

end

%now, calculate performance for each test index
unique_ids = unique(test_indices); %unique function > data cleaning (returns a sorted vector or array with all duplicate values removed)
%'test_indices' = test_idx?

patternacc = [];

for h = 1:length(unique_ids)

%find this unique ID in our results
idx = test_indices==unique_ids(h);
patternacc=[patternacc mean(acc(logical(idx)))]; %logical has two main functions: it converts numeric values to logicals for true '1' or false '0', and evaluates the truthfulness of symbolic conditions, returning an array of logical (\(1\) or \(0\)) values.
%I am a bit unclear about this

end

% One-sample t-test
% The null hypothesis is that the mean of 'patternacc' is equal to 'chanceLevel'.
%Note chance is 0.33 instead of 0.5 for 3-way permutations
N = length(patternacc); %define the N
[h, p, ci, tInfo] = ttest(patternacc, 0.50, 'Alpha', 0.05); 

%Tr1TEO  balancing: train in one data set and test in the other one


%Store the t stats and descriptives in the 'stats' structure
stats.tstat = tInfo.tstat;
%stats.acc = patternacc; % sanity check: store raw accuracy values 
stats.df = tInfo.df;
stats.pvalue = p;
stats.hnull = h; %hypothesis test result:1=reject null, 0=fail to reject
stats.std = std(patternacc);
stats.mean  = mean(patternacc);
stats.N = length(patternacc);  % number of patterns
stats.confidence = ci; 
stats.sem = stats.std / sqrt(stats.N); % Standard Error of the Mean (SEM)

 % --- Extract total_perf from input file (MVPA_output_files_folder)---
    % try
    %     stats.total_perf = res.subj{1,1}.penalty.nVox.weights.iter{1,1}.total_perf;
    % catch
    %     warning('Could not find total_perf in %s', files(f).name);
    %     continue;
    % end

    % --- Save output file ---
    outFile = fullfile(outFolder, files(f).name);
    save(outFile, 'stats');
    % fprintf('✅ Saved total_perf = %.4f to: %s\n', stats.total_perf, outFile);


% Mean Squared Error (MSE) against chance level (0.5)
chanceLevel = 0.5;
stats.mse = mean((patternacc - chanceLevel).^2);

% Effect Size Cohen's d (one-sample)
cohens_d = stats.tstat / sqrt(N);

% Hedges' g (bias-corrected) for N < 50
df = N - 1;
J = 1 - (3 / (4*df - 1));   % correction factor
hedges_g = cohens_d * J;

% store in the stats struct
stats.cohenD = cohens_d;
stats.hedgesG = hedges_g;

%% --- Save output file ---
    outFile = fullfile(outFolder, files(f).name); % keep same filename
    save(outFile, 'stats');
    fprintf('✅ Saved results to: %s\n', outFile);
end

fprintf('\nAll %d files processed successfully.\n', numel(files));

%% The code doesn't store the total_perf (=acc) in the stats structure for FetSet02 atm

% % Save Output MANUALLY
% % --- Base name for output file ---
% mvpaFileName ='8080test_2way_nf_train_NOLNewROI1vsNOLNewROI2_test_NOLNewROI1vsNOLNewROI2_Featset01.mat';
% % --- Output folder ---
% outFolder = fullfile('C:\Users\ellave3\OneDrive - Georgia Institute of Technology\Documents\GitHub\OLNOLTimecourses', ...
%                      'significance_calculator_ttest_output_files');
% 
% if ~exist(outFolder, 'dir')
%     mkdir(outFolder);
% end
% 
% % --- Construct full path ---
% outFile = fullfile(outFolder, [mvpaFileName '.mat']);
% 
% % --- Save the t-test & stats structure ---
% res = stats; % assign structure to 'res' as you wanted
% disp(['Saving file to: ' outFile]);
% save(outFile, 'res');
% 
% disp('✅ Analysis complete and file saved successfully.');

%% I'LL NEED TO RUN THE CODE AGAIN TO GET THE SEM AND SME OF FEATSET02

%% all featset02done

