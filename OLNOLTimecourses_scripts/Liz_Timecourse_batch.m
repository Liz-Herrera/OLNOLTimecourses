function Liz_Timecourse_batch(subj_id)%basepath,subID,conds,modelname,bin_size,fir_length,numroi)
%
% script for extracting FIR timecourses from MTL subfields
% Usage: % Liz_Timecourse_batch({'s01','s02','s03'}) <- this example will
% loop through the 3 subjects identified in that cell array
%
% last modified 05/02/09 j.chen - improved var passing, dir construction and file naming
% edited for MCI 12/12/11 by vc
% to run, SPM must be launched, and MARSBAR loaded

% note for Liz: the data are on the brown_lab server, so you
% have to connect to the server first (see wiki) for this script to work

%Study name
S.exp_name = '/run/user/3368316/gvfs/smb-share:server=cedar-cos.nas.gatech.edu,share=cos-lab-tbrown338/COSPALCONS_QH/Subject/'; %change this to flexibly redirect the script to folders for different studies

%Lis of subjects included on this TC analysis (ie run this command):
%Liz_Timecourse_batch({'s01','s02','s03','s07','s05','s09','s10','s11','s12','s13','s14','s15''s17','s18','s19','s20','s21','s22','s23','s24'})
%

for sub = 1:length(subj_id)
    
    %Subname
    S.subj_id = [subj_id{sub}];
    
    %% directories~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    S.expt_dir = [S.exp_name '/'];%main expt dir
    par.subdir =[S.expt_dir S.subj_id];%subject's directory
    %S.mvpa_dir = [par.subdir '/Models_FIR/'];%subject's dir containing SPM.mat and onsets.mat model file (if different directories, edit accordingly)
     S.mvpa_dir = [par.subdir '/1st_lvl_early_late_EH/'];
    %par.funcdir =[par.subdir ];%subject's dir containing bold images
    %S.tcdir =[S.expt_dir 'FIR_timecourses/Liz_analyses/'];%directory to write timecourses for all subs to
    S.tcdir =['/data2/CCONS_TIBtest/grp_indiv_timecourses'];%directory to write timecourses for all subs to
    
    
    
    data2Dir = '/data2/CCONS_TIBtest' %variable for the model specification path
    %% Study params
    %ROI file name - optional, current code loops over all ROIs (see line 64)
    %roi_name = 'HVisCtx_1.nii';  % name of mask to be used for voxel selection (can be a small ROI, a whole-brain mask, or anywhere in between)
    
    %% model information
    S.onsets_filename = [S.subj_id '_early_late_model_specification'];%['model_specification.mat'];%name of onsets.mat model file
    % load in onsets.mat file used for model spec
    onsetsmat = [data2Dir '/' S.onsets_filename];
    load(onsetsmat);
    
    
    % Bin size in seconds for FIR (usually use TR)
    bin_size = 2;
    
    
    % Length of FIR in seconds
    fir_length = 30;
    
    
    roipath = ['/data2/CCONS_TIBtest/MNImasks/'];
    
    % make new Timecourses dir
    tcpath0 = fullfile(par.subdir,'/timecourses');
    if ~exist(tcpath0,'dir')
        mkdir(tcpath0);
    end
    
    tcpathUse = S.tcdir;
    
    
    cd(roipath);
    
    %% import ROIs (nii) into marsbar (mat)
    rlist = dir('*.nii');
    rpaths = cat(2,char(rlist(:).name));
    P = [repmat(roipath,size(rpaths,1),1) rpaths];
    for ii=1:size(P,1)
        fprintf(1,'Importing cluster %d to MarsBar\n',ii);
        tmp_str= sprintf('marsROI_clust%d',ii);
        mars_img2rois(P(ii,:),pwd,tmp_str,'i');
    end
    
    % marsROI_clust*.mat files are created. rename these with roi names.
    clist = dir('marsROI_clust*.mat');
    if length(clist) ~= length(rlist)
        fprintf('Warning: incorrect number of marsROI*.mat files found. Aborting in 5s.\n');
        pause(5);
        return
    end
    for n = 1:length(rlist)
        movefile(['marsROI_clust' num2str(n) '_1_roi.mat'],[rlist(n).name(1:end-3) 'mat']);
        nlist(n).name = [rlist(n).name(1:end-3) 'mat'];
    end
    cpaths = cat(2,char(nlist(:).name));
    % cpathsOrig = cpaths; % hack for dealing with old SPM.mat files
    cpathsUse = cpaths; % hack for dealing with old SPM.mat files
    clusters = [repmat(roipath,size(cpaths,1),1) cpaths];
    % clustersOrig = clusters; % hack for dealing with old SPM.mat files
    clustersUse = clusters; % hack for dealing with old SPM.mat files
    
    %% extract timecourses
    
    fprintf(1,'extracting TC from subject %s\n',S.subj_id);
    spm_name = fullfile(S.mvpa_dir,'SPM.mat');
    load(spm_name);
    % cpaths = cpathsOrig;
    % clusters = clustersOrig;
    cpaths = cpathsUse;
    clusters = clustersUse;
    tcpath = tcpathUse;
    
    D  = mardo(spm_name);
    D = autocorr(D,'fmristat',2); % added at jesse rissman's suggestion (see email 5/11/09)
    % > For those who are interest in speeding up their marsbar ROI time
    % > extraction, here's a single line of code that will make your script
    % > run over 5x faster.
    % >
    % > In your marsbar batch script, just add the following line of code:
    % > D = autocorr(D,'fmristat',2);
    % >
    % > This should go directly after this line of code:  D  =
    % > mardo(spm_name);
    % >
    % > What this does is to switch the autocorrelation estimation to use
    % > Keith Worsely's fmristat instead of SPM's more computationally
    % > intensive REML algorithm.  With this switch, extracting one
    % > subject's timecourses takes 8 seconds instead of 43 seconds, so
    % > you'll save loads of time when batching across many subjects and ROIs.
    % >
    % > While the timecourses you get will not be exactly identical to those
    % > you'd get using REML,they're correlated at over r = .99, and so
    % > their essentially the same data. the only place where you'll see these two methods
    % >diverge in any noticeable way is for conditions that have very very
    % >few trials, or otherwise have very noisy data.
    % >
    % > Here's a link to Matthew Brett's marsbar FAQ about this switch:  http://marsbar.sourceforge.net/faq.html#fmristat
    
    for curr_clust=1:size(clusters,1) % go through the list of ROIs
        % Make marsbar design object
        roi_file = clusters(curr_clust,:);
        
        % Make marsbar ROI object
        R  = maroi(roi_file);
        
        % Fetch data into marsbar data object
        Y  = get_marsy(R, D, 'mean');
        
        %get summary raw time course(s)
        rawtc  = summary_data(Y);
        meanraw = mean(rawtc);
        
        % Get contrasts from original design
        xCon = get_contrasts(D);
        
        % Estimate design on ROI data
        E = estimate(D, Y);
        
        % Get definitions of all events in model
        [e_specs, e_names] = event_specs(E);
        n_events = size(e_specs, 2);
        
        
        % Number of FIR time bins to cover length of FIR
        bin_no = fir_length / bin_size;%should typically = desired TR time window
        
        %% FIR TC data
        % Options for FIR - here 'single' FIR model, return estimated % signal change
        opts = struct('single', 1, 'percent', 1);
        
        % Return FIR time courses for all events in fir_tc matrix
        clear fir_tc;
        for e_s = 1:n_events
            fir_tc(:, e_s) = event_fitted_fir(E, e_specs(:,e_s), bin_size, ...
                bin_no, opts);
        end
        subjects_tc.clusters{curr_clust} = fir_tc;
        
    end % end clusters loop
    
    subjects_tc.e_specs = e_specs;
    subjects_tc.e_names = e_names;
    subjects_tc.n_events = n_events;
    
    %% RAW TC data
    % create logical indices, by condition, of TRs (BOLD images) corresponding
    % to our onsets
    num_conds = size(onsets,2);
    
    all_onsets = zeros(num_conds,length(rawtc));%size(raw_filenames{end},2)); % initialize all_onsets matrix as conditions x timepoints
    
    for cond = 1:num_conds
        for trial = 1: length(onsets{cond})
            time_idx = floor(onsets{cond}(trial)/2)+1; % convert onsets into TRs. divide by 2 and add 1 to convert back from sec to TRs (first timepoint = 0 sec; first TR = 1)
            all_onsets(cond,time_idx) = 1;
        end
    end
    
    
    
    % create numerical indices, by condition, of TRs
    for z = 1:length(all_onsets(:,1))
        indices{z,1} = find(all_onsets(z,:));
    end
    
    
    %% Bin data for each condition!
    for x = 1:num_conds
        for y = 1:length(indices{x})
            %if statemnt is a stupid hack to skip trials where time window exceeds the number
            %of TRs (i.e., if the b you calculated or hard-coded pushes the
            %time window for the last trial beyond TRs acquired).
            %The other option is to ensure your b is small enough this is never
            %and issue - but this MAY only work in cases where your trials have
            %a fixed or similar length. Mine vary SIGNIFICANTLY in duration, so
            %I have no appealing options
            if (indices{x}(y)+bin_no) <= length(rawtc)
                limit = ((indices{x}(y))-1+(bin_no-1));
                condtc{x,1}(:,y) = rawtc((indices{x}(y))-1:limit);%build an array of matrices, where each cell contains a (time_window,trial_#) matrix. NOTE: I am subtracting 1 from indices{x}(y) because I am manually shifting my time-window 1TR back. This is specific to me, and you likely want to remove the 1.
            end
        end
    end
    %convert raw, condition-binned values into percent signal change from
    %the scaled data (positive values = increase, negative = decrease)
    for el = 1:length(condtc)
        condtc2{el,1} = ((condtc{el}/meanraw)*100)-100 
    end
    
    
    %% Compute average RAW timecourses for each condition
    for x = 1:num_conds
        condtc_mean_bycond(:,x) = mean(condtc2{x}.');%build an array of matrices, where each cell contains a timewindow*trial# matrix. Each row corresponds to your regressors (in order)
    end
    
    %% Save results
    if ~(exist(S.tcdir))
        mkdir(S.tcdir);
    end
    
    S.saveName = [S.subj_id '_early_late_TC.mat'];
    save (fullfile(S.tcdir, S.saveName), 'subjects_tc','condtc_mean_bycond');
    
end
end


