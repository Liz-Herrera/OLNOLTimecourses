%% visualize weights maps

%% first we pull in the weights across iterations from the results structure
%%plMVPA creates
wt=[]; %temp weights matrix
for i = 1:length(res.subj{1,1}.penalty.nVox.weights.iter{1,1}.iterations(:))
    wt = [wt res.subj{1,1}.penalty.nVox.weights.iter{1,1}.iterations(i).scratchpad.w(:,1)];
end
wtavg = mean(wt');
wtavg = wtavg(1:15);%drop 16th weight - this is some kind of regression term the classifier always adds

%% now start plotting
figure;
hold on
% create a path for visualization of a sample maze (plotting "time" at
% different stages of the maze out pseudo-spatially)
%this example covers a maze of about 22.5s...

%to give illustration of overlap, plot part of a "second maze"
maze2x = [8 5.5 4.5 4.5 5.5  8]; %mark start and end of hallways in SECONDS
maze2y = [9 9   10  12  13.5 13.5]; %mark start and end of hallways in SECONDS
%%%%%%%% cue t h   t   h    t    h    g    <- where cue=planning, t =
%%%%%%%% RT+turn time, h = hallway, g = goal hold
plot(maze2x,maze2y,'Color',[.9 .9 .9],'LineWidth',10,'Marker','x',MarkerSize=20)%,'LineWidth', 10,'--+')


mazex = [0 0 1 3.5 4.5 4.5  3.5  1    -1]; %mark start and end of hallways in SECONDS
mazey = [0 8 9 9   10  12.5 13.5 13.5 13.5]; %mark start and end of hallways in SECONDS
%%%%%%%% cue t h   t   h    t    h    g    <- where cue=planning, t =
%%%%%%%% RT+turn time, h = hallway, g = goal hold
plot(mazex,mazey,'Color',[.7 .7 .7],'LineWidth',10,'Marker','x',MarkerSize=20)%,'LineWidth', 10,'--+')
xlim([-7,7]) %define a space around the maze to center it and give it the right proportions
ylim([0,14])





%create plot of weights at the coorrect locations in time. Since these data
%are in TRs, duplicate them so that they show up every second on the maze plot
Xtime =   [0 0 0 0 1 3 4.237  4.5  3.43 2.43 0.43 -1.57 -3.57 -5.57 -7.57];% *NOTE* odd thing happens at intersections because TRs (2s) might result in the data point "changing direction" 
Ytime =   [2 4 6 8 9 9 10.237 11.5 12.5 13.5 13.5 13.5  13.5  13.5  13.5];% *NOTE* odd thing happens at intersections because TRs (2s) might result in the data point "changing direction"
%Weights = [-0.286287508655218	0	0	0	0	0  	4.13327738879689  1.11834317582607 	7.09086639926002 	0	   -19.3107810184560	-7.41715436364057	 0 	-1.09228553715279	-1.93034051230980]
Weights = wtavg;

%%now shift the weights back 4s (2TRs) - to do this, we delete the LAST two
%%of the X/Y time, and the FIRST two of the Weights
% Xtime =   [0 0 0 0 1 3 4.5 4.5 3.5  1.5  -0.5 -2.5 -4.5];% *NOTE* odd thing happens at intersections because TRs (2s) might result in the data point "changing direction" 
% Ytime =   [2 4 6 8 9 9 10  12  13.5 13.5 13.5 13.5 13.5];% *NOTE* odd thing happens at intersections because TRs (2s) might result in the data point "changing direction"
% Weights = [0	0	0	0  	4.13327738879689  1.11834317582607 	7.09086639926002 	0	   -19.3107810184560	-7.41715436364057	 0 	-1.09228553715279	-1.93034051230980]

%%now shift the weights back 6s (3TRs) - to do this, we delete the LAST
%%three of the X/Y time, and the FIRST three of the Weights
Xtime =   [0 0 0 0 1 3 4.5 4.5 3.5  1.5  -0.5 -2.5];% *NOTE* odd thing happens at intersections because TRs (2s) might result in the data point "changing direction" 
Ytime =   [2 4 6 8 9 9 10  12  13.5 13.5 13.5 13.5];% *NOTE* odd thing happens at intersections because TRs (2s) might result in the data point "changing direction"
Weights = Weights(4:end);



%to enable the point resizing, can't have 0s... replace them
weightsize=Weights;
weightsize(weightsize==0)=0.001;% replaces 0 weights with 0.001 (a "point" in space)

%scatter(Xtime,Ytime,Weights*100,Weights,'filled')
%scatter(Xtime,Ytime,400,Weights,"filled")
%scatter(Xtime,Ytime,a,Weights,'filled')
scatter(Xtime,Ytime,abs(weightsize*100),Weights,'filled');%note for marker size we take absolute value since negative weights exist (but can still be strong vs weak)

%// Add colour bar
colormap('jet')
caxis([-20 20]);
colorbar;