%plot key
% 'bilat_RSComplex.nii';
% 'bilat_ba2930.nii';
% 'bilat_hippo.nii';
% 'rbilat_NAcc.nii';
% 'rbilat_caudate.nii';
% 'rbilat_putamen.nii'

plot_individual_tcs = 0; %1 means yes

cd('/data2/CCONS_TIBtest/grp_indiv_timecourses')

sub_id = {'s01','s02','s03','s05','s07','s09','s10','s11','s12','s13','s14','s15','s17','s18','s19','s20','s21','s22','s23','s24'};

for s = 1:length(sub_id)
    
    load([sub_id{s} '_early_late_TC'])

for i = 1:length(subjects_tc.clusters)
    
    indiv_mean_new_ol_early{s}{i} = (subjects_tc.clusters{1,i}(:,3));
   indiv_mean_new_ol_late{s}{i} = (subjects_tc.clusters{1,i}(:,4));
   
   indiv_mean_new_nol_early{s}{i} = (subjects_tc.clusters{1,i}(:,1)); 
   indiv_mean_new_nol_late{s}{i} = (subjects_tc.clusters{1,i}(:,2));
   
  
%    indiv_mean_old_ol_early{s}{i} = ((subjects_tc.clusters{1,i}(:,7));
%    indiv_mean_old_ol_late{s}{i} = ((subjects_tc.clusters{1,i}(:,8));
%    
%    indiv_mean_old_nol_early{s}{i} = ((subjects_tc.clusters{1,i}(:,5));
%    indiv_mean_old_nol_late{s}{i} = ((subjects_tc.clusters{1,i}(:,6));


   if plot_individual_tcs == 1
   figure
   hold on
   
   plot(indiv_mean_new_ol_early{s}{i},'Color',[116,196,118]) % light green
   plot(indiv_mean_new_ol_late{s}{i},'Color',[44,127,184]) %dark blue-ish
   plot(indiv_mean_new_nol_early{s}{i},'Color',[254,204,92]) %light orange
   plot(indiv_mean_new_nol_late{s}{i},'Color',[189,0,38]) %dark red
   
%    plot(indiv_mean_old_ol{s}{i},'r')
%    plot(indiv_mean_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
%    legend('new_ol','new_nol','old_ol','old_nol')  
   legend('new_ol','new_nol')
   hold off
   end
   
     
end
end

%% new_nol early
%GROUP MEAN (opposed to individual mean)
roi1 = [];
roi2 = [];
roi3 = [];
roi4 = [];
roi5 = [];
roi6 = [];

for sub = 1:length(indiv_mean_new_nol_early)
    roi1 = [roi1 indiv_mean_new_nol_early{sub}{1}];
    roi2 = [roi2 indiv_mean_new_nol_early{sub}{2}];
    roi3 = [roi3 indiv_mean_new_nol_early{sub}{3}];
    roi4 = [roi4 indiv_mean_new_nol_early{sub}{4}];
    roi5 = [roi5 indiv_mean_new_nol_early{sub}{5}];
    roi6 = [roi6 indiv_mean_new_nol_early{sub}{6}];
                 
end
res.grp_mean_roi1_new_nol_early = mean(roi1'); % note the ' "transposes" the roi1 matrix - this changes whether we averaged within column vs rows
res.grp_stderr_roi1_new_nol_early = std(roi1')/sqrt(length(indiv_mean_new_nol_early));
res.grp_mean_roi2_new_nol_early = mean(roi2'); 
res.grp_stderr_roi2_new_nol_early = std(roi2')/sqrt(length(indiv_mean_new_nol_early));
res.grp_mean_roi3_new_nol_early = mean(roi3'); 
res.grp_stderr_roi3_new_nol_early = std(roi3')/sqrt(length(indiv_mean_new_nol_early));
res.grp_mean_roi4_new_nol_early = mean(roi4'); 
res.grp_stderr_roi4_new_nol_early = std(roi4')/sqrt(length(indiv_mean_new_nol_early));
res.grp_mean_roi5_new_nol_early = mean(roi5'); 
res.grp_stderr_roi5_new_nol_early = std(roi5')/sqrt(length(indiv_mean_new_nol_early));
res.grp_mean_roi6_new_nol_early = mean(roi6'); 
res.grp_stderr_roi6_new_nol_early = std(roi6')/sqrt(length(indiv_mean_new_nol_early));


%% new_nol_late
% GROUP MEAN (opposed to individual mean)
roi1 = [];
roi2 = [];
roi3 = [];
roi4 = [];
roi5 = [];
roi6 = [];

for sub = 1:length(indiv_mean_new_nol_late)
    roi1 = [roi1 indiv_mean_new_nol_late{sub}{1}];
    roi2 = [roi2 indiv_mean_new_nol_late{sub}{2}];
    roi3 = [roi3 indiv_mean_new_nol_late{sub}{3}];
    roi4 = [roi4 indiv_mean_new_nol_late{sub}{4}];
    roi5 = [roi5 indiv_mean_new_nol_late{sub}{5}];
    roi6 = [roi6 indiv_mean_new_nol_late{sub}{6}];
                 
end
res.grp_mean_roi1_new_nol_late = mean(roi1'); % note the ' "transposes" the roi1 matrix - this changes whether we averaged within column vs rows
res.grp_stderr_roi1_new_nol_late = std(roi1')/sqrt(length(indiv_mean_new_nol_late));
res.grp_mean_roi2_new_nol_late = mean(roi2'); 
res.grp_stderr_roi2_new_nol_late = std(roi2')/sqrt(length(indiv_mean_new_nol_late));
res.grp_mean_roi3_new_nol_late = mean(roi3'); 
res.grp_stderr_roi3_new_nol_late = std(roi3')/sqrt(length(indiv_mean_new_nol_late));
res.grp_mean_roi4_new_nol_late = mean(roi4'); 
res.grp_stderr_roi4_new_nol_late = std(roi4')/sqrt(length(indiv_mean_new_nol_late));
res.grp_mean_roi5_new_nol_late = mean(roi5'); 
res.grp_stderr_roi5_new_nol_late = std(roi5')/sqrt(length(indiv_mean_new_nol_late));
res.grp_mean_roi6_new_nol_late = mean(roi6'); 
res.grp_stderr_roi6_new_nol_late = std(roi6')/sqrt(length(indiv_mean_new_nol_late));

%% new ol early

roi1 = [];
roi2 = [];
roi3 = [];
roi4 = [];
roi5 = [];
roi6 = [];

for sub = 1:length(indiv_mean_new_ol_early)
    roi1 = [roi1 indiv_mean_new_ol_early{sub}{1}];
    roi2 = [roi2 indiv_mean_new_ol_early{sub}{2}];
    roi3 = [roi3 indiv_mean_new_ol_early{sub}{3}];
    roi4 = [roi4 indiv_mean_new_ol_early{sub}{4}];
    roi5 = [roi5 indiv_mean_new_ol_early{sub}{5}];
    roi6 = [roi6 indiv_mean_new_ol_early{sub}{6}];
                 
end
res.grp_mean_roi1_new_ol_early = mean(roi1'); % note the ' "transposes" the roi1 matrix - this changes whether we averaged within column vs rows
res.grp_stderr_roi1_new_ol_early = std(roi1')/sqrt(length(indiv_mean_new_ol_early));
res.grp_mean_roi2_new_ol_early = mean(roi2'); 
res.grp_stderr_roi2_new_ol_early = std(roi2')/sqrt(length(indiv_mean_new_ol_early));
res.grp_mean_roi3_new_ol_early = mean(roi3'); 
res.grp_stderr_roi3_new_ol_early = std(roi3')/sqrt(length(indiv_mean_new_ol_early));
res.grp_mean_roi4_new_ol_early = mean(roi4'); 
res.grp_stderr_roi4_new_ol_early = std(roi4')/sqrt(length(indiv_mean_new_ol_early));
res.grp_mean_roi5_new_ol_early = mean(roi5'); 
res.grp_stderr_roi5_new_ol_early = std(roi5')/sqrt(length(indiv_mean_new_ol_early));
res.grp_mean_roi6_new_ol_early = mean(roi6'); 
res.grp_stderr_roi6_new_ol_early = std(roi6')/sqrt(length(indiv_mean_new_ol_early));

%% new ol late

roi1 = [];
roi2 = [];
roi3 = [];
roi4 = [];
roi5 = [];
roi6 = [];

for sub = 1:length(indiv_mean_new_ol_late)
    roi1 = [roi1 indiv_mean_new_ol_late{sub}{1}];
    roi2 = [roi2 indiv_mean_new_ol_late{sub}{2}];
    roi3 = [roi3 indiv_mean_new_ol_late{sub}{3}];
    roi4 = [roi4 indiv_mean_new_ol_late{sub}{4}];
    roi5 = [roi5 indiv_mean_new_ol_late{sub}{5}];
    roi6 = [roi6 indiv_mean_new_ol_late{sub}{6}];
                 
end
res.grp_mean_roi1_new_ol_late = mean(roi1'); % note the ' "transposes" the roi1 matrix - this changes whether we averaged within column vs rows
res.grp_stderr_roi1_new_ol_late = std(roi1')/sqrt(length(indiv_mean_new_ol_late));
res.grp_mean_roi2_new_ol_late = mean(roi2'); 
res.grp_stderr_roi2_new_ol_late = std(roi2')/sqrt(length(indiv_mean_new_ol_late));
res.grp_mean_roi3_new_ol_late = mean(roi3'); 
res.grp_stderr_roi3_new_ol_late = std(roi3')/sqrt(length(indiv_mean_new_ol_late));
res.grp_mean_roi4_new_ol_late = mean(roi4'); 
res.grp_stderr_roi4_new_ol_late = std(roi4')/sqrt(length(indiv_mean_new_ol_late));
res.grp_mean_roi5_new_ol_late = mean(roi5'); 
res.grp_stderr_roi5_new_ol_late = std(roi5')/sqrt(length(indiv_mean_new_ol_late));
res.grp_mean_roi6_new_ol_late = mean(roi6'); 
res.grp_stderr_roi6_new_ol_late = std(roi6')/sqrt(length(indiv_mean_new_ol_late));

%% old ol
%we'll have to edit this with early/late

% roi1 = [];
% roi2 = [];
% roi3 = [];
% roi4 = [];
% roi5 = [];
% roi6 = [];
% 
% for sub = 1:length(indiv_mean_new_ol)
%     roi1 = [roi1 indiv_mean_old_ol{sub}{1}];
%     roi2 = [roi2 indiv_mean_old_ol{sub}{2}];
%     roi3 = [roi3 indiv_mean_old_ol{sub}{3}];
%     roi4 = [roi4 indiv_mean_old_ol{sub}{4}];
%     roi5 = [roi5 indiv_mean_old_ol{sub}{5}];
%     roi6 = [roi6 indiv_mean_old_ol{sub}{6}];
%                  
% end
% res.grp_mean_roi1_old_ol = mean(roi1'); % note the ' "transposes" the roi1 matrix - this changes whether we averaged within column vs rows
% res.grp_stderr_roi1_old_ol = std(roi1')/sqrt(length(indiv_mean_old_ol));
% res.grp_mean_roi2_old_ol = mean(roi2'); 
% res.grp_stderr_roi2_old_ol = std(roi2')/sqrt(length(indiv_mean_old_ol));
% res.grp_mean_roi3_old_ol = mean(roi3'); 
% res.grp_stderr_roi3_old_ol = std(roi3')/sqrt(length(indiv_mean_old_ol));
% res.grp_mean_roi4_old_ol = mean(roi4'); 
% res.grp_stderr_roi4_old_ol = std(roi4')/sqrt(length(indiv_mean_old_ol));
% res.grp_mean_roi5_old_ol = mean(roi5'); 
% res.grp_stderr_roi5_old_ol = std(roi5')/sqrt(length(indiv_mean_old_ol));
% res.grp_mean_roi6_old_ol = mean(roi6'); 
% res.grp_stderr_roi6_old_ol = std(roi6')/sqrt(length(indiv_mean_old_ol));


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
    
 %EARLY - NEW OL RSC vs RSComplex vs Hippocampus  (SfN)
figure
 hold on
   
   %plot with error bars
   errorbar(res.grp_mean_roi3_new_ol_early,res.grp_stderr_roi3_new_ol_early,'Color',[0.9100, 0.4100, 0.1700], 'LineWidth', 2) %carrot orange
   errorbar(res.grp_mean_roi2_new_ol_early,res.grp_stderr_roi2_new_ol_early,'Color',[0.5 0 0.5], 'LineWidth', 2) %purple
   errorbar(res.grp_mean_roi1_new_ol_early,res.grp_stderr_roi1_new_ol_early,'Color',[0 0.5 1], 'LineWidth', 2) %medium blue
    
   xticks([0:1:15]) %tickmarks for the TRs
   ylim([-0.15 0.1]) % force y-axis limits
   yticks([-0.15 -0.1 -0.05 0 0.05 0.1])
%    yticks(-0.1:0.02:0.1) % tickmarks for the ROIs signal
%    ylim([-0.1 0.1]) % force y-axis limits
   
   legend('Hippocampus','RSC','RSComplex','Location','eastoutside')
   title('EARLY New OL RSC vs RSComplex vs HC')
   hold off
   
   
   
   %LATE - NEW OL RSC vs RSComplex vs Hippocampus  (SfN)
figure
 hold on
   
   %plot with error bars
   errorbar(res.grp_mean_roi3_new_ol_late,res.grp_stderr_roi3_new_ol_late,'Color',[0.8500, 0.3250, 0.0980], 'LineWidth', 2) %burnt orange 
   errorbar(res.grp_mean_roi2_new_ol_late,res.grp_stderr_roi2_new_ol_late,'Color',[0.75, 0 0.75], 'LineWidth', 2) %violet
   errorbar(res.grp_mean_roi1_new_ol_late,res.grp_stderr_roi1_new_ol_late,'Color',[0, 0.4470, 0.7410], 'LineWidth', 2) %Klein blue 
    
   xticks([0:1:15]) %tickmarks for the TRs
   ylim([-0.15 0.1]) % force y-axis limits
   yticks([-0.15 -0.1 -0.05 0 0.05 0.1])
%    yticks(-0.1:0.02:0.1) % tickmarks for the ROIs signal
%    ylim([-0.1 0.1]) % force y-axis limits

   legend('Hippocampus','RSC','RSComplex','Location','eastoutside')
   title('LATE New OL RSC vs RSComplex vs HC')
   hold off
   

 %% NOL
    
 %EARLY - NEW NOL RSC vs RSComplex vs Hippocampus  (SfN)
figure
 hold on
   
   %plot with error bars
   errorbar(res.grp_mean_roi3_new_nol_early,res.grp_stderr_roi3_new_nol_early,'Color',[0.9100, 0.4100, 0.1700], 'LineWidth', 2) %carrot orange
   errorbar(res.grp_mean_roi2_new_nol_early,res.grp_stderr_roi2_new_nol_early,'Color',[0.5 0 0.5], 'LineWidth', 2) %purple
   errorbar(res.grp_mean_roi1_new_nol_early,res.grp_stderr_roi1_new_nol_early,'Color',[0 0.5 1], 'LineWidth', 2) %medium blue
    
   xticks([0:1:15]) %tickmarks for the TRs
   ylim([-0.15 0.1]) % force y-axis limits
   yticks([-0.15 -0.1 -0.05 0 0.05 0.1])
%    yticks(-0.1:0.02:0.1) % tickmarks for the ROIs signal
%    ylim([-0.1 0.1]) % force y-axis limits

   legend('Hippocampus','RSC','RSComplex','Location','eastoutside')
   title('EARLY New NOL RSC vs RSComplex vs HC')
   hold off
   
   %%%%%%%%%%%%%%%
   
   %LATE - NEW NOL RSC vs RSComplex vs Hippocampus  (SfN)
figure
 hold on
   
   %plot with error bars
   errorbar(res.grp_mean_roi3_new_nol_late,res.grp_stderr_roi3_new_nol_late,'Color',[0.8500, 0.3250, 0.0980], 'LineWidth', 2) %burnt orange 
   errorbar(res.grp_mean_roi2_new_nol_late,res.grp_stderr_roi2_new_nol_late,'Color',[0.75, 0 0.75], 'LineWidth', 2) %violet
   errorbar(res.grp_mean_roi1_new_nol_late,res.grp_stderr_roi1_new_nol_late,'Color',[0, 0.4470, 0.7410], 'LineWidth', 2) %Klein blue 
    
   xticks([0:1:15]) %tickmarks for the TRs
   ylim([-0.15 0.1]) % force y-axis limits
   yticks([-0.15 -0.1 -0.05 0 0.05 0.1])

   legend('Hippocampus','RSC','RSComplex','Location','eastoutside')
   title('LATE New NOL RSC vs RSComplex vs HC')
   hold off

   
   
   
 save('group_timecourses_early-late','res')
 save('indiv_timecourses_early-late','indiv_mean_new_ol_early','indiv_mean_new_nol_early','indiv_mean_new_ol_late','indiv_mean_new_nol_late')
   
   a=[];  
%%%%%%%%%%%%rscomplex
%    figure
%    hold on
%    
%    %plot(res.grp_mean_roi1_new_ol{s}{i},'g')
%    errorbar(res.grp_mean_roi1_new_ol_early,res.grp_stderr_roi1_new_ol_early,'Color',[0.116 0.196 0.118], 'LineWidth', 2)
%    errorbar(res.grp_mean_roi1_new_ol_late,res.grp_stderr_roi1_new_ol_late,'Color',[0.44 0.127 0.184], 'LineWidth', 2)
%    %plot(res.grp_mean_roi1_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    errorbar(res.grp_mean_roi1_new_nol_early,res.grp_stderr_roi1_new_nol_early,'Color',[0.254 0.204 0.92],'LineWidth', 2)
%    errorbar(res.grp_mean_roi1_new_nol_late,res.grp_stderr_roi1_new_nol_late,'Color',[0.189 0 0.38],'LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_ol{s}{i},'r')
% %    errorbar(res.grp_mean_roi1_old_ol,res.grp_stderr_roi1_old_ol, 'r','LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
% %    errorbar(res.grp_mean_roi1_old_nol,res.grp_stderr_roi1_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08]) %it sets the upper and lowers bold values
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_ol_early','new_ol_late','new_nol_early','new_nol_late','Location','eastoutside')
% %    legend('new_ol','new_nol','old_ol','old_nol','Location','eastoutside')
%    title('Retrosplenial Complex')
%    hold off
% 
%  %anatomical RSC
%    figure
%    hold on
%    
%    %plot(res.grp_mean_roi2_new_ol{s}{i},'g')
%     errorbar(res.grp_mean_roi2_new_ol_early,res.grp_stderr_roi2_new_ol_early,'Color',[116,196,118], 'LineWidth', 2)
%    errorbar(res.grp_mean_roi2_new_ol_late,res.grp_stderr_roi2_new_ol_late,'Color',[44,127,184], 'LineWidth', 2)
%    %plot(res.grp_mean_roi2_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    errorbar(res.grp_mean_roi2_new_nol_early,res.grp_stderr_roi2_new_nol_early,'Color',[254,204,92],'LineWidth', 2)
%    errorbar(res.grp_mean_roi2_new_nol_late,res.grp_stderr_roi2_new_nol_late,'Color',[189,0,38],'LineWidth', 2)
%    %plot(res.grp_mean_roi2_old_ol{s}{i},'r')
% %    errorbar(res.grp_mean_roi2_old_ol,res.grp_stderr_roi2_old_ol, 'r','LineWidth', 2)
% %    %plot(res.grp_mean_roi2_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
% %    errorbar(res.grp_mean_roi2_old_nol,res.grp_stderr_roi2_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_ol_early','new_ol_late','new_nol_early','new_nol_late','Location','eastoutside')
% %    legend('new_ol','new_nol','old_ol','old_nol','Location','eastoutside')
%    title('Anatomical RSC')
%    hold off
% 
%    %hipp
%    figure
%    hold on
%    
%    %plot(res.grp_mean_roi3_new_ol{s}{i},'g')
%     errorbar(res.grp_mean_roi3_new_ol_early,res.grp_stderr_roi3_new_ol_early,'Color',[116,196,118], 'LineWidth', 2)
%    errorbar(res.grp_mean_roi3_new_ol_late,res.grp_stderr_roi3_new_ol_late,'Color',[44,127,184], 'LineWidth', 2)
%    %plot(res.grp_mean_roi3_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    errorbar(res.grp_mean_roi3_new_nol_early,res.grp_stderr_roi3_new_nol_early,'Color',[254,204,92],'LineWidth', 2)
%    errorbar(res.grp_mean_roi3_new_nol_late,res.grp_stderr_roi3_new_nol_late,'Color',[189,0,38],'LineWidth', 2)
%    %plot(res.grp_mean_roi3_old_ol{s}{i},'r')
% %    errorbar(res.grp_mean_roi3_old_ol,res.grp_stderr_roi3_old_ol, 'r','LineWidth', 2)
% %    %plot(res.grp_mean_roi3_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
% %    errorbar(res.grp_mean_roi3_old_nol,res.grp_stderr_roi3_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_ol_early','new_ol_late''new_nol_early','new_nol_late','Location','eastoutside')
% %    legend('new_ol','new_nol','old_ol','old_nol','Location','eastoutside')
%    title('Hippocampus')
%    hold off
%    
%    %NAcc
%    figure
%    hold on
%    
%    %plot(res.grp_mean_roi1_new_ol{s}{i},'g')
%     errorbar(res.grp_mean_roi1_new_ol_early,res.grp_stderr_roi4_new_ol_early,'Color',[116,196,118], 'LineWidth', 2)
%    errorbar(res.grp_mean_roi4_new_ol_late,res.grp_stderr_roi4_new_ol_late,'Color',[44,127,184], 'LineWidth', 2)
%    %plot(res.grp_mean_roi4_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    errorbar(res.grp_mean_roi4_new_nol_early,res.grp_stderr_roi4_new_nol_early,'Color',[254,204,92],'LineWidth', 2)
%    errorbar(res.grp_mean_roi4_new_nol_late,res.grp_stderr_roi4_new_nol_late,'Color',[189,0,38],'LineWidth', 2)
%    %plot(res.grp_mean_roi4_old_ol{s}{i},'r')
% %    errorbar(res.grp_mean_roi4_old_ol,res.grp_stderr_roi4_old_ol, 'r','LineWidth', 2)
% %    %plot(res.grp_mean_roi4_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
% %    errorbar(res.grp_mean_roi4_old_nol,res.grp_stderr_roi4_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
% %    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_ol_early','new_ol_late''new_nol_early','new_nol_late','Location','eastoutside')
% %    legend('new_ol','new_nol','old_ol','old_nol','Location','eastoutside')
%    title('Nucleus Accumbens')
%    hold off
%    
%    %caudate
%    figure
%    hold on
%    
%    %plot(res.grp_mean_roi1_new_ol{s}{i},'g')
%    errorbar(res.grp_mean_roi5_new_ol_early,res.grp_stderr_roi5_new_ol_early,'Color',[116,196,118], 'LineWidth', 2)
%    errorbar(res.grp_mean_roi5_new_ol_late,res.grp_stderr_roi5_new_ol_late,'Color',[44,127,184], 'LineWidth', 2)
%    %plot(res.grp_mean_roi5_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    errorbar(res.grp_mean_roi5_new_nol_early,res.grp_stderr_roi5_new_nol_early,'Color',[254,204,92],'LineWidth', 2)
%    errorbar(res.grp_mean_roi5_new_nol_late,res.grp_stderr_roi5_new_nol_late,'Color',[189,0,38],'LineWidth', 2)
%    %plot(res.grp_mean_roi5_old_ol{s}{i},'r')
% %    errorbar(res.grp_mean_roi5_old_ol,res.grp_stderr_roi5_old_ol, 'r','LineWidth', 2)
% %    %plot(res.grp_mean_roi5_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
% %    errorbar(res.grp_mean_roi5_old_nol,res.grp_stderr_roi5_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_ol_early','new_ol_late''new_nol_early','new_nol_late','Location','eastoutside')
% %    legend('new_ol','new_nol','old_ol','old_nol','Location','eastoutside')
%    title('Caudate Nucleus')
%    hold off
%    
%    %putamen
%    figure
%    hold on
%    
%    %plot(res.grp_mean_roi5_new_ol{s}{i},'g')
%    errorbar(res.grp_mean_roi6_new_ol,res.grp_stderr_roi6_new_ol,'g', 'LineWidth', 2)
%    %plot(res.grp_mean_roi5_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    errorbar(res.grp_mean_roi6_new_nol,res.grp_stderr_roi6_new_nol,'Color',[0.4660 0.6740 0.1880],'LineWidth', 2)
%    %plot(res.grp_mean_roi5_old_ol{s}{i},'r')
% %    errorbar(res.grp_mean_roi6_old_ol,res.grp_stderr_roi6_old_ol, 'r','LineWidth', 2)
% %    %plot(res.grp_mean_roi5_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
% %    errorbar(res.grp_mean_roi6_old_nol,res.grp_stderr_roi6_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_ol_early','new_ol_late''new_nol_early','new_nol_late','Location','eastoutside')
% %    legend('new_ol','new_nol','old_ol','old_nol','Location','eastoutside')
%    title('Putamen')
%    hold off
%    
%    
%    %ret complex vs anatomical rsc
%    figure
%    hold on
%    %%OL
%    %plot(res.grp_mean_roi1_new_ol{s}{i},'g')
%    errorbar(res.grp_mean_roi1_new_ol_early,res.grp_stderr_roi1_new_ol_early,'Color',[116,196,118], 'LineWidth', 2)
%    errorbar(res.grp_mean_roi1_new_ol_late,res.grp_stderr_roi1_new_ol_late,'Color',[44,127,184], 'LineWidth', 2)
%    errorbar(res.grp_mean_roi2_new_ol_early,res.grp_stderr_roi2_new_ol_early,'Color',[116,196,118], 'LineWidth', 2)
%    errorbar(res.grp_mean_roi2_new_ol_late,res.grp_stderr_roi2_new_ol_late,'Color',[44,127,184], 'LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_ol{s}{i},'r')
%    %errorbar(res.grp_mean_roi6_old_ol,res.grp_stderr_roi6_old_ol, 'r','LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
%    %errorbar(res.grp_mean_roi6_old_nol,res.grp_stderr_roi6_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_ol_comp_early','new_ol_comp_late','new_ol_anat_early','new_ol_anat_late','Location','eastoutside')
%    title('Ret. Complex vs Anat. RSC')
%    hold off
%    
%    %%NOL
%     figure
%    hold on
%    %plot(res.grp_mean_roi1_new_ol{s}{i},'g')
%    errorbar(res.grp_mean_roi1_new_nol_early,res.grp_stderr_roi1_new_nol_early,'Color',[116,196,118], 'LineWidth', 2)
%    errorbar(res.grp_mean_roi1_new_nol_late,res.grp_stderr_roi1_new_nol_late,'Color',[44,127,184], 'LineWidth', 2)
%    errorbar(res.grp_mean_roi2_new_nol_early,res.grp_stderr_roi2_new_nol_early,'Color',[116,196,118], 'LineWidth', 2)
%    errorbar(res.grp_mean_roi2_new_nol_late,res.grp_stderr_roi2_new_nol_late,'Color',[44,127,184], 'LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_ol{s}{i},'r')
%    %errorbar(res.grp_mean_roi6_old_ol,res.grp_stderr_roi6_old_ol, 'r','LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
%    %errorbar(res.grp_mean_roi6_old_nol,res.grp_stderr_roi6_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_nol_comp_early','new_nol_comp_late','new_nol_anat_early','new_nol_anat_late','Location','eastoutside')
%    title('Ret. Complex vs Anat. RSC')
%    hold off
%    
%     %NAcc vs caudate vs putamen vs 
%     %%OL
%    figure
%    hold on
%    %%NOL
%    %plot(res.grp_mean_roi1_new_ol{s}{i},'g')
%    %errorbar(res.grp_mean_roi4_new_ol,res.grp_stderr_roi4_new_ol,'g', 'LineWidth', 2)
%    errorbar(res.grp_mean_roi4_new_ol_early,res.grp_stderr_roi4_new_ol_early,'Color',[116,196,118], 'LineWidth', 2)
%    errorbar(res.grp_mean_roi4_new_ol_late,res.grp_stderr_roi4_new_ol_late,'Color',[44,127,184], 'LineWidth', 2)
%    errorbar(res.grp_mean_roi5_new_ol_early,res.grp_stderr_roi5_new_ol_early,'Color',[37,37,37], 'LineWidth', 2) %black
%    errorbar(res.grp_mean_roi5_new_ol_late,res.grp_stderr_roi5_new_ol_late,'Color',[150,150,150], 'LineWidth', 2) %gray
%    errorbar(res.grp_mean_roi6_new_ol_early,res.grp_stderr_roi6_new_ol_early,'Color',[140,150,198], 'LineWidth', 2) %purple-blue-ish
%    errorbar(res.grp_mean_roi6_new_ol_late,res.grp_stderr_roi6_new_ol_late,'Color',[129,15,124], 'LineWidth', 2) %purple
%    %plot(res.grp_mean_roi1_old_ol{s}{i},'r')
%    %errorbar(res.grp_mean_roi6_old_ol,res.grp_stderr_roi6_old_ol, 'r','LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
%    %errorbar(res.grp_mean_roi6_old_nol,res.grp_stderr_roi6_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_ol_NAcc_early','new_ol_NAcc_late','new_ol_Caudate_early','new_ol_Caudate_late','new_ol_Putamen_early','new_ol_Putamen_late','Location','eastoutside')
%    title('new ol STRIATUM')
%    hold off
%     
%    figure
%    hold on
%    %%NOL
%    %plot(res.grp_mean_roi1_new_ol{s}{i},'g')
%    %errorbar(res.grp_mean_roi4_new_ol,res.grp_stderr_roi4_new_ol,'g', 'LineWidth', 2)
%    errorbar(res.grp_mean_roi4_new_nol_early,res.grp_stderr_roi4_new_nol_early,'Color',[116,196,118], 'LineWidth', 2)
%    errorbar(res.grp_mean_roi4_new_nol_late,res.grp_stderr_roi4_new_nol_late,'Color',[44,127,184], 'LineWidth', 2)
%    errorbar(res.grp_mean_roi5_new_nol_early,res.grp_stderr_roi5_new_nol_early,'Color',[37,37,37], 'LineWidth', 2) %black
%    errorbar(res.grp_mean_roi5_new_nol_late,res.grp_stderr_roi5_new_nol_late,'Color',[150,150,150], 'LineWidth', 2) %gray
%    errorbar(res.grp_mean_roi6_new_nol_early,res.grp_stderr_roi6_new_nol_early,'Color',[140,150,198], 'LineWidth', 2) %purple-blue-ish
%    errorbar(res.grp_mean_roi6_new_nol_late,res.grp_stderr_roi6_new_nol_late,'Color',[129,15,124], 'LineWidth', 2) %purple
%    %plot(res.grp_mean_roi1_old_ol{s}{i},'r')
%    %errorbar(res.grp_mean_roi6_old_ol,res.grp_stderr_roi6_old_ol, 'r','LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
%    %errorbar(res.grp_mean_roi6_old_nol,res.grp_stderr_roi6_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_nol_NAcc_early','new_nol_NAcc_late','new_nol_Caudate_early','new_nol_Caudate_late','new_nol_Putamen_early','new_nol_Putamen_late','Location','eastoutside')
%    title('new nol STRIATUM')
%    hold off
%    
%    
%        %caudate vs putamen vs NAcc
% %    figure
% %    hold on
% %    
% %    %plot(res.grp_mean_roi1_new_ol{s}{i},'g')
% %    errorbar(res.grp_mean_roi4_old_ol,res.grp_stderr_roi4_old_ol,'g', 'LineWidth', 2)
% %    %plot(res.grp_mean_roi1_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
% %    errorbar(res.grp_mean_roi5_old_ol,res.grp_stderr_roi5_old_ol,'r','LineWidth', 2)
% %    errorbar(res.grp_mean_roi6_old_ol,res.grp_stderr_roi6_old_ol,'b','LineWidth', 2)
% %    %plot(res.grp_mean_roi1_old_ol{s}{i},'r')
% %    %errorbar(res.grp_mean_roi6_old_ol,res.grp_stderr_roi6_old_ol, 'r','LineWidth', 2)
% %    %plot(res.grp_mean_roi1_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
% %    %errorbar(res.grp_mean_roi6_old_nol,res.grp_stderr_roi6_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
% %    %ylim([-0.12 0.08])
% %    xticks([0:1:15]) %tickmarks for the TRs
% %    legend('old_ol_NAcc','old_ol_Caudate','old_ol_Putamen','Location','eastoutside')
% %    title('old ol STRIATUM')
% %    hold off

  %% plot typical OL vs NOL
   
%    means per individual/subject (not group means)
% 
%    indiv_mean_new_ol{s}{i} = mean(horzcat(subjects_tc.clusters{1,i}(:,3),subjects_tc.clusters{1,i}(:,4))')';%e.g.(:,3)represents the average across goals of the same category (e.g.fruits)
%    indiv_mean_new_nol{s}{i} = mean(horzcat(subjects_tc.clusters{1,i}(:,1),subjects_tc.clusters{1,i}(:,2))')'; %here we are clustering the goals (8) fruits and faces
%    
%    indiv_mean_old_ol{s}{i} = mean(horzcat(subjects_tc.clusters{1,i}(:,7),subjects_tc.clusters{1,i}(:,8))')';
%    indiv_mean_old_nol{s}{i} = mean(horzcat(subjects_tc.clusters{1,i}(:,5),subjects_tc.clusters{1,i}(:,6))')';
% 
%    if plot_individual_tcs == 1
%    figure
%    hold on
%    
%    plot(indiv_mean_new_ol{s}{i},'g')
%    plot(indiv_mean_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    plot(indiv_mean_old_ol{s}{i},'r')
%    plot(indiv_mean_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
%    legend('new_ol','new_nol','old_ol','old_nol')   
%    hold off
%    end
%    
   %early-late means per individual/subject (not group means)
   %to know which # [cell] is e.g. ol_new_early and which # is ol_new_late you need to look at the model file  
   %-for early_late - the names order specifies which order the conditions are modeled in
   %in other words, it tells us the order number of ol, nol...etc
   
   %    figure
%    hold on
%    dmean_new_ol{s}{i} = detrend(mean_new_ol{s}{i});
%    dmean_new_nol{s}{i} =  detrend(mean_new_nol{s}{i});
%    
%    dmean_old_ol{s}{i} =  detrend(mean_old_ol{s}{i});
%    dmean_old_nol{s}{i} =  detrend(mean_old_nol{s}{i});
%    plot(dmean_new_ol{s}{i},'g')
%    plot(dmean_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    plot(dmean_old_ol{s}{i},'r')
%    plot(dmean_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
%    ylabel('detrended')
%    legend('new_ol','new_nol','old_ol','old_nol')   
%    hold off
   
   %% plot typical FA vs FR
%    figure
%    hold on
%    mean_new_fr = mean(horzcat(subjects_tc.clusters{1,i}(:,1),subjects_tc.clusters{1,i}(:,3))')';
%    mean_new_fa = mean(horzcat(subjects_tc.clusters{1,i}(:,2),subjects_tc.clusters{1,i}(:,4))')';
%    
%    mean_old_fr = mean(horzcat(subjects_tc.clusters{1,i}(:,5),subjects_tc.clusters{1,i}(:,7))')';
%    mean_old_fa = mean(horzcat(subjects_tc.clusters{1,i}(:,6),subjects_tc.clusters{1,i}(:,8))')';
%    plot(mean_new_fr,'r')
%    plot(mean_new_fa,'b')
%    plot(mean_old_fr,'m')
%    plot(mean_old_fa,'c')
%    legend('new_fr','new_fa','old_fr','old_fa','Location','eastoutside')   
%    hold off 
%    
%       figure
%    hold on
%    mean_new_fr = detrend(mean_new_fr);
%    mean_new_fa =  detrend(mean_new_fa);
%    
%    mean_old_fr =  detrend(mean_old_fr);
%    mean_old_fa =  detrend(mean_old_fa);
%    plot(mean_new_fr,'r')
%    plot(mean_new_fa,'b')
%    plot(mean_old_fr,'m')
%    plot(mean_old_fa,'c')
%    ylabel('detrended')
%    legend('new_fr','new_fa','old_fr','old_fa','Location','eastoutside')   
%    hold off
  %% old_nol
%we'll have to edit this with early-late
% roi1 = [];
% roi2 = [];
% roi3 = [];
% roi4 = [];
% roi5 = [];
% roi6 = [];
% 
% for sub = 1:length(indiv_mean_new_nol)
%     roi1 = [roi1 indiv_mean_old_nol{sub}{1}];
%     roi2 = [roi2 indiv_mean_old_nol{sub}{2}];
%     roi3 = [roi3 indiv_mean_old_nol{sub}{3}];
%     roi4 = [roi4 indiv_mean_old_nol{sub}{4}];
%     roi5 = [roi5 indiv_mean_old_nol{sub}{5}];
%     roi6 = [roi6 indiv_mean_old_nol{sub}{6}];
%                  
% end
% res.grp_mean_roi1_old_nol = mean(roi1'); % note the ' "transposes" the roi1 matrix - this changes whether we averaged within column vs rows
% res.grp_stderr_roi1_old_nol = std(roi1')/sqrt(length(indiv_mean_old_nol));
% res.grp_mean_roi2_old_nol = mean(roi2'); 
% res.grp_stderr_roi2_old_nol = std(roi2')/sqrt(length(indiv_mean_old_nol));
% res.grp_mean_roi3_old_nol = mean(roi3'); 
% res.grp_stderr_roi3_old_nol = std(roi3')/sqrt(length(indiv_mean_old_nol));
% res.grp_mean_roi4_old_nol = mean(roi4'); 
% res.grp_stderr_roi4_old_nol = std(roi4')/sqrt(length(indiv_mean_old_nol));
% res.grp_mean_roi5_old_nol = mean(roi5'); 
% res.grp_stderr_roi5_old_nol = std(roi5')/sqrt(length(indiv_mean_old_nol));
% res.grp_mean_roi6_old_nol = mean(roi6'); 
% res.grp_stderr_roi6_old_nol = std(roi6')/sqrt(length(indiv_mean_old_nol));
%  

 


