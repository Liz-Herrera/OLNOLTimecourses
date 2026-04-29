%plot key
% 'bilat_RSComplex.nii';
% 'bilat_ba2930.nii';
% 'bilat_hippo.nii';
% 'rbilat_NAcc.nii';
% 'rbilat_caudate.nii';
% 'rbilat_putamen.nii'

plot_individual_tcs = 0; %1 means yes

cd('/data2/CCONS_TIBtest/')

sub_id = {'s01','s02','s03','s05','s07','s09','s10','s11','s12','s13','s14','s15','s17','s18','s19','s20','s21','s22','s23','s24'};

for s = 1:length(sub_id)
    
    load([sub_id{s} '_TC'])

for i = 1:length(subjects_tc.clusters)
    
    
%    figure
%    hold on
%    new_nol_fr = plot(subjects_tc.clusters{1,i}(:,1),'Color',[0, 0.4470, 0.7410]);
%    new_nol_fa = plot(subjects_tc.clusters{1,i}(:,2),'Color',[0, 0, 1]);
%    new_ol_fr = plot(subjects_tc.clusters{1,i}(:,3),'Color',[0.4660, 0.6740, 0.1880]);
%    new_ol_fa = plot(subjects_tc.clusters{1,i}(:,4),'Color',[0, 0.5, 0]);   
%    old_nol_fr = plot(subjects_tc.clusters{1,i}(:,5),'Color',[0.6350, 0.0780, 0.1840]);
%    old_nol_fa = plot(subjects_tc.clusters{1,i}(:,6),'Color',[1, 0, 0]);
%    old_ol_fr = plot(subjects_tc.clusters{1,i}(:,7),'Color',[0.4940, 0.1840, 0.5560]);
%    old_ol_fa = plot(subjects_tc.clusters{1,i}(:,8),'Color',[0.75, 0, 0.75]);
%    legend('new_nol_fr', 'new_nol_fa', 'new_ol_fr', 'new_ol_fa', 'old_nol_fr', 'old_nol_fa', 'old_ol_fr', 'old_ol_fa','Location','eastoutside')
%    hold off
%    
%    figure
%    hold on
%    fs = .5; % sample frequency
%    n = length(subjects_tc.clusters{1,i}(:,1)); % number of samples
%    f = (0:n-1)*(fs/n); % frequency range
%    y = fft(subjects_tc.clusters{1,i}(:,1));
%    power = abs(y).^2/n;
%    plot(f,power,'Color',[0, 0.4470, 0.7410])
%    
%       y = fft(subjects_tc.clusters{1,i}(:,2));
%    power = abs(y).^2/n;
%    plot(f,power,'Color',[0, 0, 1])
%    
%       y = fft(subjects_tc.clusters{1,i}(:,3));
%    power = abs(y).^2/n;   y = fft(subjects_tc.clusters{1,1}(:,1));
%    power = abs(y).^2/n;
%    plot(f,power,'Color',[0.4660, 0.6740, 0.1880])
%    
%       y = fft(subjects_tc.clusters{1,i}(:,4));
%    power = abs(y).^2/n;
%    plot(f,power,'Color',[0, 0.5, 0])
%    
%       y = fft(subjects_tc.clusters{1,i}(:,5));
%    power = abs(y).^2/n;
%    plot(f,power,'Color',[0.6350, 0.0780, 0.1840])
%    
%       y = fft(subjects_tc.clusters{1,i}(:,6));
%    power = abs(y).^2/n;
%    plot(f,power,'Color',[1, 0, 0])
%    
%       y = fft(subjects_tc.clusters{1,i}(:,7));
%    power = abs(y).^2/n;
%    plot(f,power,'Color',[0.4940, 0.1840, 0.5560])
%    
%       y = fft(subjects_tc.clusters{1,i}(:,8));
%    power = abs(y).^2/n;
%    plot(f,power,'Color',[0.75, 0, 0.75])
%    
%    xlabel('Frequency')
%    ylabel('Power')
%    legend('new_nol_fr', 'new_nol_fa', 'new_ol_fr', 'new_ol_fa', 'old_nol_fr', 'old_nol_fa', 'old_ol_fr', 'old_ol_fa','Location','eastoutside')
%    hold off
  
   %% plot typical OL vs NOL
   
   %means per individual/subject (not group means)

   indiv_mean_new_ol{s}{i} = mean(horzcat(subjects_tc.clusters{1,i}(:,3),subjects_tc.clusters{1,i}(:,4))')';%e.g.(:,3)represents the average across goals of the same category (e.g.fruits)
   indiv_mean_new_nol{s}{i} = mean(horzcat(subjects_tc.clusters{1,i}(:,1),subjects_tc.clusters{1,i}(:,2))')';
   
   indiv_mean_old_ol{s}{i} = mean(horzcat(subjects_tc.clusters{1,i}(:,7),subjects_tc.clusters{1,i}(:,8))')';
   indiv_mean_old_nol{s}{i} = mean(horzcat(subjects_tc.clusters{1,i}(:,5),subjects_tc.clusters{1,i}(:,6))')';

   if plot_individual_tcs == 1
   figure
   hold on
   
   plot(indiv_mean_new_ol{s}{i},'g')
   plot(indiv_mean_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
   plot(indiv_mean_old_ol{s}{i},'r')
   plot(indiv_mean_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
   legend('new_ol','new_nol','old_ol','old_nol')   
   hold off
   end
   
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
   
end
end

%% new_nol
%GROUP MEAN (opposed to individual mean)
roi1 = [];
roi2 = [];
roi3 = [];
roi4 = [];
roi5 = [];
roi6 = [];

for sub = 1:length(indiv_mean_new_nol)
    roi1 = [roi1 indiv_mean_new_nol{sub}{1}];
    roi2 = [roi2 indiv_mean_new_nol{sub}{2}];
    roi3 = [roi3 indiv_mean_new_nol{sub}{3}];
    roi4 = [roi4 indiv_mean_new_nol{sub}{4}];
    roi5 = [roi5 indiv_mean_new_nol{sub}{5}];
    roi6 = [roi6 indiv_mean_new_nol{sub}{6}];
                 
end
res.grp_mean_roi1_new_nol = mean(roi1'); % note the ' "transposes" the roi1 matrix - this changes whether we averaged within column vs rows
res.grp_stderr_roi1_new_nol = std(roi1')/sqrt(length(indiv_mean_new_nol));
res.grp_mean_roi2_new_nol = mean(roi2'); 
res.grp_stderr_roi2_new_nol = std(roi2')/sqrt(length(indiv_mean_new_nol));
res.grp_mean_roi3_new_nol = mean(roi3'); 
res.grp_stderr_roi3_new_nol = std(roi3')/sqrt(length(indiv_mean_new_nol));
res.grp_mean_roi4_new_nol = mean(roi4'); 
res.grp_stderr_roi4_new_nol = std(roi4')/sqrt(length(indiv_mean_new_nol));
res.grp_mean_roi5_new_nol = mean(roi5'); 
res.grp_stderr_roi5_new_nol = std(roi5')/sqrt(length(indiv_mean_new_nol));
res.grp_mean_roi6_new_nol = mean(roi6'); 
res.grp_stderr_roi6_new_nol = std(roi6')/sqrt(length(indiv_mean_new_nol));


%% old_nol
roi1 = [];
roi2 = [];
roi3 = [];
roi4 = [];
roi5 = [];
roi6 = [];

for sub = 1:length(indiv_mean_new_nol)
    roi1 = [roi1 indiv_mean_old_nol{sub}{1}];
    roi2 = [roi2 indiv_mean_old_nol{sub}{2}];
    roi3 = [roi3 indiv_mean_old_nol{sub}{3}];
    roi4 = [roi4 indiv_mean_old_nol{sub}{4}];
    roi5 = [roi5 indiv_mean_old_nol{sub}{5}];
    roi6 = [roi6 indiv_mean_old_nol{sub}{6}];
                 
end
res.grp_mean_roi1_old_nol = mean(roi1'); % note the ' "transposes" the roi1 matrix - this changes whether we averaged within column vs rows
res.grp_stderr_roi1_old_nol = std(roi1')/sqrt(length(indiv_mean_old_nol));
res.grp_mean_roi2_old_nol = mean(roi2'); 
res.grp_stderr_roi2_old_nol = std(roi2')/sqrt(length(indiv_mean_old_nol));
res.grp_mean_roi3_old_nol = mean(roi3'); 
res.grp_stderr_roi3_old_nol = std(roi3')/sqrt(length(indiv_mean_old_nol));
res.grp_mean_roi4_old_nol = mean(roi4'); 
res.grp_stderr_roi4_old_nol = std(roi4')/sqrt(length(indiv_mean_old_nol));
res.grp_mean_roi5_old_nol = mean(roi5'); 
res.grp_stderr_roi5_old_nol = std(roi5')/sqrt(length(indiv_mean_old_nol));
res.grp_mean_roi6_old_nol = mean(roi6'); 
res.grp_stderr_roi6_old_nol = std(roi6')/sqrt(length(indiv_mean_old_nol));



%% new ol

roi1 = [];
roi2 = [];
roi3 = [];
roi4 = [];
roi5 = [];
roi6 = [];

for sub = 1:length(indiv_mean_new_ol)
    roi1 = [roi1 indiv_mean_new_ol{sub}{1}];
    roi2 = [roi2 indiv_mean_new_ol{sub}{2}];
    roi3 = [roi3 indiv_mean_new_ol{sub}{3}];
    roi4 = [roi4 indiv_mean_new_ol{sub}{4}];
    roi5 = [roi5 indiv_mean_new_ol{sub}{5}];
    roi6 = [roi6 indiv_mean_new_ol{sub}{6}];
                 
end
res.grp_mean_roi1_new_ol = mean(roi1'); % note the ' "transposes" the roi1 matrix - this changes whether we averaged within column vs rows
res.grp_stderr_roi1_new_ol = std(roi1')/sqrt(length(indiv_mean_new_ol));
res.grp_mean_roi2_new_ol = mean(roi2'); 
res.grp_stderr_roi2_new_ol = std(roi2')/sqrt(length(indiv_mean_new_ol));
res.grp_mean_roi3_new_ol = mean(roi3'); 
res.grp_stderr_roi3_new_ol = std(roi3')/sqrt(length(indiv_mean_new_ol));
res.grp_mean_roi4_new_ol = mean(roi4'); 
res.grp_stderr_roi4_new_ol = std(roi4')/sqrt(length(indiv_mean_new_ol));
res.grp_mean_roi5_new_ol = mean(roi5'); 
res.grp_stderr_roi5_new_ol = std(roi5')/sqrt(length(indiv_mean_new_ol));
res.grp_mean_roi6_new_ol = mean(roi6'); 
res.grp_stderr_roi6_new_ol = std(roi6')/sqrt(length(indiv_mean_new_ol));


%% old ol

roi1 = [];
roi2 = [];
roi3 = [];
roi4 = [];
roi5 = [];
roi6 = [];

for sub = 1:length(indiv_mean_new_ol)
    roi1 = [roi1 indiv_mean_old_ol{sub}{1}];
    roi2 = [roi2 indiv_mean_old_ol{sub}{2}];
    roi3 = [roi3 indiv_mean_old_ol{sub}{3}];
    roi4 = [roi4 indiv_mean_old_ol{sub}{4}];
    roi5 = [roi5 indiv_mean_old_ol{sub}{5}];
    roi6 = [roi6 indiv_mean_old_ol{sub}{6}];
                 
end
res.grp_mean_roi1_old_ol = mean(roi1'); % note the ' "transposes" the roi1 matrix - this changes whether we averaged within column vs rows
res.grp_stderr_roi1_old_ol = std(roi1')/sqrt(length(indiv_mean_old_ol));
res.grp_mean_roi2_old_ol = mean(roi2'); 
res.grp_stderr_roi2_old_ol = std(roi2')/sqrt(length(indiv_mean_old_ol));
res.grp_mean_roi3_old_ol = mean(roi3'); 
res.grp_stderr_roi3_old_ol = std(roi3')/sqrt(length(indiv_mean_old_ol));
res.grp_mean_roi4_old_ol = mean(roi4'); 
res.grp_stderr_roi4_old_ol = std(roi4')/sqrt(length(indiv_mean_old_ol));
res.grp_mean_roi5_old_ol = mean(roi5'); 
res.grp_stderr_roi5_old_ol = std(roi5')/sqrt(length(indiv_mean_old_ol));
res.grp_mean_roi6_old_ol = mean(roi6'); 
res.grp_stderr_roi6_old_ol = std(roi6')/sqrt(length(indiv_mean_old_ol));


%% plot grp mean timecourses

% %retro compl
%    figure
%    hold on
%    
%    %plot(res.grp_mean_roi1_new_ol{s}{i},'g')
%    errorbar(res.grp_mean_roi1_new_ol,res.grp_stderr_roi1_new_ol,'g', 'LineWidth', 2)
%    %plot(res.grp_mean_roi1_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    errorbar(res.grp_mean_roi1_new_nol,res.grp_stderr_roi1_new_nol,'Color',[0.4660 0.6740 0.1880],'LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_ol{s}{i},'r')
%    errorbar(res.grp_mean_roi1_old_ol,res.grp_stderr_roi1_old_ol, 'r','LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
%    errorbar(res.grp_mean_roi1_old_nol,res.grp_stderr_roi1_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08]) %it sets the upper and lowers bold values
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_ol','new_nol','old_ol','old_nol','Location','eastoutside')
%    title('Retrosplenial Complex')
%    hold off
% 
%  %anatomical RSC
%    figure
%    hold on
%    
%    %plot(res.grp_mean_roi2_new_ol{s}{i},'g')
%    errorbar(res.grp_mean_roi2_new_ol,res.grp_stderr_roi2_new_ol,'g', 'LineWidth', 2)
%    %plot(res.grp_mean_roi1_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    errorbar(res.grp_mean_roi2_new_nol,res.grp_stderr_roi2_new_nol,'Color',[0.4660 0.6740 0.1880],'LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_ol{s}{i},'r')
%    errorbar(res.grp_mean_roi2_old_ol,res.grp_stderr_roi2_old_ol, 'r','LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
%    errorbar(res.grp_mean_roi2_old_nol,res.grp_stderr_roi2_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_ol','new_nol','old_ol','old_nol','Location','eastoutside')
%    title('Anatomical RSC')
%    hold off
% 
%    %hipp
%    figure
%    hold on
%    
%    %plot(res.grp_mean_roi1_new_ol{s}{i},'g')
%    errorbar(res.grp_mean_roi3_new_ol,res.grp_stderr_roi3_new_ol,'g', 'LineWidth', 2)
%    %plot(res.grp_mean_roi1_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    errorbar(res.grp_mean_roi3_new_nol,res.grp_stderr_roi3_new_nol,'Color',[0.4660 0.6740 0.1880],'LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_ol{s}{i},'r')
%    errorbar(res.grp_mean_roi3_old_ol,res.grp_stderr_roi3_old_ol, 'r','LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
%    errorbar(res.grp_mean_roi3_old_nol,res.grp_stderr_roi3_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_ol','new_nol','old_ol','old_nol','Location','eastoutside')
%    title('Hippocampus')
%    hold off
%    
%    %NAcc
%    figure
%    hold on
%    
%    %plot(res.grp_mean_roi1_new_ol{s}{i},'g')
%    errorbar(res.grp_mean_roi4_new_ol,res.grp_stderr_roi4_new_ol,'g', 'LineWidth', 2)
%    %plot(res.grp_mean_roi1_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    errorbar(res.grp_mean_roi4_new_nol,res.grp_stderr_roi4_new_nol,'Color',[0.4660 0.6740 0.1880],'LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_ol{s}{i},'r')
%    errorbar(res.grp_mean_roi4_old_ol,res.grp_stderr_roi4_old_ol, 'r','LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
%    errorbar(res.grp_mean_roi4_old_nol,res.grp_stderr_roi4_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_ol','new_nol','old_ol','old_nol','Location','eastoutside')
%    title('Nucleus Accumbens')
%    hold off
%    
%    %caudate
%    figure
%    hold on
%    
%    %plot(res.grp_mean_roi1_new_ol{s}{i},'g')
%    errorbar(res.grp_mean_roi5_new_ol,res.grp_stderr_roi5_new_ol,'g', 'LineWidth', 2)
%    %plot(res.grp_mean_roi1_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    errorbar(res.grp_mean_roi5_new_nol,res.grp_stderr_roi5_new_nol,'Color',[0.4660 0.6740 0.1880],'LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_ol{s}{i},'r')
%    errorbar(res.grp_mean_roi5_old_ol,res.grp_stderr_roi5_old_ol, 'r','LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
%    errorbar(res.grp_mean_roi5_old_nol,res.grp_stderr_roi5_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_ol','new_nol','old_ol','old_nol','Location','eastoutside')
%    title('Caudate Nucleus')
%    hold off
%    
%    %putamen
%    figure
%    hold on
%    
%    %plot(res.grp_mean_roi1_new_ol{s}{i},'g')
%    errorbar(res.grp_mean_roi6_new_ol,res.grp_stderr_roi6_new_ol,'g', 'LineWidth', 2)
%    %plot(res.grp_mean_roi1_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    errorbar(res.grp_mean_roi6_new_nol,res.grp_stderr_roi6_new_nol,'Color',[0.4660 0.6740 0.1880],'LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_ol{s}{i},'r')
%    errorbar(res.grp_mean_roi6_old_ol,res.grp_stderr_roi6_old_ol, 'r','LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
%    errorbar(res.grp_mean_roi6_old_nol,res.grp_stderr_roi6_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_ol','new_nol','old_ol','old_nol','Location','eastoutside')
%    title('Putamen')
%    hold off
%    
%    
%       %ret complex vs anatomical rsc
%    figure
%    hold on
%    
%    %plot(res.grp_mean_roi1_new_ol{s}{i},'g')
%    errorbar(res.grp_mean_roi1_new_ol,res.grp_stderr_roi1_new_ol,'g', 'LineWidth', 2)
%    %plot(res.grp_mean_roi1_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    errorbar(res.grp_mean_roi2_new_ol,res.grp_stderr_roi2_new_ol,'Color',[0.4660 0.6740 0.1880],'LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_ol{s}{i},'r')
%    %errorbar(res.grp_mean_roi6_old_ol,res.grp_stderr_roi6_old_ol, 'r','LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
%    %errorbar(res.grp_mean_roi6_old_nol,res.grp_stderr_roi6_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_ol_comp','new_ol_anat','Location','eastoutside')
%    title('Ret. Complex vs Anat. RSC')
%    hold off
%    
%     %caudate vs putamen vs NAcc 
%    figure
%    hold on
%    
%    %plot(res.grp_mean_roi1_new_ol{s}{i},'g')
%    errorbar(res.grp_mean_roi4_new_ol,res.grp_stderr_roi4_new_ol,'g', 'LineWidth', 2)
%    %plot(res.grp_mean_roi1_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    errorbar(res.grp_mean_roi5_new_ol,res.grp_stderr_roi5_new_ol,'r','LineWidth', 2)
%    errorbar(res.grp_mean_roi6_new_ol,res.grp_stderr_roi6_new_ol,'b','LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_ol{s}{i},'r')
%    %errorbar(res.grp_mean_roi6_old_ol,res.grp_stderr_roi6_old_ol, 'r','LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
%    %errorbar(res.grp_mean_roi6_old_nol,res.grp_stderr_roi6_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('new_ol_NAcc','new_ol_Caudate','new_ol_Putamen','Location','eastoutside')
%    title('new ol STRIATUM')
%    hold off
%    
%    
%        %caudate vs putamen vs NAcc 
%    figure
%    hold on
%    
%    %plot(res.grp_mean_roi1_new_ol{s}{i},'g')
%    errorbar(res.grp_mean_roi4_old_ol,res.grp_stderr_roi4_old_ol,'g', 'LineWidth', 2)
%    %plot(res.grp_mean_roi1_new_nol{s}{i},'Color',[0.4940 0.1840 0.5560])
%    errorbar(res.grp_mean_roi5_old_ol,res.grp_stderr_roi5_old_ol,'r','LineWidth', 2)
%    errorbar(res.grp_mean_roi6_old_ol,res.grp_stderr_roi6_old_ol,'b','LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_ol{s}{i},'r')
%    %errorbar(res.grp_mean_roi6_old_ol,res.grp_stderr_roi6_old_ol, 'r','LineWidth', 2)
%    %plot(res.grp_mean_roi1_old_nol{s}{i},'Color',[0.6350 0.0780 0.1840])
%    %errorbar(res.grp_mean_roi6_old_nol,res.grp_stderr_roi6_old_nol,'Color',[0.6350 0.0780 0.1840],'LineWidth', 2)
%    %ylim([-0.12 0.08])
%    xticks([0:1:15]) %tickmarks for the TRs
%    legend('old_ol_NAcc','old_ol_Caudate','old_ol_Putamen','Location','eastoutside')
%    title('old ol STRIATUM')
%    hold off

    %NEW OL caudate vs putamen vs NAcc vs hippocampus  (SfN)
   figure
   hold on
   
   errorbar(res.grp_mean_roi3_new_ol,res.grp_stderr_roi3_new_ol,'Color',[1 0.5 0], 'LineWidth', 2)
   errorbar(res.grp_mean_roi4_new_ol,res.grp_stderr_roi4_new_ol,'r', 'LineWidth', 2)
   errorbar(res.grp_mean_roi5_new_ol,res.grp_stderr_roi5_new_ol,'Color',[0, 104, 87] ./ 255, 'LineWidth', 2)
   errorbar(res.grp_mean_roi6_new_ol,res.grp_stderr_roi6_new_ol,'b','LineWidth', 2)
     xticks([0:1:15]) %tickmarks for the TRs
   legend('Hippocampus', 'NAcc','Caudate','Putamen','Location','eastoutside')
   title('New OL HIPPOCAMPUS VS STRIATUM')
   hold off
   
     %NEW NOL caudate vs putamen vs NAcc vs hippocampus  (SfN)
   figure
   hold on
   
   %plot with error bars
   errorbar(res.grp_mean_roi3_new_nol,res.grp_stderr_roi3_new_nol,'Color',[1 0.5 0], 'LineWidth', 2)
   errorbar(res.grp_mean_roi4_new_nol,res.grp_stderr_roi4_new_nol,'r', 'LineWidth', 2)
   errorbar(res.grp_mean_roi5_new_nol,res.grp_stderr_roi5_new_nol,'Color',[0, 104, 87] ./ 255, 'LineWidth', 2)
   errorbar(res.grp_mean_roi6_new_nol,res.grp_stderr_roi6_new_nol,'b','LineWidth', 2)
      %Axes formatting
   xticks([0:1:15]) %tickmarks for the TRs
   legend('Hippocampus', 'NAcc','Caudate','Putamen','Location','eastoutside')
   title('New NOL HIPPOCAMPUS VS STRIATUM')
   
   hold off
   %%%
   
   %NEW OL RSC vs RSComplex vs Hippocampus  (SfN)
    
   figure
   hold on
   
   %plot with error bars
   errorbar(res.grp_mean_roi3_new_ol,res.grp_stderr_roi3_new_ol,'Color',[1 0.5 0], 'LineWidth', 2) %HC
   errorbar(res.grp_mean_roi2_new_ol,res.grp_stderr_roi2_new_ol,'Color', [0.627 0.125 0.941],'LineWidth', 2) %RSC
   errorbar(res.grp_mean_roi1_new_ol,res.grp_stderr_roi1_new_ol,'Color', [0.3 0.5 0.9], 'LineWidth', 2) %RSComplex
   %Axes formatting
   xticks([0:1:15]) %tickmarks for the TRs
    ylim([-0.15 0.1]) % force y-axis limits
   yticks([-0.15 -0.1 -0.05 0 0.05 0.1])
   legend('Hippocampus', 'RSC','RSComplex','Location','eastoutside')
   title('New OL RSC vs RSComplex vs HC')
   hold off
   

   %NEW NOL RSC vs RSComplex vs Hippocampus  (SfN)
    
   figure
   hold on
   
   %plot with error bars
   errorbar(res.grp_mean_roi3_new_nol,res.grp_stderr_roi3_new_nol,'Color',[1 0.5 0], 'LineWidth', 2) %HC
   errorbar(res.grp_mean_roi2_new_nol,res.grp_stderr_roi2_new_nol, 'Color', [0.627 0.125 0.941],'LineWidth', 2) %RSC
   errorbar(res.grp_mean_roi1_new_nol,res.grp_stderr_roi1_new_nol,'Color', [0.3 0.5 0.9],'LineWidth', 2) %RSComplex
   %Axes formatting
   xticks([0:1:15]) %tickmarks for the TRs
   ylim([-0.15 0.1]) % force y-axis limits
   yticks([-0.15 -0.1 -0.05 0 0.05 0.1])
   %yticks([-0.15:0.02:0.1]) % tickmarks for the ROIs signal
   legend('Hippocampus', 'RSC','RSComplex','Location','eastoutside')
   title('New NOL RSC vs RSComplex vs HC')
   hold off
   
   
 save('group_timecourses','res')
 save('indiv_timecourses','indiv_mean_new_nol','indiv_mean_new_ol','indiv_mean_old_nol','indiv_mean_old_ol')
   
   a=[];


