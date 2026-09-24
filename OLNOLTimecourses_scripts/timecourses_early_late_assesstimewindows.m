%plot key
% 'bilat_RSComplex.nii';
% 'bilat_ba2930.nii';
% 'bilat_hippo.nii';
% 'rbilat_NAcc.nii';
% 'rbilat_caudate.nii';
% 'rbilat_putamen.nii'

cd('C:\Users\giova\GaTech Dropbox\CoS\Psychology\MAP_Lab\Studies_ONGOING\COSPAL_Timecourses\grp_indiv_timecourses')

sub_id = {'s01','s02','s03','s05','s07','s09','s10','s11','s12','s13','s14','s15','s17','s18','s19','s20','s21','s22','s23','s24'};

for s = 1:length(sub_id)
    
    load([sub_id{s} '_early_late_TC'])

for i = 1:length(subjects_tc.clusters)
    
   %early-late means per individual/subject (not group means)
   %to know which # [cell] is e.g. ol_new_early and which # is ol_new_late you need to look at the model file  
   %-for early_late - the names order specifies which order the conditions are modeled in
   %in other words, it tells us the order number of ol, nol...etc
 
   indiv_mean_new_ol_early{s}{i} = (subjects_tc.clusters{1,i}(:,3));
   indiv_mean_new_ol_late{s}{i} = (subjects_tc.clusters{1,i}(:,4));
   
   indiv_mean_new_nol_early{s}{i} = (subjects_tc.clusters{1,i}(:,1)); 
   indiv_mean_new_nol_late{s}{i} = (subjects_tc.clusters{1,i}(:,2));
     
end
end

%% new_nol early
%GROUP MEAN (opposed to individual mean)
nolearly_roi1 = [];
nolearly_roi2 = [];
nolearly_roi3 = [];
nolearly_roi4 = [];
nolearly_roi5 = [];
nolearly_roi6 = [];

for sub = 1:length(indiv_mean_new_nol_early)
    nolearly_roi1 = [nolearly_roi1 indiv_mean_new_nol_early{sub}{1}];
    nolearly_roi2 = [nolearly_roi2 indiv_mean_new_nol_early{sub}{2}];
    nolearly_roi3 = [nolearly_roi3 indiv_mean_new_nol_early{sub}{3}];
    nolearly_roi4 = [nolearly_roi4 indiv_mean_new_nol_early{sub}{4}];
    nolearly_roi5 = [nolearly_roi5 indiv_mean_new_nol_early{sub}{5}];
    nolearly_roi6 = [nolearly_roi6 indiv_mean_new_nol_early{sub}{6}];
                 
end

%% new_nol_late
% GROUP MEAN (opposed to individual mean)
nollate_roi1 = [];
nollate_roi2 = [];
nollate_roi3 = [];
nollate_roi4 = [];
nollate_roi5 = [];
nollate_roi6 = [];

for sub = 1:length(indiv_mean_new_nol_late)
    nollate_roi1 = [nollate_roi1 indiv_mean_new_nol_late{sub}{1}];
    nollate_roi2 = [nollate_roi2 indiv_mean_new_nol_late{sub}{2}];
    nollate_roi3 = [nollate_roi3 indiv_mean_new_nol_late{sub}{3}];
    nollate_roi4 = [nollate_roi4 indiv_mean_new_nol_late{sub}{4}];
    nollate_roi5 = [nollate_roi5 indiv_mean_new_nol_late{sub}{5}];
    nollate_roi6 = [nollate_roi6 indiv_mean_new_nol_late{sub}{6}];
                 
end

%% new ol early
olearly_roi1 = [];
olearly_roi2 = [];
olearly_roi3 = [];
olearly_roi4 = [];
olearly_roi5 = [];
olearly_roi6 = [];

for sub = 1:length(indiv_mean_new_ol_early)
    olearly_roi1 = [olearly_roi1 indiv_mean_new_ol_early{sub}{1}];
    olearly_roi2 = [olearly_roi2 indiv_mean_new_ol_early{sub}{2}];
    olearly_roi3 = [olearly_roi3 indiv_mean_new_ol_early{sub}{3}];
    olearly_roi4 = [olearly_roi4 indiv_mean_new_ol_early{sub}{4}];
    olearly_roi5 = [olearly_roi5 indiv_mean_new_ol_early{sub}{5}];
    olearly_roi6 = [olearly_roi6 indiv_mean_new_ol_early{sub}{6}];
                 
end


%% new ol late

ollate_roi1 = [];
ollate_roi2 = [];
ollate_roi3 = [];
ollate_roi4 = [];
ollate_roi5 = [];
ollate_roi6 = [];

for sub = 1:length(indiv_mean_new_ol_late)
    ollate_roi1 = [ollate_roi1 indiv_mean_new_ol_late{sub}{1}];
    ollate_roi2 = [ollate_roi2 indiv_mean_new_ol_late{sub}{2}];
    ollate_roi3 = [ollate_roi3 indiv_mean_new_ol_late{sub}{3}];
    ollate_roi4 = [ollate_roi4 indiv_mean_new_ol_late{sub}{4}];
    ollate_roi5 = [ollate_roi5 indiv_mean_new_ol_late{sub}{5}];
    ollate_roi6 = [ollate_roi6 indiv_mean_new_ol_late{sub}{6}];
                 
end

%% calculate timecourse differences from early to late! (late values minus early values for each timepoint)

nol_earlylate_diff_roi1 = nollate_roi1-nolearly_roi1;
nol_earlylate_diff_roi2 = nollate_roi2-nolearly_roi2;
nol_earlylate_diff_roi3 = nollate_roi3-nolearly_roi3;
nol_earlylate_diff_roi4 = nollate_roi4-nolearly_roi4;
nol_earlylate_diff_roi5 = nollate_roi5-nolearly_roi5;
nol_earlylate_diff_roi6 = nollate_roi6-nolearly_roi6;

ol_earlylate_diff_roi1 = ollate_roi1-olearly_roi1;
ol_earlylate_diff_roi2 = ollate_roi2-olearly_roi2;
ol_earlylate_diff_roi3 = ollate_roi3-olearly_roi3;
ol_earlylate_diff_roi4 = ollate_roi4-olearly_roi4;
ol_earlylate_diff_roi5 = ollate_roi5-olearly_roi5;
ol_earlylate_diff_roi6 = ollate_roi6-olearly_roi6;


%% calculate averages of the timecourse differences from early to late
res.grp_mean_roi1_new_nol_diff = mean(nol_earlylate_diff_roi1'); % note the ' "transposes" the roi1 matrix - this changes whether we averaged within column vs rows
res.grp_stderr_roi1_new_nol_diff = std(nol_earlylate_diff_roi1')/sqrt(length(indiv_mean_new_nol_late));
res.grp_mean_roi2_new_nol_diff = mean(nol_earlylate_diff_roi2'); 
res.grp_stderr_roi2_new_nol_diff = std(nol_earlylate_diff_roi2')/sqrt(length(indiv_mean_new_nol_late));
res.grp_mean_roi3_new_nol_diff = mean(nol_earlylate_diff_roi3'); 
res.grp_stderr_roi3_new_nol_diff = std(nol_earlylate_diff_roi3')/sqrt(length(indiv_mean_new_nol_late));
res.grp_mean_roi4_new_nol_diff = mean(nol_earlylate_diff_roi4'); 
res.grp_stderr_roi4_new_nol_diff = std(nol_earlylate_diff_roi4')/sqrt(length(indiv_mean_new_nol_late));
res.grp_mean_roi5_new_nol_diff = mean(nol_earlylate_diff_roi5'); 
res.grp_stderr_roi5_new_nol_diff = std(nol_earlylate_diff_roi5')/sqrt(length(indiv_mean_new_nol_late));
res.grp_mean_roi6_new_nol_diff = mean(nol_earlylate_diff_roi6'); 
res.grp_stderr_roi6_new_nol_diff = std(nol_earlylate_diff_roi6')/sqrt(length(indiv_mean_new_nol_late));


res.grp_mean_roi1_new_ol_diff = mean(ol_earlylate_diff_roi1'); % note the ' "transposes" the roi1 matrix - this changes whether we averaged within column vs rows
res.grp_stderr_roi1_new_ol_diff = std(ol_earlylate_diff_roi1')/sqrt(length(indiv_mean_new_nol_late));
res.grp_mean_roi2_new_ol_diff = mean(ol_earlylate_diff_roi2'); 
res.grp_stderr_roi2_new_ol_diff = std(ol_earlylate_diff_roi2')/sqrt(length(indiv_mean_new_nol_late));
res.grp_mean_roi3_new_ol_diff = mean(ol_earlylate_diff_roi3'); 
res.grp_stderr_roi3_new_ol_diff = std(ol_earlylate_diff_roi3')/sqrt(length(indiv_mean_new_nol_late));
res.grp_mean_roi4_new_ol_diff = mean(ol_earlylate_diff_roi4'); 
res.grp_stderr_roi4_new_ol_diff = std(ol_earlylate_diff_roi4')/sqrt(length(indiv_mean_new_nol_late));
res.grp_mean_roi5_new_ol_diff = mean(ol_earlylate_diff_roi5'); 
res.grp_stderr_roi5_new_ol_diff = std(ol_earlylate_diff_roi5')/sqrt(length(indiv_mean_new_nol_late));
res.grp_mean_roi6_new_ol_diff = mean(ol_earlylate_diff_roi6'); 
res.grp_stderr_roi6_new_ol_diff = std(ol_earlylate_diff_roi6')/sqrt(length(indiv_mean_new_nol_late));

%% plot grp mean timecourses early-late

% new_ol_early 'Color',[116,196,118])light green
% new_ol_late 'Color',[44,127,184]) dark blue-ish
% new_nol_early 'Color',[254,204,92]) light orange
% new_nol_late 'Color',[189,0,38]) dark red
%errorbar(res.grp_mean_roi2_new_nol,res.grp_stderr_roi2_new_nol,'Color',[0.4660 0.6740 0.1880],'LineWidth', 2)

%%%%%%%%%%%%%%%%%%%%
%% ALL TCS

    %color code
    %[0.498 0 1] violet
    %[0.5 0 0.5]  purple
    %[0.471 0.318 0.663] dark purple
    %'Color',[0.8 0.3333 0] burnt orange
    
 %% OL
    
 %Difference from early to late - NEW OL RSC vs RSComplex vs Hippocampus  (SfN)

figure
 hold on
   
   %plot with error bars
   errorbar(res.grp_mean_roi3_new_ol_diff,res.grp_stderr_roi3_new_ol_diff,'Color',[0.8500, 0.3250, 0.0980], 'LineWidth', 2) %burnt orange 
   errorbar(res.grp_mean_roi2_new_ol_diff,res.grp_stderr_roi2_new_ol_diff,'Color',[0.75, 0 0.75], 'LineWidth', 2) %violet
   errorbar(res.grp_mean_roi1_new_ol_diff,res.grp_stderr_roi1_new_ol_diff,'Color',[0, 0.4470, 0.7410], 'LineWidth', 2) %Klein blue 
    
   xticks([0:1:15]) %tickmarks for the TRs
   legend('Hippocampus','RSC','RSComplex','Location','eastoutside')
   title('Late-Early, New OL RSC vs RSComplex vs HC')
   hold off
   
 %%%%%%%%%%%%%%%%%%%%
 %% NOL
    
 %Difference from early to late - NEW NOL RSC vs RSComplex vs Hippocampus  (SfN)

figure
 hold on
   
   %plot with error bars
   errorbar(res.grp_mean_roi3_new_nol_diff,res.grp_stderr_roi3_new_nol_diff,'Color',[0.8500, 0.3250, 0.0980], 'LineWidth', 2) %burnt orange 
   errorbar(res.grp_mean_roi2_new_nol_diff,res.grp_stderr_roi2_new_nol_diff,'Color',[0.75, 0 0.75], 'LineWidth', 2) %violet
   errorbar(res.grp_mean_roi1_new_nol_diff,res.grp_stderr_roi1_new_nol_diff,'Color',[0, 0.4470, 0.7410], 'LineWidth', 2) %Klein blue 
    
   xticks([0:1:15]) %tickmarks for the TRs
   legend('Hippocampus','RSC','RSComplex','Location','eastoutside')
   title('Late-Early, New NOL RSC vs RSComplex vs HC')
   hold off
   
 

%% timecourse learning correlations
% this is a bit like functional connectivity: how does the CHANGE in
% timecourse from early to late in one ROI predict the change in the
% timecourse from early to late in another ROI?

%for example, does a drop in activity from early to late in the beginning
%of the maze predict increase activity in RSC? When?


OL_hippopredicingRSC = corr(ol_earlylate_diff_roi3',ol_earlylate_diff_roi2');
OL_hippopredicingRSC_early = corr(olearly_roi3',olearly_roi2');
OL_hippopredicingRSC_late = corr(ollate_roi3',ollate_roi2');
OL_hippopredicingRSComplex = corr(ol_earlylate_diff_roi3',ol_earlylate_diff_roi1');
OL_hippopredicingRSComplex_early = corr(olearly_roi3',olearly_roi1');
OL_hippopredicingRSComplex_late = corr(ollate_roi3',ollate_roi1');

OL_RSCpredicingRSComplex_early = corr(olearly_roi2',olearly_roi1');
OL_RSCpredicingRSComplex_late = corr(ollate_roi2',ollate_roi1');

%NOL_hippopredicingRSC = corr(nol_earlylate_diff_roi3',nol_earlylate_diff_roi2');
%NOL_hippopredicingRSComplex = corr(nol_earlylate_diff_roi3',nol_earlylate_diff_roi1');

NOL_hippopredicingRSC = corr(nol_earlylate_diff_roi3',nol_earlylate_diff_roi2');
NOL_hippopredicingRSC_early = corr(nolearly_roi3',nolearly_roi2');
NOL_hippopredicingRSC_late = corr(nollate_roi3',nollate_roi2');
NOL_hippopredicingRSComplex = corr(nol_earlylate_diff_roi3',nol_earlylate_diff_roi1');
NOL_hippopredicingRSComplex_early = corr(nolearly_roi3',nolearly_roi1');
NOL_hippopredicingRSComplex_late = corr(nollate_roi3',nollate_roi1');

NOL_RSCpredicingRSComplex_early = corr(nolearly_roi2',nolearly_roi1');
NOL_RSCpredicingRSComplex_late = corr(nollate_roi2',nollate_roi1');


figure
 hold on
   
   %plot with error bars
   imagesc(OL_hippopredicingRSC_early)
   colorbar
      
   title('New OL HC Early correlated with RSC Early')
  hold off

  figure
 hold on
   
   %plot with error bars
   imagesc(OL_hippopredicingRSC_late)
   colorbar
      
   title('New OL HC Late correlated with RSC Late')
  hold off


figure
 hold on
   
   %plot with error bars
   imagesc(OL_hippopredicingRSComplex_early)
   colorbar
      
   title('New OL HC Early correlated with RSComplex Early')
  hold off

  figure
 hold on
   
   %plot with error bars
   imagesc(OL_hippopredicingRSComplex_late)
   colorbar
      
   title('New OL HC Late correlated with RSComplex Late')
  hold off

figure
 hold on
   
   %plot with error bars
   imagesc(OL_RSCpredicingRSComplex_early)
   colorbar
      
   title('New OL RSC Early correlated with RSComplex Early')
  hold off

  figure
 hold on
   
   %plot with error bars
   imagesc(OL_RSCpredicingRSComplex_late)
   colorbar
      
   title('New OL RSC Late correlated with RSComplex Late')
  hold off


   


 save('group_timecourses_early-late','res')
 save('indiv_timecourses_early-late','indiv_mean_new_ol_early','indiv_mean_new_nol_early','indiv_mean_new_ol_late','indiv_mean_new_nol_late')
   
   a=[];


