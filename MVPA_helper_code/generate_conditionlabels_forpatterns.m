function [ ] = generate_conditionlabels_forpatterns(S)
%This script is a shortened script adapted from "TIB_generate_beta_filenames"
% in the plMVPA toolbox
% It generates indices and lists of "betas" or other patterns if you aren't 
% using "raw" bold data (i.e., if you are doing existpatmat or betas in the
% plMVPA pipeline) to be used for MVPA analysis using PM_run_mvpa_general
%
% % "names" MUST be edited to match those of the target condition names 
%  identified in your "_params" file. Order must also be the same.
%
%FOR BINARY CLASSIFICATION: assign condition index for 1st + 2nd classes to
%"betaidx{1,1}" + "betaidx{1,2}" - as opposed to whatever cell they might normally be
%associated with (i.e., if you are classifying between classes 2 and 5, we
%don't want to store the indices in cells 2 and 5 for binary.



% load in onsets and regs
onsetsmat = [S.mvpa_dir S.onsets_filename];
load(onsetsmat);

%% if we are doing x-validation classification (the most common case)
if strcmp(S.trainTask,S.testTask) 
    %set up a beta index file (equivalent to the onsets element of a normal
    %model file). ***IMPORTANT***If you look at the index numbers this 
    % generates, they should make sense in light of the original model 
    % files for your study - e.g. if there were 29 goal_1 onsets, we
    %should have 29 1s in the goal_1 idx cell
       
    %% binary classification example
    betaidx{1,1} = strcmpi('ol_new_roi4',names);
    betaidx{1,2} = strcmpi('ol_new_roi6',names);
    bnames{1,1} = 'ol_new_roi4';
    bnames{1,2} = 'ol_new_roi6';

    %% 3-way classification example
    % betaidx{1,1} = strcmpi('EA',names);
    % betaidx{1,2} = strcmpi('AA',names);
    % betaidx{1,3} = strcmpi('Scene',names);
    %  bnames{1,1} = 'EA';
    %  bnames{1,2} = 'AA';
    %  bnames{1,3} = 'Scene';

%      betaidx{1,1} = strcmpi('nol_new_roi4',names);
%      betaidx{1,2} = strcmpi('nol_new_roi5',names);
%      betaidx{1,3} = strcmpi('nol_new_roi6',names);
%      bnames{1,1} = 'nol_new_roi4';
%      bnames{1,2} = 'nol_new_roi5';
%      bnames{1,3} = 'nol_new_roi6';
    
    %% 5-way... etc are possible (but requre more data to fit!)
    
  
    if S.existpatmat == 0
        allbetafilenames = dir(fullfile(S.mvpa_dir, 'beta*.nii'));
        
        % add catch for failure to find beta filenames
        if length(allbetafilenames) == 0
            error('SANITY CHECK: the directory you listed does not have betas OR they have a different extension (e.g. img)')
        end
        
        for idx = 1:length(betaidx{1,1})%-1%note, we are filling in the beta file names based on how many betas OF INTEREST we have (length(betaidx)). We don't care about the error reg betas for this analysis
            beta_filenames{idx,1} = [S.mvpa_dir allbetafilenames(idx).name]; %create the analog to "raw_filenames.mat" - i.e. a list of all filenames including the path
        end
        
    else
        for idx = 1:length(betaidx{1,1})%-1%note, we are filling in the beta file names based on how many betas OF INTEREST we have (length(betaidx)). We don't care about the error reg betas for this analysis
            beta_filenames{idx,1} = [S.mvpa_dir S.datafile]; %create the analog to "raw_filenames.mat" - i.e. a list of all filenames including the path
        end
    end
    
    
    cd(S.mvpa_dir);
    
    savename_betaidx=[S.subj_id '_betas_idx.mat'];
    save(savename_betaidx, 'bnames', 'betaidx');
    
    savename_betafnms=['beta_filenames.mat'];
    save(savename_betafnms, 'beta_filenames');
    
%% if we are training the model on one set of conditions but testing it on a different set (very useful, but less common)
else
    
    %% binary
    %%tr > training 
    %%te > testing
    betaidx_tr{1,1} = strcmpi('ol_new_roi1',names);
    betaidx_tr{1,2} = strcmpi('nol_new_roi1',names);
    
    betaidx_te{1,1} = strcmpi('ol_new_roi2',names);
    betaidx_te{1,2} = strcmpi('nol_new_roi2',names);
    
    bnames_tr{1,1} = 'ol_new_roi1';
    bnames_tr{1,2} = 'nol_new_roi1';
    
    bnames_te{1,1} = 'ol_new_roi2';
    bnames_te{1,2} = 'nol_new_roi2';
        
    if S.existpatmat == 0
        allbetafilenames = dir(fullfile(S.mvpa_dir, 'beta*.nii'));
        
        % add catch for failure to find beta filenames
        if length(allbetafilenames) == 0
            error('SANITY CHECK: the directory you listed does not have betas OR they have a different extension (e.g. img)')
        end
        
        for idx = 1:length(betaidx_tr{1,1})%-1%note, we are filling in the beta file names based on how many betas OF INTEREST we have (length(betaidx)). We don't care about the error reg betas for this analysis
            beta_filenames{idx,1} = [S.mvpa_dir allbetafilenames(idx).name]; %create the analog to "raw_filenames.mat" - i.e. a list of all filenames including the path
        end
        
    else
        for idx = 1:length(betaidx_tr{1,1})%-1%note, we are filling in the beta file names based on how many betas OF INTEREST we have (length(betaidx)). We don't care about the error reg betas for this analysis
            beta_filenames{idx,1} = [S.mvpa_dir S.datafile]; %create the analog to "raw_filenames.mat" - i.e. a list of all filenames including the path
        end
    end
    
    
    cd(S.mvpa_dir);
    
    savename_betaidx_tr=[S.subj_id '_betas_idx_tr.mat'];
    savename_betaidx_te=[S.subj_id '_betas_idx_te.mat'];
    save(savename_betaidx_tr, 'bnames_tr', 'betaidx_tr');
    save(savename_betaidx_te, 'bnames_te', 'betaidx_te');
    
    savename_betafnms=['beta_filenames.mat'];
    save(savename_betafnms, 'beta_filenames');
    
end


end

