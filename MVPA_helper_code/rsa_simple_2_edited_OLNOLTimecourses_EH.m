function [] = rsa_simple_2_edited_OLNOLTimecourses_EH(Sub, Mask, TRsperRun)
% code for RSA analysis - 
% expanding on "rsa_simple", this version reads in data from WITHIN a subject (their time-series). It does this using a "model file" [event table] and a function that lists all of the "raw filenames" within the subject's BOLD data directories.

% example call with 'mvpa_sample_data' - rsa_simple_2({'001'}, 'HVisCtx_1',
% [114 114])% HVisCtx_1 is the name of the ROI, ({'001'} is the subject number, [114 114]) is the TRs we
% have per run, in our case it is equal to the number of 3d files
%better to save the call per each run and subject as the TRs vary from each
%other
% RSC study, Liz H call (do this for every subject): rsa_simple_2({'01'}, 'bilat_ba2930', [114 114])

%% SUBJECT'S CALLS:
%Call every ROI for every subject and hallway (see theseTRWeights)
%s01 - RSComplex:RSC study, Liz H call (do this for every subject and hallway): rsa_simple_2({'01'}, 'rsabilat_RSComplex', [310 307 295 301 293 293 291 295 292 288])
%s01 - RSC: rsa_simple_2({'01'}, 'rsabilat_ba2930', [310 307 295 301 293 293 291 295 292 288])
%s01 - HC: rsa_simple_2({'01'}, 'rsabilat_hippo', [310 307 295 301 293 293 291 295 292 288])
%s01 - NAcc: rsa_simple_2({'01'}, 'rsarbilat_NAcc', [310 307 295 301 293 293 291 295 292 288])
%s01 - Ca: % RSC study, Liz H call (do this for every subject): rsa_simple_2({'01'}, 'rsarbilat_caudate', [310 307 295 301 293 293 291 295 292 288])
%s01 - Pu: % RSC study, Liz H call (do this for every subject): rsa_simple_2({'01'}, 'rsarbilat_putamen', [310 307 295 301 293 293 291 295 292 288])
%s02 - RSComplex:RSC study,rsa_simple_2({'02'}, 'rsabilat_RSComplex', [304 291 290 288 289 286 286 283 281 282])
%s02 - RSC: rsa_simple_2({'02'}, 'rsabilat_ba2930', [304 291 290 288 289 286 286 283 281 282])
%s02 - HC: rsa_simple_2({'02'}, 'rsabilat_hippo', [304 291 290 288 289 286 286 283 281 282])
%s03 - rsa_simple_2({'03'}, 'rsabilat_RSComplex', [294 293 291 291 289 299 286 287 286 284])
%s03 - rsa_simple_2({'03'}, 'rsabilat_ba2930', [294 293 291 291 289 299 286 287 286 284])
%s03 - rsa_simple_2({'03'}, 'rsabilat_hippo', [294 293 291 291 289 299 286 287 286 284])
%s05 - rsa_simple_2({'05'}, 'rsabilat_RSComplex', [313 298 297 295 292 289 285 286 283 283])
%s05 - rsa_simple_2({'05'}, 'rsabilat_ba2930', [313 298 297 295 292 289 285 286 283 283])
%s05 - rsa_simple_2({'05'}, 'rsabilat_hippo', [313 298 297 295 292 289 285 286 283 283])
%s07 - rsa_simple_2({'07'}, 'rsabilat_RSComplex', [295 346 288 287 285 289 284 282 281]) MISSING 1st TR
%s07 - rsa_simple_2({'07'}, 'rsabilat_ba2930', [295 346 288 287 285 289 284 282 281])
%s07 - rsa_simple_2({'07'}, 'rsabilat_hippo', [295 346 288 287 285 289 284 282 281])
%s09 - rsa_simple_2({'09'}, 'rsabilat_RSComplex', [291 297 296 296 291 296 293 287 287 285])
%s09 - rsa_simple_2({'09'}, 'rsabilat_ba2930', [291 297 296 296 291 296 293 287 287 285])
%s09 - rsa_simple_2({'09'}, 'rsabilat_hippo', [291 297 296 296 291 296 293 287 287 285])
%s10 - rsa_simple_2({'10'}, 'rsabilat_RSComplex', [289 283 279 277 278 280 281 278 278 278])
%s10 - rsa_simple_2({'10'}, 'rsabilat_ba2930', [289 283 279 277 278 280 281 278 278 278])
%s10 - rsa_simple_2({'10'}, 'rsabilat_hippo', [289 283 279 277 278 280 281 278 278 278])
%s11 - rsa_simple_2({'11'}, 'rsabilat_RSComplex', [306 297 297 295 291 289 288 285 285 284])
%s11 - rsa_simple_2({'11'}, 'rsabilat_ba2930', [306 297 297 295 291 289 288 285 285 284])
%s11 - rsa_simple_2({'11'}, 'rsabilat_hippo', [306 297 297 295 291 289 288 285 285 284])
%s12 - rsa_simple_2({'12'}, 'rsabilat_RSComplex', [299 293 293 293 292 315 291 290 291 288])
%s12 - rsa_simple_2({'12'}, 'rsabilat_ba2930', [299 293 293 293 292 315 291 290 291 288])
%s12 - rsa_simple_2({'12'}, 'rsabilat_hippo', [299 293 293 293 292 315 291 290 291 288])
%s13 - rsa_simple_2({'13'}, 'rsabilat_RSComplex', [290 287 287 286 284 283 282 279 280 279])
%s13 - rsa_simple_2({'13'}, 'rsabilat_ba2930', [290 287 287 286 284 283 282 279 280 279])
%s13 - rsa_simple_2({'13'}, 'rsabilat_hippo', [290 287 287 286 284 283 282 279 280 279]) 
%s14 - rsa_simple_2({'14'}, 'rsabilat_RSComplex', [300 290 287 290 288 283 280 278 277 277])
%s14 - rsa_simple_2({'14'}, 'rsabilat_ba2930', [300 290 287 290 288 283 280 278 277 277])
%s14 - rsa_simple_2({'14'}, 'rsabilat_hippo', [300 290 287 290 288 283 280 278 277 277]) 
%s15 - rsa_simple_2({'15'}, 'rsabilat_RSComplex', [298 293 299 258 288 288 283 286])% MISSING the last 2runs
%s15 - rsa_simple_2({'15'}, 'rsabilat_ba2930', [298 293 299 258 288 288 283 286])
%s15 - rsa_simple_2({'15'}, 'rsabilat_hippo', [298 293 299 258 288 288 283 286]) 
%s17 - rsa_simple_2({'17'}, 'rsabilat_RSComplex', [300 299 297 297 297 291 298 296 323 368])
%s17 - rsa_simple_2({'17'}, 'rsabilat_ba2930', [300 299 297 297 297 291 298 296 323 368])
%s17 - rsa_simple_2({'17'}, 'rsabilat_hippo', [300 299 297 297 297 291 298 296 323 368]) 
%s18 - rsa_simple_2({'18'}, 'rsabilat_RSComplex', [310 343 311 307 304 299 302 300 307 304])
%s18 - rsa_simple_2({'18'}, 'rsabilat_ba2930', [310 343 311 307 304 299 302 300 307 304])
%s18 - rsa_simple_2({'18'}, 'rsabilat_hippo', [310 343 311 307 304 299 302 300 307 304]) 
%s19 - rsa_simple_2({'19'}, 'rsabilat_RSComplex', [299 300 299 294 325 307 288 291 285 288])
%s19 - rsa_simple_2({'19'}, 'rsabilat_ba2930', [299 300 299 294 325 307 288 291 285 288])
%s19 - rsa_simple_2({'19'}, 'rsabilat_hippo', [299 300 299 294 325 307 288 291 285 288]) 
%s20 - rsa_simple_2({'20'}, 'rsabilat_RSComplex', [315 157 313 317 314 305 305 308 312 306])
%s20 - rsa_simple_2({'20'}, 'rsabilat_ba2930', [315 157 313 317 314 305 305 308 312 306])
%s20 - rsa_simple_2({'20'}, 'rsabilat_hippo', [315 157 313 317 314 305 305 308 312 306]) 
%s21 - rsa_simple_2({'21'}, 'rsabilat_RSComplex', [367 307 304 305 296 294 308 302 297 294])
%s21 - rsa_simple_2({'21'}, 'rsabilat_ba2930', [367 307 304 305 296 294 308 302 297 294])
%s21 - rsa_simple_2({'21'}, 'rsabilat_hippo', [367 307 304 305 296 294 308 302 297 294])
%s22 - rsa_simple_2({'22'}, 'rsabilat_RSComplex', [306 297 295 291 289 286 286 286 286 284])
%s22 - rsa_simple_2({'22'}, 'rsabilat_ba2930', [306 297 295 291 289 286 286 286 286 284])
%s22 - rsa_simple_2({'22'}, 'rsabilat_hippo', [306 297 295 291 289 286 286 286 286 284])
%s23 - rsa_simple_2({'23'}, 'rsabilat_RSComplex', [295 303 308 298 298 290 289 295 297 278])
%s23 - rsa_simple_2({'23'}, 'rsabilat_ba2930', [295 303 308 298 298 290 289 295 297 278])
%s23 - rsa_simple_2({'23'}, 'rsabilat_hippo', [295 303 308 298 298 290 289 295 297 278])
%s24 - rsa_simple_2({'24'}, 'rsabilat_RSComplex', [321 307 309 305 308 304 313 309 317 309])
%s24 - rsa_simple_2({'24'}, 'rsabilat_ba2930', [321 307 309 305 308 304 313 309 317 309])
%s24 - rsa_simple_2({'24'}, 'rsabilat_hippo', [321 307 309 305 308 304 313 309 317 309])

%For alternate code demo purposes, this is built around both 4D and 3D
%image file types. The use case for 4D includes scenarios like "raw" BOLD data or residual time-series

%warning: as of 1/3/2018; unconcatenated 4D analysis has not been debugged.
% at this time only use 3D images unless you fix the script

%% functional data parameters
% hallway time windows:
% cue period [duration: 8 secs, (4TRs), starts at TR3 (accounts for BOLD response],  
% hallway 1 [duration: 2.3 secs, (1TRs), starts at TR8],  
% hallway 2 [duration:2.3 secs, (1TRs), starts at TR9],  
% goal arrival [duration: 10 secs, (5TRs), starts at TR11] updated  Dec 12, 2025
S.TR = 2;
%theseTRWeights = [0 0 0.25 0.25 0.25 0.25]; %cue period: 8 secs
%theseTRWeights = [0 0 0 0 0 0 0 1]; %1st hallway: 2 secs
%theseTRWeights = [0 0 0 0 0 0 0 0 1]; %2nd hallway
theseTRWeights = [0 0 0 0 0 0 0 0 0 0 0.2 0.2 0.2 0.2 0.2]; %GOAL ARRIVAL (=3rd/final hallway+goal)
weights_str = mat2str(theseTRWeights);% assign values to string for custom output file naming

% what extension do your BOLD images have (nii, img)
funcftype = '.nii';

% are we working with BOLDs/timeseries ('raw') or with beta maps ('betas')?
% in this example code, only "raw" works - see rsa_CM_localizer2.m for
% example edits to add "betas" functionality
S.inputformat = 'raw';

%specify preprocessing level of BOLDs (if S.inputformat = 'raw')
preproc_lvl = 'wau'; % in SPM's conventions, these would be: 'a' for slice-time-only, 'u' for realigned-only, 'ua' for realign+unwarped, 'swua' for smoothed, normalized, and... you get the picture. Modify as needed if you changed SPM's prefix append defaults
boldnames = [preproc_lvl 'raw_']; %name of image files with preprocessing level prefix
% if your time-series is instead residuals (e.g., you regressed out
% motion-related signal using a GLM - so the data aren't *truly* "raw"...
%boldnames = ['ResI']; %for residual time-series

ImgDims = 3; %if working with timeseries, it is recommended that you use 4D nifti files ('4'). If you have split them out into TR-by-TR, or are working with betas, enter '3'


%% analysis flags
runs_concat = 1; %1 = typical SPM analysis; will have continuous onsets concatenated across runs. 0 = But you might not have bothered creating such a file, or in SST case we are using files from FSL. In this case, the onsets are assumed to "reset" for each run ('raw' unconcatenated onsets)
use_exist_workspace = 0; %1=yes. Load existing pattern workspaces and onsets files. Saves time, but turn off if want to manually re-do pattern extraction and generation.

gen_onsetsTR = 1; %1=yes. Typically, you'll use an onsets.mat file with tr-by-tr onsets and names (as used for a beta-series). But if you only have a traditional GLM model with one name for multiple onsets, setting this flag to 1 will auto-populate unique but related names (e.g., Face_1; Face_2...)
sortmatbycat = 1; %1=yes. Rearrange names and patterns according to alphabetical order (helps with visualization of corrmats)
runhpfilt = 1;%1=yes. Standard this is the high pass filter
runzscore = 1;%1=yes. Data normalization. Standard but controversial preprocessing.

%optional - after extracting patterns excluding NaN, do a second filter to
%exclude rows (voxels) where all the values are 0s
dropzeros = 1; %1=yes

%optional - toss similarity values from correlation matrices below a certain number as well (e.g., maybe a zero
%is equivalent to a NaN for your study. Say you are using a mask on "raw"
%BOLD data that does nothing to account for signal drop-out and extra-brain
%voxels are zeros instead of NaNs - here we can fix that
threshpats = 0; % 1 = YES

% what if our data of interest don't start at "run_01" (e.g., your localizer is the 10th and 11th scan session of the day)?
% specify scan run range
% NOTE: currently used only if runs_concat = 0
runstart = 1;
runend = 10;
realrnums = runstart:1:runend; 

%Subject ID/number
par.substr = ['s' Sub{1}];
S.subj_id = par.substr;

% What is your study's name / study folder name (subject folders should be
% subdirectories of this folder
%%S.exp_name = 'CCONS_TIBtest';
S.exp_name = 'COSPALCONS_QH/Subject'; %IT

% S.exp_name = 'COSPALCONS_QH/Subject';
% S.exp_name = 'CM_localizer';
%study_prefix = 'CM'; %we don't need this line
% What is the name of your model .mat file which specificies the condition labels
% and onset times for when the events of those conditions occurred?
S.onsets_filename = [S.subj_id '_early_late_model_specification']%name of onsets.mat model file
%S.onsets_filename = [S.subj_id '_localizer_onsets_test'];

% what if we don't want to use all of the conditions specified in our condition labels filed?
% ditch unneeded indices. NOTE: this is custom for class example
conditions_range = 1:8; %specify a vector to filter names/onsets/durations; class example 1:7 means use all conditions in the .mat file from #1 to 7 -> any conditions beyond that we won't bother finding patterns for them in the time-series

mask = Mask;


%% Directories
% S.expt_dir = ['/home/thackery/Documents/mvpa_sample_data/' S.exp_name '/'];%study location
%%S.expt_dir = ['/data2/' S.exp_name '/']; %study location
S.expt_dir = ['/projects/cos-lab-tbrown338/' S.exp_name '/']; % new IT study location:/projects/cos-lab-tbrown338/COSPALCONS_QH
% S.expt_dir = ['/run/user/3368316/gvfs/smb-share:server=cedar-cos.nas.gatech.edu,share=cos-lab-tbrown338/' S.exp_name '/']; %study location


par.subdir =[S.expt_dir S.subj_id];%subject location
par.funcdir =[par.subdir '/'];%subfolder for 'wauraw' BOLD data (make sure it is in 3D format and not 4D). Assumes BOLDs are stored in subfolders labeled 'run_01', etc)
%par.funcdir =[par.subdir '/bolds/'];%subfolder for 'raw' BOLD data. Assumes BOLDs are stored in subfolders labeled 'run_01', etc)

S.workspace_dir = [par.subdir '/mvpa_workspace'];%temporary files workspace, no need to edit this

%model file directory (onsets.mat and betas in here) - this is still used
%when working with raw data. We must have some way to tell the classifier
%which images correspond to which classes
S.mvpa_dir = '/data2/CCONS_TIBtest/'; 
%[S.expt_dir S.subj_id '/results01/'];


%ROI masks (could be whole-brain mask, but the code wants a mask file
S.anat_dir = ['/data2/CCONS_TIBtest/MNImasks'];
%S.anat_dir = [S.expt_dir S.subj_id '/Masks'];
maskname=[S.anat_dir '/' mask '.nii']; %this is from the call, so no need to change here

S.group_mvpa_dir = [S.mvpa_dir 'RSA_output_files'];%results .mat files are spit out in here (i.e., /data2/CCONS_TIBtest/)

if ~exist(S.group_mvpa_dir)
    mkdir(S.group_mvpa_dir)
end

if ~exist([S.mvpa_dir '/RSA_data/'])
    mkdir([S.mvpa_dir '/RSA_data/'])
end


%% extract and process patterns based on flags above
if runs_concat == 1
    %load onsets
    load([S.mvpa_dir S.onsets_filename]);

    %ditch unneeded indices. NOTE: this is custom for class example
    names = names(conditions_range);
    onsets = onsets(conditions_range);
    durations = durations(conditions_range);

    rmat_condensed = [];
    onsets_TRs = [];
    names_TRs = [];%filled in if gen_onsetsTR == 1
    runsel_TRs = [];

    %before loading and preprocessing all the pattern data, we can see if its
    %already there for analysis
    if use_exist_workspace && exist([S.mvpa_dir '/RSA_data/' S.subj_id '_' mask '_condensedpats.mat']);
        load([S.mvpa_dir '/RSA_data/' S.subj_id '_' mask '_condensedpats.mat']);
        load([S.mvpa_dir '/RSA_data/' S.subj_id '_onsets_expanded.mat']);
    else

        %% load in pattern data
        if ImgDims == 4 %in development

            a = [];

        elseif ImgDims == 3
            if strcmp(S.inputformat, 'raw')
                runfolds = dir(fullfile(par.funcdir, 'run*'));%dir(fullfile(par.funcdir, 'localizer*'));%
                for idxr = 1:length(runfolds)
                    allrawfilenames{idxr,1} = dir(fullfile(par.funcdir, runfolds(idxr).name, ['/' boldnames '*.nii']));%'/swa*.nii'));%

                    %if 3D images (not recommended) check if the count matches that
                    %specified for other stages of the process
                    if ImgDims == 3
                        if length(allrawfilenames{idxr})~=TRsperRun(idxr);
                            error('your specified run length does not match 3D file count')
                        end
                    end

                    for idxf = 1:length(allrawfilenames{idxr})
                        allrawfilepaths{idxr,1}{idxf,1} = runfolds(idxr).name;
                    end

                end

                allrawfilenames = vertcat(allrawfilenames{:});
                allrawfilepaths = vertcat(allrawfilepaths{:});
                for idx = 1:length(allrawfilenames)
                    raw_filenames{idx,1} = [par.funcdir char(allrawfilepaths(idx)) '/' allrawfilenames(idx).name];
                end

                %files may have been read in out of order. This would be very very bad.
                %Here, we try to confirm/fix this with a resort -
                % - But you *MUST* double check that the final file order is correct before proceeding with
                %analysis.
                % - Only turn this function on if necessary, and edit as needed to
                %find run numbers in the filenames to resort by!

                resortrawfnamesbyrunnum = 0;%1 = yes, try to re-sort the rawfilenames
                if resortrawfnamesbyrunnum == 1

                    for idx = 1:length(raw_filenames)
                        %first, identify the image number from its name in full
                        %('001' from run_001.nii)
                        nifti_indices = strfind(raw_filenames{idx,1}, '.nii'); %assuming .nii, where does that fall in the string?
                        underscore_indices = strfind(raw_filenames{idx,1}, '_'); %assuming the number is preceded by '_', where are the underscores?
                        imnum = str2double(raw_filenames{idx,1}(underscore_indices(end)+1:nifti_indices(end)-1));
                        raw_filenames{idx,2} = imnum;
                        %if length(raw_filenames{idx,1}) == 100%80
                        %    raw_filenames{idx,2} = str2double(raw_filenames{idx,1}(length(raw_filenames{idx,1})-9:length(raw_filenames{idx,1})-9));
                        %else
                        %    raw_filenames{idx,2} = str2double(raw_filenames{idx,1}(length(raw_filenames{idx,1})-10:length(raw_filenames{idx,1})-9));
                        %end

                    end

                    a = sortrows(raw_filenames, 2);
                    raw_filenames = a(:,1);

                    %if the BOLD images are 3D instead of 4D, we need to modify indices further to avoid introducing a new sorting error

                    for idx = 1:length(raw_filenames)
                        %first, identify the RUN number from its name in full
                        runref_indices = strfind(raw_filenames{idx,1}, '/run');
                        runidxnum = str2double(raw_filenames{idx,1}(runref_indices(1)+5:runref_indices(1)+6));%runref_indices(2)-1)); %%Warning - this coding assumes the run numbers do not exceed double digits
                        raw_filenames{idx,3} = runidxnum;
                    end

                    b = sortrows(raw_filenames, 3);
                    raw_filenames = b(:,1);
                    %run_sel = b(:,3);%store run numbers for reference

                end

                %now create a simple "run selector" (label for each pattern) using the
                %file paths themselves
                for idx = 1:length(raw_filenames)
                    %first, identify the RUN number from its name in full
                    runref_indices = strfind(raw_filenames{idx,1}, '/run');
                    %runidxnum =
                    %str2double(raw_filenames{idx,1}(runref_indices(1)+5:runref_indices(1)+6))
                    %this line above is the usual way of doing it (when
                    %there is one 'run' name in the path, but in our case
                    %there are 2 (as the line below)
            
                    runidxnum = str2double(raw_filenames{idx,1}(runref_indices(1)+5:runref_indices(1)+6));%runref_indices(2)-1)); %%Warning - this coding assumes the run numbers do not exceed double digits
                    run_sel{idx,1} = runidxnum;
                end
                run_sel = cell2mat(run_sel);
                imgslength = length(raw_filenames);

                %% iterate through 3D frames to extract all patterns
                for i=1:imgslength
                    betamaps{i} = raw_filenames{i};%[tmp.name ',' num2str(i)];

                    [b,r] = MAP_getROI(maskname, betamaps{i}, 'vox', 0, '');
                    bmat_t(:,i) = b{1}; % returns all voxels, whether or not they have NaNs
                    rmat_t(:,i) = r; % returns voxels excluding NaNs
                    %meanbetas_t = nanmean(bmat_t(:,:));%get mean beta values from the ROI for each regressor

                end

                %drop rows where the values are entirely 0 (i.e., "raw"
                %equivalent of NaN in betas
                if dropzeros == 1;
                    temporarymat = rmat_t(any(rmat_t,2),:);
                    rmat_t = temporarymat;
                end

                %% optional preprocessing
                figure;
                % hp filter the data - recommended
                if runhpfilt == 1
                    rmat_t = hp_filter(rmat_t,run_sel',100,S.TR)';%2=2s TR

                    %plot for exploration
                    cm_t = corr(rmat_t);
                    subplot(2,1,1), imagesc(cm_t);
                    title('hp_filt corrmat')
                    colormap('jet'); % set the colorscheme
                    colorbar;
                    caxis([-1 1]);
                end

                % zscore within runs
%                 if runzscore == 1 %%ORIGINAL TIB CODE
% 
%                     pat_t = [];
% 
%                     for r = 1:length(TRsperRun) %for each run %%ORIGINAL TIB CODE
%                         activepats = rmat_t(:,logical(run_sel==r));%filter patterns to current run
%                         if size(activepats,2)~=TRsperRun(r)
%                             error('Your pattern count doesnt match current run length');
%                         end
% 
%                         pat_t = [pat_t zscore_mvpa(activepats,2)];%2 = z-score within rows (within-voxels)
%                     end %%ORIGINAL TIB CODE
%  rmat_t = pat_t;
% 
%                     %plot for exploration
%                     cm_t2 = corr(rmat_t);
%                     subplot(2,1,2), imagesc(cm_t2);
%                     title('hp_filt_z corrmat')
%                     colormap('jet'); % set the colorscheme
%                     colorbar;
%                     caxis([-1 1]);
%                 end %%ORIGINAL TIB CODE

%%%%%%%%%%%%%%
if runzscore == 1          % <--- IF (runzscore)

    pat_t = [];

    runs = unique(run_sel, 'stable');

    if length(runs) ~= length(TRsperRun)
        error('Number of runs in run_sel does not match TRsperRun length');
    end                    % <--- IF (length check)

    for i = 1:length(runs) % <--- FOR (runs)

        r = runs(i); % actual run label (e.g., 2..10)
        activepats = rmat_t(:, run_sel == r);

        if size(activepats,2) ~= TRsperRun(i)
            error('Run %d: found %d patterns, expected %d TRs', ...
                  r, size(activepats,2), TRsperRun(i));
        end                % <--- IF (TR count check)

        pat_t = [pat_t zscore_mvpa(activepats, 2)];

    end                    % <--- FOR (runs)

    rmat_t = pat_t;

    % plot for exploration
    cm_t2 = corr(rmat_t);
    subplot(2,1,2), imagesc(cm_t2);
    title('hp_filt_z corrmat')
    colormap('jet');
    colorbar;
    caxis([-1 1]);

end                        % <--- IF (runzscore)

      
%%%%%%%%%%%%%%%

                   
                %% now compute a mean pattern for __ TRs surrounding the onset

                for n = 1:length(names)


                    time_idx = floor(onsets{n}/S.TR) + 1;%convert onsets to TRs

                    onsets_TR{n} = time_idx; %sort(horzcat(onsets_t{n}, onsets_t{n}{idxThisCond}(enoughTRs_h)));%put the onsets for cond{i} into an array,

                    theseTRWeights2 = theseTRWeights;

                    %create weighted mean pattern for that onset
                    for nvoxr = 1:size(rmat_t,1)
                        %tempvals = [];
                        for tidx = 1:length(time_idx)
                            tempvals = theseTRWeights2.*rmat_t(nvoxr,time_idx(tidx):time_idx(tidx)+(length(theseTRWeights2)-1));
                            condmat_condensed_t{nvoxr,time_idx(tidx)} = squeeze(sum(tempvals));
                        end
                    end
                    %rmat_condensed = [rmat_condensed condmat_condensed_t];

                    if gen_onsetsTR == 1 %if we need to split our names out by individual events
                        for tidx = 1:length(time_idx)
                            tempnames{time_idx(tidx)} = [names{n} '_' num2str(tidx)];
                            temprunsel{time_idx(tidx)} = run_sel(time_idx(tidx));
                        end
                    end

                    %runsel_TRs = [runsel_TRs temprunsel];
                    %names_TRs = [names_TRs tempnames];
                end

                filt = any(~cellfun('isempty', condmat_condensed_t),1);
                rmat_condensed = cell2mat(condmat_condensed_t(:,filt));
                runsel_TRs = temprunsel(:,filt);
                names_TRs = tempnames(:,filt);


            end
        end


        %% write out pattern info
        savename1 = [S.mvpa_dir '/RSA_data/' S.subj_id '_' mask '_condensedpats.mat'];
        save(savename1,'rmat_condensed');

        savename2 = [S.mvpa_dir '/RSA_data/' S.subj_id '_onsets_expanded.mat'];
        save(savename2,'names','onsets','names_TRs','durations');
    end

else %if runs are NOT concatenated %-------in debugging stage as of 1/3/2018
    tempmat = []; %initialize an empty matrix you'll append data from the runs to
    tnames = [];

    for rnum = 1:length(TRsperRun) %4 for 4 probe runs 3-6

        run = num2str(realrnums(rnum), '%02.f'); %+2 added to start at run03 instead of run01

        path = [par.funcdir '/run' run '/'];

        cd(path);

        %load onsets for the run
        load([S.onsets_filename '_' run]); %[S.mvpa_dir S.onsets_filename]);

        if ImgDims == 4 %in development

            a = [];

        elseif ImgDims == 3

            allrawfilenames{rnum,1} = dir(fullfile(['./' boldnames '*.nii']));

            %if 3D images (not recommended) check if the count matches that
            %specified for other stages of the process
            if ImgDims == 3
                if length(allrawfilenames{rnum})~=TRsperRun(rnum);
                    error('your specified run length does not match 3D file count')
                end
            end

            %             for idxf = 1:length(allrawfilenames{rnum})
            %                 allrawfilepaths{rnum,1}{rnum,1} = runfolds(rnum).name;
            %             end
            %             x = [allrawfilenames{1}(1).folder '/' allrawfilenames{1}(1).name]
            %allrawfilenames = vertcat(allrawfilenames{:});
            %             allrawfilepaths = vertcat(allrawfilepaths{:});

            raw_filenames = {};
            for idx = 1:length(allrawfilenames{rnum})%length(allrawfilenames);
                raw_filenames{idx,1} = [allrawfilenames{rnum}(idx).folder '/' allrawfilenames{rnum}(idx).name];
            end

            imgslength = length(raw_filenames);

            %% iterate through 3D frames to extract all patterns
            bmat_t = [];
            rmat_t = [];
            for i=1:imgslength
                betamaps{i} = raw_filenames{i};%[tmp.name ',' num2str(i)];

                [b,r] = MAP_getROI(maskname, betamaps{i}, 'vox', 0, '');
                bmat_t(:,i) = b{1}; % returns all voxels, whether or not they have NaNs
                rmat_t(:,i) = r; % returns voxels excluding NaNs
                %meanbetas_t = nanmean(bmat_t(:,:));%get mean beta values from the ROI for each regressor
            end

            %drop rows where the values are entirely 0 (i.e., "raw"
            %equivalent of NaN in betas
            if dropzeros == 1;
                temporarymat = rmat_t(any(rmat_t,2),:);
                rmat_t = temporarymat;
            end

            %% optional preprocessing
            figure;
            % hp filter the data - recommended
            run_sel = ones(1,imgslength); % because we are doing one run at a time, run_sel is nonexistant at this time
            if runhpfilt == 1
                rmat_t = hp_filter(rmat_t,run_sel',100,S.TR)';%2=2s TR

                %plot for exploration
                cm_t = corr(rmat_t);
                subplot(2,1,1), imagesc(cm_t);
                title('hp_filt corrmat')
                colormap('jet'); % set the colorscheme
                colorbar;
                caxis([-1 1]);
            end

            % zscore within runs
            if runzscore == 1

                pat_t = [];

                %    for r = 1:length(TRsperRun) %for each run
                activepats = rmat_t;%(:,logical(run_sel==r));%filter patterns to current run
                if size(activepats,2)~=TRsperRun(rnum)
                    error('Your pattern count doesnt match current run length');
                end

                pat_t = [pat_t zscore_mvpa(activepats,2)];%2 = z-score within rows (within-voxels)
                %    end

                rmat_t = pat_t;

                %plot for exploration
                cm_t2 = corr(rmat_t);
                subplot(2,1,2), imagesc(cm_t2);
                title('hp_filt_z corrmat')
                colormap('jet'); % set the colorscheme
                colorbar;
                caxis([-1 1]);
            end

            %% now compute a mean pattern for __ TRs surrounding the onset

            for n = 1:length(names)


                time_idx = floor(onsets{n}/S.TR) + 1;%convert onsets to TRs

                onsets_TR{n} = time_idx; %sort(horzcat(onsets_t{n}, onsets_t{n}{idxThisCond}(enoughTRs_h)));%put the onsets for cond{i} into an array,

                theseTRWeights2 = theseTRWeights;

                %create weighted mean pattern for that onset
                for nvoxr = 1:size(rmat_t,1)
                    %tempvals = [];
                    for tidx = 1:length(time_idx)
                        tempvals = theseTRWeights2.*rmat_t(nvoxr,time_idx(tidx):time_idx(tidx)+(length(theseTRWeights2)-1));
                        condmat_condensed_t{nvoxr,time_idx(tidx)} = squeeze(sum(tempvals));
                    end
                end
                %rmat_condensed = [rmat_condensed condmat_condensed_t];

                if gen_onsetsTR == 1 %if we need to split our names out by individual events
                    for tidx = 1:length(time_idx)
                        tempnames{time_idx(tidx)} = [names{n} '_' run '_' num2str(tidx)];
                        temprunsel{time_idx(tidx)} = run_sel(time_idx(tidx));
                    end
                end

                %runsel_TRs = [runsel_TRs temprunsel];
                %names_TRs = [names_TRs tempnames];
            end

            filt = any(~cellfun('isempty', condmat_condensed_t),1);
            rmat_condensed = cell2mat(condmat_condensed_t(:,filt));
            runsel_TRs = temprunsel(:,filt);
            names_TRs = tempnames(:,filt);
            tempnames=[];%clear for next loop
            temprunsel=[];
            condmat_condensed_t=[];
        end

        tempmat = [tempmat rmat_condensed]; % now concatenate with other runs' data
        tnames = [tnames names_TRs];
    end

    rmat_condensed = tempmat;
    names_TRs = tnames;

end

%% for visualization and statistical analyses, create indices for patterns of interest in corr matrices

if gen_onsetsTR == 1
    names = names_TRs;
end

%optional first rearrange data according to category to help with visualization
if sortmatbycat == 1
    [names_TRs y] = natsort(names);%requires natsort in path
    names = names_TRs;
    rmat_condensed = rmat_condensed(:,y);
end

% first index different categories
for n = 1:length(names)
    if contains(names{n},{'cue_nol_new_early'})%
        cue_nol_new_early_idx(n)=1;
        cue_nol_new_late_idx(n)=0;
        cue_ol_new_early_idx(n) = 0;
        cue_ol_new_late_idx(n)=0;
        cue_nol_old_early_idx(n)=0;
        cue_nol_old_late_idx(n)=0;
        cue_ol_old_early_idx(n)=0;
        cue_ol_old_late_idx(n)=0;
        othercond_idx(n) = 0;
    elseif contains(names{n},{'cue_nol_new_late'})%
        cue_nol_new_early_idx(n)=0;
        cue_nol_new_late_idx(n)=1;
        cue_ol_new_early_idx(n) = 0;
        cue_ol_new_late_idx(n)=0;
        cue_nol_old_early_idx(n)=0;
        cue_nol_old_late_idx(n)=0;
        cue_ol_old_early_idx(n)=0;
        cue_ol_old_late_idx(n)=0;
        othercond_idx(n) = 0;
    elseif contains(names{n},{'cue_ol_new_early'})%
        cue_nol_new_early_idx(n)=0;
        cue_nol_new_late_idx(n)=0;
        cue_ol_new_early_idx(n) = 1;
        cue_ol_new_late_idx(n)=0;
        cue_nol_old_early_idx(n)=0;
        cue_nol_old_late_idx(n)=0;
        cue_ol_old_early_idx(n)=0;
        cue_ol_old_late_idx(n)=0;
        othercond_idx(n) = 0;
    elseif contains(names{n},{'cue_ol_new_late'})%
        cue_nol_new_early_idx(n)=0;
        cue_nol_new_late_idx(n)=0;
        cue_ol_new_early_idx(n) = 0;
        cue_ol_new_late_idx(n)=1;
        cue_nol_old_early_idx(n)=0;
        cue_nol_old_late_idx(n)=0;
        cue_ol_old_early_idx(n)=0;
        cue_ol_old_late_idx(n)=0;
        othercond_idx(n) = 0;
    elseif contains(names{n},{'cue_nol_old_early'})%
        cue_nol_new_early_idx(n)=0;
        cue_nol_new_late_idx(n)=0;
        cue_ol_new_early_idx(n) = 0;
        cue_ol_new_late_idx(n)=0;
        cue_nol_old_early_idx(n)=1;
        cue_nol_old_late_idx(n)=0;
        cue_ol_old_early_idx(n)=0;
        cue_ol_old_late_idx(n)=0;
        othercond_idx(n) = 0;
    elseif contains(names{n},{'cue_nol_old_late'})%
        cue_nol_new_early_idx(n)=0;
        cue_nol_new_late_idx(n)=0;
        cue_ol_new_early_idx(n) = 0;
        cue_ol_new_late_idx(n)=0;
        cue_nol_old_early_idx(n)=0;
        cue_nol_old_late_idx(n)=1;
        cue_ol_old_early_idx(n)=0;
        cue_ol_old_late_idx(n)=0;
        othercond_idx(n) = 0;
    elseif contains(names{n},{'cue_ol_old_early'})%
        cue_nol_new_early_idx(n)=0;
        cue_nol_new_late_idx(n)=0;
        cue_ol_new_early_idx(n) = 0;
        cue_ol_new_late_idx(n)=0;
        cue_nol_old_early_idx(n)=0;
        cue_nol_old_late_idx(n)=0;
        cue_ol_old_early_idx(n)=1;
        cue_ol_old_late_idx(n)=0;
        othercond_idx(n) = 0;
    elseif contains(names{n},{'cue_ol_old_late'})%
        cue_nol_new_early_idx(n)=0;
        cue_nol_new_late_idx(n)=0;
        cue_ol_new_early_idx(n) = 0;
        cue_ol_new_late_idx(n)=0;
        cue_nol_old_early_idx(n)=0;
        cue_nol_old_late_idx(n)=0;
        cue_ol_old_early_idx(n)=0;
        cue_ol_old_late_idx(n)=1;
        othercond_idx(n) = 0;
    else
        cue_nol_new_early_idx(n)=0;
        cue_nol_new_late_idx(n)=0;
        cue_ol_new_early_idx(n) = 0;
        cue_ol_new_late_idx(n)=0;
        cue_nol_old_early_idx(n)=0;
        cue_nol_old_late_idx(n)=0;
        cue_ol_old_early_idx(n)=0;
        cue_ol_old_late_idx(n)=0;
        othercond_idx(n) = 1;
        
        %%%%
%          if contains(names{n},{'EA'})%
%         EA_idx(n)=1;
%         AA_idx(n)=0;
%         Face_idx(n) = 0;
%         Scene_idx(n)=0;
%         Obj_idx(n)=0;
%         othercond_idx(n) = 0;
%     elseif contains(names{n},{'AA'})%
%         EA_idx(n)=0;
%         AA_idx(n)=1;
%         Face_idx(n) = 0;
%         Scene_idx(n)=0;
%         Obj_idx(n)=0;
%         othercond_idx(n) = 0;
%     elseif contains(names{n},{'Scene'})%
%         EA_idx(n)=0;
%         AA_idx(n)=0;
%         Face_idx(n) = 0;
%         Scene_idx(n)=1;
%         Obj_idx(n)=0;
%         othercond_idx(n) = 0;
%     elseif contains(names{n},{'Obj'})%
%         EA_idx(n)=0;
%         AA_idx(n)=0;
%         Face_idx(n) = 0;
%         Scene_idx(n)=0;
%         Obj_idx(n)=1;
%         othercond_idx(n) = 0;
%     else
%         EA_idx(n)=0;
%         AA_idx(n)=0;
%         Face_idx(n) = 0;
%         Scene_idx(n)=0;
%         Obj_idx(n)=0;
%         othercond_idx(n) = 1;
        %fprintf('Error! None of categories names found for this idx!\n')
        %return
    end
end


% for n = 1:length(names)
%     if contains(names{n},{'EA','AA'})%strfind(names{n},'EA') | strfind(names{n}, 'AA')
%         Face_idx(n) = 1;
%     else
%         Face_idx(n) = 0;
%     end
% end

% run1s = logical(cell2mat(runsel_TRs)==1);

% but some conditions are scrambled faces, not intact. Let's index those
% for n = 1:length(names)
%     if contains(names{n},{'_scrambled'})%
%         scrambled_idx(n)=1;
%     else
%         scrambled_idx(n)=0;
%     end
% end

% scrambled_idx = scrambled_idx(1:length(EA_idx));%ensure this vector doesn't exceed length of face vector

%~~~~~~~Find intersections of the instances to examine more specific results
%scrambled faces
% EA_scrambled = EA_idx.*scrambled_idx;% ".*" syntax means multiply the corresponding elements of each matrix or vector
% AA_scrambled = AA_idx.*scrambled_idx;
% 
% %now we can isolate intact faces
% EA_intact = EA_idx-EA_scrambled;%
% AA_intact = AA_idx-AA_scrambled;
% Face_intact = Face_idx-scrambled_idx;

%% create correlation matrices

if threshpats == 1
    thresh = 0.01*mean(mean(rmat_condensed'));%you come up with your scheme - this example will threshold out anything <99% of the average (quite liberal thresholding)
    x1 =[]; %vector of filtered intensity values
    for p = 1:length(rmat_condensed(1,:))
        x1 = [x1 (rmat_condensed(:,p)>thresh)];
    end
    t = mean(x1');% average across columns - anything less than 1 indicates there are some zeros
    t1 = t'>=1; %threshold once more to voxels that had signal passing our threshold for EVERY pattern
early
    rmat_condensed = rmat_condensed(t1,:);
end

cm = corr(rmat_condensed);
cm(find(~triu(cm,1))) = NaN; % nan out correlations that are redundant
%if calculating similarity off overlapping indices, mask out lower half of
%matrix. Otherwise you will sample the same correlation twice. E.g.,
%"similarity of probes with probes"

%on the other hand, if you are using non-overlapping indices (e.g.,
%remembereds with forgottens) then you'll miss correlations by looking in
%only one half of the matrix. in this case use the full matrix (NaN
%diagonal still)

cm2 = corr(rmat_condensed); %another correlation matrix
cm2(cm2==1)=nan; %nan out the diagonal

%assign to res struct for easy saving
res.cm = cm;
res.cm2 = cm2;

%% global similarity measures - what is the representational match of a category to other exemplars of itself, or to those of a superordinate category (e.g., face similarity with ALL visual stimuli [vs. auditory stimuli])

%         cue_nol_new_early_idx(n)=0; %labels
%         cue_nol_new_late_idx(n)=0;
%         cue_ol_new_early_idx(n) = 0;
%         cue_ol_new_late_idx(n)=0;
%         cue_nol_old_early_idx(n)=0;
%         cue_nol_old_late_idx(n)=0;
%         cue_ol_old_early_idx(n)=0;
%         cue_ol_old_late_idx(n)=0;
%         othercond_idx(n) = 1;
        
%these are te results 'res'
res.nol_new_early_w_nol_new_early = cm(logical(cue_nol_new_early_idx),logical(cue_nol_new_early_idx)); %this compares within the same category how similar the representation of same mazes are (e.g., nol_new)
res.nol_new_early_w_nol_new_early_mean = nanmean(res.nol_new_early_w_nol_new_early(:));

res.nol_new_late_w_nol_new_late = cm(logical(cue_nol_new_late_idx),logical(cue_nol_new_late_idx));
res.nol_new_late_w_nol_new_late_mean = nanmean(res.nol_new_late_w_nol_new_late(:));

res.cue_ol_new_early_w_cue_ol_new_early = cm(logical(cue_ol_new_early_idx),logical(cue_ol_new_early_idx));
res.cue_ol_new_early_w_cue_ol_new_early_mean = nanmean(res.cue_ol_new_early_w_cue_ol_new_early(:));

res.cue_ol_new_late_w_cue_ol_new_late = cm(logical(cue_ol_new_late_idx),logical(cue_ol_new_late_idx));
res.cue_ol_new_late_w_cue_ol_new_late_mean = nanmean(res.cue_ol_new_late_w_cue_ol_new_late(:));

res.ol_new_early_w_nol_new_early = cm2(logical(cue_ol_new_early_idx),logical(cue_nol_new_early_idx));
res.ol_new_early_w_nol_new_early_mean = nanmean(res.ol_new_early_w_nol_new_early(:));

res.ol_new_late_w_nol_new_late = cm2(logical(cue_ol_new_late_idx),logical(cue_nol_new_late_idx));
res.ol_new_late_w_nol_new_late_mean = nanmean(res.ol_new_late_w_nol_new_late(:));

%%
res.ol_new_early_w_ol_old_early = cm2(logical(cue_ol_new_early_idx),logical(cue_ol_old_early_idx));
res.ol_new_early_w_ol_old_early_mean = nanmean(res.ol_new_early_w_ol_old_early(:));

res.ol_new_late_w_ol_old_late = cm2(logical(cue_ol_new_late_idx),logical(cue_ol_old_late_idx));
res.ol_new_late_w_ol_old_late_mean = nanmean(res.ol_new_late_w_ol_old_late(:));
% 
% res.EA_w_Obj = cm2(logical(EA_intact),logical(Obj_idx));
% res.EA_w_Obj_mean = nanmean(res.EA_w_Obj(:));
% 
% res.Face_w_Obj = cm2(logical(Face_intact),logical(Obj_idx));


%% Plots
%EXAMPLE PER EACH SUBJECT
%plot matrices of interest
% figure;
% subplot(2,2,1), imagesc(cm);
% title('Within-cond corrmat');
% colormap('jet'); % set the colorscheme
% caxis([-1 1]);
% colorbar; % enable colorbar
% 
% subplot(2,2,2), imagesc(cm2);
% title('Overall corrmat');
% colormap('jet'); % set the colorscheme
% caxis([-1 1]);
% colorbar; % enable colorbar
% 
% subplot(2,2,3), imagesc(cm(logical(EA_intact),logical(EA_intact)));
% title('EA with EA across blocks and runs');
% colormap('jet'); % set the colorscheme
% caxis([-1 1]);
% colorbar; % enable colorbar
% 
% subplot(2,2,4), imagesc(cm2(logical(EA_intact),logical(Scene_idx)));
% title('EA with Scene across blocks and runs');
% colormap('jet'); % set the colorscheme
% caxis([-1 1]);
% colorbar; % enable colorbar
% 
% % save plot
% plot_savename = [S.group_mvpa_dir '/Rcorrs_' S.subj_id '_' mask '_' weights_str '_' S.exp_name '_corrmats.png'];
% saveas(gcf,plot_savename);

%% examine correlation structure between two specific classes
% testinds = EA_intact+AA_intact;
% custlbls = names(logical(testinds));
% rmat_condensed_short = rmat_condensed(:,logical(testinds));
% cm_2c = corr(rmat_condensed_short);
% figure;
% imagesc(cm_2c);
% colormap('jet');
% caxis([-1 1]);
% colorbar;
% set(gca, 'XTicklabel', custlbls, 'XTick', [1:length(custlbls)]);
% set(gca, 'YTicklabel', custlbls, 'YTick', [1:length(custlbls)]);
% res.cm_2c = cm_2c;
% 
% % is there a rhyme or reason to the similarity accorting to category?
% schemaball(cm2,names_TRs);


%% Save data
savename = [S.group_mvpa_dir '/Rcorrs_' S.subj_id '_' mask '_' weights_str '_' '.mat'];
save(savename, 'res');

% savename = [S.group_mvpa_dir '/Rcorrs_' S.subj_id '_' mask '_' weights_str '_' S.exp_name '.mat'];
% save(savename, 'res');

end






function data = hp_filter(pat,sel,cutoff,tr)

% max(sel) amounts to the maximum number of runs there could
% be. any values in the runs selector that are <= 0 will be ignored
% by the for loop. won't mind if you're lacking a particular run in
% the middle either

nRuns = max(sel);
data  = pat';	% transposition required for spm_filter

for r = 1:nRuns
    progress(r,nRuns);
    this_run = sel==r; % select current run

    K(r).row = find(this_run == 1);
    K(r).RT  = tr;
    K(r).HParam = cutoff;

    data = spm_filter(K,data);

end
end

function modfits = CMmodelcomparison(cm,idx1,idx2,idx3,idx4,idx5,idx6)
%% construct Four sample CM models
%normally, these would be built from some theoretical or computational models of how information is organized in the
%brain's perceptual, mnemonic, etc, systems

cm2 = cm;
EA_intact = idx1;
AA_intact = idx2;
Obj_idx = idx3;
othercond_idx = idx4;
Scene_idx = idx5;
scrambled_idx = idx6;

cm2_testo1 = cm2;% model 1 - "all faces and objects are "items" to this area - scenes are scenes, and distinct from objects"
cm2_testo1(logical(EA_intact),logical(EA_intact))=0.5;
cm2_testo1(logical(AA_intact),logical(AA_intact))=0.5;
cm2_testo1(logical(Obj_idx),logical(Obj_idx))=0.5;
cm2_testo1(logical(EA_intact),logical(AA_intact))=0.5;
cm2_testo1(logical(EA_intact),logical(Obj_idx))=0.5;
cm2_testo1(logical(AA_intact),logical(Obj_idx))=0.5;
cm2_testo1(logical(AA_intact),logical(EA_intact))=0.5;
cm2_testo1(logical(Obj_idx),logical(EA_intact))=0.5;
cm2_testo1(logical(Obj_idx),logical(AA_intact))=0.5;

cm2_testo1(logical(othercond_idx),logical(othercond_idx))=0.5;

cm2_testo1(logical(othercond_idx),logical(EA_intact))=0.5;
cm2_testo1(logical(othercond_idx),logical(AA_intact))=0.5;
cm2_testo1(logical(othercond_idx),logical(Obj_idx))=0.5;
cm2_testo1(logical(EA_intact),logical(othercond_idx))=0.5;
cm2_testo1(logical(AA_intact),logical(othercond_idx))=0.5;
cm2_testo1(logical(Obj_idx),logical(othercond_idx))=0.5;

cm2_testo1(logical(Scene_idx),logical(Scene_idx))=0.5;

cm2_testo1(logical(EA_intact),logical(Scene_idx))=0.1;
cm2_testo1(logical(AA_intact),logical(Scene_idx))=0.1;
cm2_testo1(logical(Obj_idx),logical(Scene_idx))=0.1;
cm2_testo1(logical(Scene_idx),logical(EA_intact))=0.1;
cm2_testo1(logical(Scene_idx),logical(AA_intact))=0.1;
cm2_testo1(logical(Scene_idx),logical(Obj_idx))=0.1;
cm2_testo1(logical(othercond_idx),logical(Scene_idx))=0.1;
cm2_testo1(logical(Scene_idx),logical(othercond_idx))=0.1;

cm2_testo1(logical(scrambled_idx),logical(scrambled_idx))=0.1;

cm2_testo1(logical(Scene_idx),logical(scrambled_idx))=0.1;
cm2_testo1(logical(Obj_idx),logical(scrambled_idx))=0.1;
cm2_testo1(logical(EA_intact),logical(scrambled_idx))=0.1;
cm2_testo1(logical(AA_intact),logical(scrambled_idx))=0.1;
cm2_testo1(logical(othercond_idx),logical(scrambled_idx))=0.1;
cm2_testo1(logical(scrambled_idx),logical(Scene_idx))=0.1;
cm2_testo1(logical(scrambled_idx),logical(Obj_idx))=0.1;
cm2_testo1(logical(scrambled_idx),logical(EA_intact))=0.1;
cm2_testo1(logical(scrambled_idx),logical(AA_intact))=0.1;
cm2_testo1(logical(scrambled_idx),logical(othercond_idx))=0.1;
%set diagonal back to NaN
cm2_testo1(logical(eye(size(cm2_testo1)))) = NaN;

cm2_testo2 = cm2;% model 2 - "faces > bodies > inanimate objects gradient - scenes are scenes, and distinct from items"
cm2_testo2(logical(EA_intact),logical(EA_intact))=0.5;
cm2_testo2(logical(AA_intact),logical(AA_intact))=0.5;
cm2_testo2(logical(Obj_idx),logical(Obj_idx))=0.5;
cm2_testo2(logical(EA_intact),logical(AA_intact))=0.5;
cm2_testo2(logical(EA_intact),logical(Obj_idx))=0.25;
cm2_testo2(logical(AA_intact),logical(Obj_idx))=0.25;
cm2_testo2(logical(AA_intact),logical(EA_intact))=0.5;
cm2_testo2(logical(Obj_idx),logical(EA_intact))=0.25;
cm2_testo2(logical(Obj_idx),logical(AA_intact))=0.25;

cm2_testo2(logical(othercond_idx),logical(othercond_idx))=0.5;

cm2_testo2(logical(othercond_idx),logical(EA_intact))=0.35;
cm2_testo2(logical(othercond_idx),logical(AA_intact))=0.35;
cm2_testo2(logical(othercond_idx),logical(Obj_idx))=0.25;
cm2_testo2(logical(EA_intact),logical(othercond_idx))=0.35;
cm2_testo2(logical(AA_intact),logical(othercond_idx))=0.35;
cm2_testo2(logical(Obj_idx),logical(othercond_idx))=0.25;

cm2_testo2(logical(Scene_idx),logical(Scene_idx))=0.5;

cm2_testo2(logical(EA_intact),logical(Scene_idx))=0.1;
cm2_testo2(logical(AA_intact),logical(Scene_idx))=0.1;
cm2_testo2(logical(Obj_idx),logical(Scene_idx))=0.15;
cm2_testo2(logical(Scene_idx),logical(EA_intact))=0.1;
cm2_testo2(logical(Scene_idx),logical(AA_intact))=0.1;
cm2_testo2(logical(Scene_idx),logical(Obj_idx))=0.15;
cm2_testo2(logical(othercond_idx),logical(Scene_idx))=0.1;
cm2_testo2(logical(Scene_idx),logical(othercond_idx))=0.1;

cm2_testo2(logical(scrambled_idx),logical(scrambled_idx))=0.1;

cm2_testo2(logical(Scene_idx),logical(scrambled_idx))=0.1;
cm2_testo2(logical(Obj_idx),logical(scrambled_idx))=0.1;
cm2_testo2(logical(EA_intact),logical(scrambled_idx))=0.1;
cm2_testo2(logical(AA_intact),logical(scrambled_idx))=0.1;
cm2_testo2(logical(othercond_idx),logical(scrambled_idx))=0.1;
cm2_testo2(logical(scrambled_idx),logical(Scene_idx))=0.1;
cm2_testo2(logical(scrambled_idx),logical(Obj_idx))=0.1;
cm2_testo2(logical(scrambled_idx),logical(EA_intact))=0.1;
cm2_testo2(logical(scrambled_idx),logical(AA_intact))=0.1;
cm2_testo2(logical(scrambled_idx),logical(othercond_idx))=0.1;
%set diagonal back to NaN
cm2_testo2(logical(eye(size(cm2_testo2)))) = NaN;


%compare with vectorized unique correlations of cm2
truem = cm2(triu(true(size(cm2)),1));
testm1 = cm2_testo1(triu(true(size(cm2_testo1)),1));
[modfits.r_trvste1 modfits.p_trvste1] = corr(truem,testm1,'Type','Spearman');

testm2 = cm2_testo2(triu(true(size(cm2_testo2)),1));
[modfits.r_trvste2 modfits.p_trvste2] = corr(truem,testm2,'Type','Spearman');
%at the group level, you can use statistics like Wilcoxin signed-rank test
%to test for significance of specific model-CM mappings

%% create variant with two categorical predictors for "encoding" regression test (see Mur et al., 2013)
%construct two sample CM models - normally, these would be built from some
%theoretical or computational models of how information is organized in the
%brain's perceptual, mnemonic, etc, systems
cm2_testo3 = cm2;% model 3 - categorical animate-inanimate
cm2_testo3(logical(EA_intact),logical(EA_intact))=1;
cm2_testo3(logical(AA_intact),logical(AA_intact))=1;
cm2_testo3(logical(Obj_idx),logical(Obj_idx))=1;
cm2_testo3(logical(EA_intact),logical(AA_intact))=1;
cm2_testo3(logical(EA_intact),logical(Obj_idx))=-1;
cm2_testo3(logical(AA_intact),logical(Obj_idx))=-1;
cm2_testo3(logical(AA_intact),logical(EA_intact))=1;
cm2_testo3(logical(Obj_idx),logical(EA_intact))=-1;
cm2_testo3(logical(Obj_idx),logical(AA_intact))=-1;

cm2_testo3(logical(othercond_idx),logical(othercond_idx))=1;

cm2_testo3(logical(othercond_idx),logical(EA_intact))=1;
cm2_testo3(logical(othercond_idx),logical(AA_intact))=1;
cm2_testo3(logical(othercond_idx),logical(Obj_idx))=-1;
cm2_testo3(logical(EA_intact),logical(othercond_idx))=1;
cm2_testo3(logical(AA_intact),logical(othercond_idx))=1;
cm2_testo3(logical(Obj_idx),logical(othercond_idx))=-1;

cm2_testo3(logical(Scene_idx),logical(Scene_idx))=1;

cm2_testo3(logical(EA_intact),logical(Scene_idx))=-1;
cm2_testo3(logical(AA_intact),logical(Scene_idx))=-1;
cm2_testo3(logical(Obj_idx),logical(Scene_idx))=1;
cm2_testo3(logical(Scene_idx),logical(EA_intact))=-1;
cm2_testo3(logical(Scene_idx),logical(AA_intact))=-1;
cm2_testo3(logical(Scene_idx),logical(Obj_idx))=1;
cm2_testo3(logical(othercond_idx),logical(Scene_idx))=-1;
cm2_testo3(logical(Scene_idx),logical(othercond_idx))=-1;

cm2_testo3(logical(scrambled_idx),logical(scrambled_idx))=1;

cm2_testo3(logical(Scene_idx),logical(scrambled_idx))=0;
cm2_testo3(logical(Obj_idx),logical(scrambled_idx))=0;
cm2_testo3(logical(EA_intact),logical(scrambled_idx))=0;
cm2_testo3(logical(AA_intact),logical(scrambled_idx))=0;
cm2_testo3(logical(othercond_idx),logical(scrambled_idx))=0;
cm2_testo3(logical(scrambled_idx),logical(Scene_idx))=0;
cm2_testo3(logical(scrambled_idx),logical(Obj_idx))=0;
cm2_testo3(logical(scrambled_idx),logical(EA_intact))=0;
cm2_testo3(logical(scrambled_idx),logical(AA_intact))=0;
cm2_testo3(logical(scrambled_idx),logical(othercond_idx))=0;
%set diagonal back to NaN
cm2_testo3(logical(eye(size(cm2_testo3)))) = NaN;


cm2_testo4 = cm2;% model 4 - categorical scene-"item" (face,body,object)
cm2_testo4(logical(EA_intact),logical(EA_intact))=1;
cm2_testo4(logical(AA_intact),logical(AA_intact))=1;
cm2_testo4(logical(Obj_idx),logical(Obj_idx))=1;
cm2_testo4(logical(EA_intact),logical(AA_intact))=1;
cm2_testo4(logical(EA_intact),logical(Obj_idx))=1;
cm2_testo4(logical(AA_intact),logical(Obj_idx))=1;
cm2_testo4(logical(AA_intact),logical(EA_intact))=1;
cm2_testo4(logical(Obj_idx),logical(EA_intact))=1;
cm2_testo4(logical(Obj_idx),logical(AA_intact))=1;

cm2_testo4(logical(othercond_idx),logical(othercond_idx))=1;

cm2_testo4(logical(othercond_idx),logical(EA_intact))=1;
cm2_testo4(logical(othercond_idx),logical(AA_intact))=1;
cm2_testo4(logical(othercond_idx),logical(Obj_idx))=1;
cm2_testo4(logical(EA_intact),logical(othercond_idx))=1;
cm2_testo4(logical(AA_intact),logical(othercond_idx))=1;
cm2_testo4(logical(Obj_idx),logical(othercond_idx))=1;

cm2_testo4(logical(Scene_idx),logical(Scene_idx))=1;

cm2_testo4(logical(EA_intact),logical(Scene_idx))=-1;
cm2_testo4(logical(AA_intact),logical(Scene_idx))=-1;
cm2_testo4(logical(Obj_idx),logical(Scene_idx))=-1;
cm2_testo4(logical(Scene_idx),logical(EA_intact))=-1;
cm2_testo4(logical(Scene_idx),logical(AA_intact))=-1;
cm2_testo4(logical(Scene_idx),logical(Obj_idx))=-1;
cm2_testo4(logical(othercond_idx),logical(Scene_idx))=-1;
cm2_testo4(logical(Scene_idx),logical(othercond_idx))=-1;

cm2_testo4(logical(scrambled_idx),logical(scrambled_idx))=1;

cm2_testo4(logical(Scene_idx),logical(scrambled_idx))=0;
cm2_testo4(logical(Obj_idx),logical(scrambled_idx))=0;
cm2_testo4(logical(EA_intact),logical(scrambled_idx))=0;
cm2_testo4(logical(AA_intact),logical(scrambled_idx))=0;
cm2_testo4(logical(othercond_idx),logical(scrambled_idx))=0;
cm2_testo4(logical(scrambled_idx),logical(Scene_idx))=0;
cm2_testo4(logical(scrambled_idx),logical(Obj_idx))=0;
cm2_testo4(logical(scrambled_idx),logical(EA_intact))=0;
cm2_testo4(logical(scrambled_idx),logical(AA_intact))=0;
cm2_testo4(logical(scrambled_idx),logical(othercond_idx))=0;
%set diagonal back to NaN
cm2_testo4(logical(eye(size(cm2_testo3)))) = NaN;

testm3 = cm2_testo3(triu(true(size(cm2_testo3)),1));
testm4 = cm2_testo4(triu(true(size(cm2_testo4)),1));

modpredicts = horzcat(testm3,testm4);
%add constant term to modpredicts for valid F and P stats
modpredicts(:,3)=1;%matlab assumes there's a constant column of 1

[modfits.b,bint,r,rint,modfits.stats] = regress(truem,modpredicts);%for this example, run a simple multiple regression.

figure;
subplot(2,2,1), imagesc(cm2_testo1);
title('complex model1')
colormap('jet'); % set the colorscheme
caxis([-1 1])
colorbar; % enable colorbar

subplot(2,2,2), imagesc(cm2_testo2);
title('complex model2')
colormap('jet'); % set the colorscheme
caxis([-1 1])
colorbar; % enable colorbar

subplot(2,2,3), imagesc(cm2_testo3);
title('animate-inanimate')
colormap('jet'); % set the colorscheme
caxis([-1 1])
colorbar; % enable colorbar

subplot(2,2,4), imagesc(cm2_testo4);
title('item-scene')
colormap('jet'); % set the colorscheme
caxis([-1 1])
colorbar; % enable colorbar

end
