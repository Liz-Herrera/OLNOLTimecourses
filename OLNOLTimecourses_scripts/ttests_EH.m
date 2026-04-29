%list of subject IDs
subID = {'s01','s02','s03','s05','s07','s09','s10','s11','s12','s13','s14','s15','s17','s18','s19','s20','s21','s22','s23','s24'}


%LOAD INPUT FILES
dataDir = '/data2/CCONS_TIBtest/RSA_output_files';
cd(dataDir);

for s = 1:numel(subID)

    files = dir(fullfile(dataDir, ['Rcorrs_' subID{s} '*.mat'])); % Find
    %file for this subject 


a{s}=[];
labels{s}=[];

for fi = 1:length(files)
    
    filename = fullfile(files(fi).folder, files(fi).name);
    
 % Load res structure
    S = load(filename);
    
        tok = regexp(filename, 'rsabilat_([^_]+)', 'tokens', 'once');


    roiLabel = tok{1};               % e.g. 'ba2930', 'RSComplex', 'hippo'
    roiPrefix = [roiLabel '_'];      % append underscore
    

    % Extract vector in brackets and map to code
    vec_tok = regexp(filename, '\[(.*?)\]', 'tokens', 'once');


    vec = str2num(vec_tok{1}); %#ok<ST2NM>
    
    vec = round(vec, 4);

    if isequal(vec, [0 0 0.25 0.25 0.25 0.25])
        code = 0;
    elseif isequal(vec, [0 0 0 0 0 0 0 1])
        code = 1;
    elseif isequal(vec, [0 0 0 0 0 0 0 0 1])
        code = 2;
    elseif isequal(vec, [0 0 0 0 0 0 0 0 0 0 0.2 0.2 0.2 0.2 0.2])
        code = 3;

    end
 
      
  
    labels{s}=[labels{s} {['nol_new_early_w_nol_new_early_' tok{1} '_' num2str(code)]}]
        
    a{s}=[a{s} S.res.nol_new_early_w_nol_new_early_mean];
    
     labels{s}=[labels{s} {['nol_new_late_w_nol_new_late_' tok{1} '_' num2str(code)]}]
    a{s}=[a{s} S.res.nol_new_late_w_nol_new_late_mean];
    
    labels{s}=[labels{s} {['ol_new_early_w_ol_new_early_' tok{1} '_' num2str(code)]}]
    a{s}=[a{s} S.res.cue_ol_new_early_w_cue_ol_new_early_mean];
  
    labels{s}=[labels{s} {['ol_new_late_w_ol_new_late_' tok{1} '_' num2str(code)]}]
    a{s}=[a{s} S.res.cue_ol_new_late_w_cue_ol_new_late_mean];
    
    labels{s}=[labels{s} {['ol_new_early_w_nol_new_early_' tok{1} '_' num2str(code)]}]
    a{s}=[a{s} S.res.ol_new_early_w_nol_new_early_mean];
    
     labels{s}=[labels{s} {['ol_new_late_w_nol_new_late_' tok{1} '_' num2str(code)]}]
    a{s}=[a{s} S.res.ol_new_late_w_nol_new_late_mean];
    
    labels{s}=[labels{s} {['ol_new_early_w_ol_old_early_' tok{1} '_' num2str(code)]}]
    a{s}=[a{s} S.res.ol_new_early_w_ol_old_early_mean];
    
     labels{s}=[labels{s} {['ol_new_late_w_ol_old_late_' tok{1} '_' num2str(code)]}]
    a{s}=[a{s} S.res.ol_new_late_w_ol_old_late_mean];
end


end

finalmatrix = vertcat(a{:}); %"concatenates" all the subjects' values from each of their cell array cells into just one matrix (stacks each subject below the last one)


save('merged_rsa_data.mat', 'finalmatrix', 'labels')




