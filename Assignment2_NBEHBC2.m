%% Assignment2: NBEHBC course 
%% Student: Amit K Jaiswal 
%% Date: 04-05-2017
%% Part 1: Example data  (71x71)%%%%%%%%%%%%%%%%
% Load data
load('C:\Users\fijaiami\Documents\MATLAB\BCT\2017_01_15_BCT\data_and_demos\macaque71');
% Adjacency matrix plot
figure('color', [1 1 1])
imagesc(CIJ)
xlabel('Node number')
ylabel('Node number')
title('Adjacency matrix plot')

% Joint degree distribution matrix
[J,J_od,J_id,J_bl] = jdegree(CIJ); 
figure('color', [1 1 1])
imagesc(J);
title('Joint degree distribution matrix')

% Calculate inward and  outward links (Degree)
[id,od,deg2] = degrees_dir(CIJ); 
figure('color', [1 1 1])
subplot(2,1,1); stem(id, 'Linewidth', 1.5);
xlabel('Node number')
ylabel('Number of inward links')
title('Node degree ')
subplot(2,1,2); stem(od,'Linewidth', 1.5);
xlabel('Node number')
ylabel('Number of outward links')
title('Node degree ')

% Clustering & Transitivity
C=clustering_coef_bd(CIJ); % Clustering coeff
T=transitivity_bd(CIJ); % Transitivity
figure('color', [1 1 1])
subplot(2,1,1); stem(C, 'Linewidth', 1.5);
xlabel('Node number');
ylabel('Clustering coeficient');
title('Clustering Coeff');
subplot(2,1,2)
stem(T, 'Linewidth', 1.5);
ylabel('Transitivity');
title('Transitivity');

% Optimal overlapping community structure
M = link_communities(CIJ,'complete');
figure('color', [1 1 1])
imagesc(M);
xlabel('Node number');
ylabel('Communities')
title('Nodal community-affiliation matrix');

% Modularity
[Ci,Q2]=modularity_und(CIJ);
figure('color', [1 1 1])
stem(Ci, 'Linewidth', 1.5);
xlabel('Node number');
ylabel('Communities')
title('Optimal community structure');

% Rich club coefficients
[R,Nk,Ek] = rich_club_bd(CIJ,25); 
figure('color', [1 1 1])
subplot(3,1,1)
stem(R, 'Linewidth', 1.5);
xlabel('Node number')
ylabel('R for levels 1-25')
title('Rich-club coefficient')
subplot(3,1,2)
stem(Nk, 'Linewidth', 1.5);
xlabel('Node number')
ylabel('Nk for degree>25')
title('Number of nodes with degree>25')
subplot(3,1,3)
stem(Ek, 'Linewidth', 1.5);
xlabel('Node number')
ylabel('Ek for degree>25')
title('Number of edges remaining in subgraph with degree>25')

% Assortativity coefficient (assortativity_bin)
r0 = assortativity_bin(CIJ,0);
r1 = assortativity_bin(CIJ,1);
r2 = assortativity_bin(CIJ,2);
r3 = assortativity_bin(CIJ,3);
r4 = assortativity_bin(CIJ,4);
figure('Color',[1 1 1]);
stem([r0; r1; r2; r3; r4], 'linewidth', 2)
xlim([0.5 5.5])
tick=1:5;
xticklabel={'flag=0','flag=1','flag=2','flag=3','flag=4'};
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 10)
ylabel('Assortativity coefficient', 'FontSize', 10)
title('Assortativity coefficient (assortativity__bin)', 'FontSize', 10)

% Distance matrix for shortest distance between nodes
D=distance_bin(CIJ); 
figure('Color',[1 1 1]);
imagesc(D);
xlabel('Node number')
ylabel('Node number')
title('Shortest path length between node-pair')

% Node betweenness centrality
BC=betweenness_bin(CIJ);
figure('Color',[1 1 1]);
stem(BC, 'Linewidth', 1.5);
xlabel('node number');
ylabel('Betweenness centrality');
title('Node betweenness centrality');

% Edge betweenness centrality
[EBC,BC_EDGE]=edge_betweenness_bin(CIJ);
figure('Color',[1 1 1]);
subplot(1,2,1)
stem(BC_EDGE, 'Linewidth', 1.5);
xlabel('node number');
ylabel('Edge betweenness centrality');
title('Edge betweenness centrality');
subplot(1,2,2)
imagesc(EBC);
xlabel('node number');
ylabel('node number');
title('Edge betweenness centrality matrix');

% Global and local diffusion efficiency
[GEdiff,Ediff] = diffusion_efficiency(CIJ);
figure('Color',[1 1 1]);
subplot(1,2,1); imagesc(Ediff); caxis([0 0.05])
xlabel('Node number')
ylabel('Node number')
title('Pair-wise diffusion efficiency');
subplot(1,2,2); stem(GEdiff, 'Linewidth', 1.5);
ylabel('Global diffusion efficiency')
title('Global diffusion efficiency');

% Global and local efficiency
Eloc = efficiency_bin(CIJ,1);
Eglob = efficiency_bin(CIJ); 
figure('Color',[1 1 1]);
subplot(2,1,1); stem(Eloc, 'Linewidth', 1.5);
xlabel('Node number')
ylabel('Local efficiency')
title('Local efficiency');
subplot(2,1,2); stem(Eglob, 'Linewidth', 1.5);
ylabel('Global efficiency')
title('Global efficiency');
 
%% Part 2: Own EEG data (64x64) %%%%%%%%%%%%%
% The scrip is an demonstration of how to use Brain connectivity toolbox.
% The data used here is a single subject anonymized EEG data from a 64 
% channels EEG system. Before this script the data is epoched, processed 
% and averaged over a single stimulus condition of auditory stimuli.
% Further, the corrlation based adjacency matric was calculated.
%% Import corrlation matrix (64x64) & EEG device coordinate file
load('C:\DATA\subject_1\Cor.mat')
load('C:\Users\amit\Documents\template_repo\electrode\cap64_elec_file.mat')

%% Corelation plot
p=0.05;
thr_Cor = threshold_proportional(Cor, p); % Proportional thresholding
thr_Cor=triu(thr_Cor); % Avoide duplicate accross diagonal
aa=elec_file.elec_xyz; 
bb=elec_file.elec_label;
%% Adjacency matric plot & 3D connectivity plot over sensor (adjacency_plot_und)
figure('Color',[1 1 1]);
subplot(1,2,1); imagesc(Cor)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
set(gca,'YTick',tick,'YTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('EEG Channels', 'FontSize', 10)
title('Ajcacency matrix', 'FontSize', 15)
subplot(1,2,2);
scatter3(aa(:,1), aa(:,2), aa(:,3), 50, 'o', 'linewidth', 1); 
text(aa(:,1), aa(:,2), aa(:,3), bb, 'FontSize', 5)
[x,y,z] = adjacency_plot_und(Cor,aa);
hold on
plot3(x,y,z)
axis off
rotate3d
title('Sensor level connectoivity', 'FontSize', 15)
%% Adjacency matric plot & 3D connectivity plot over sensor 
%  with significant (adjacency_plot_und)
figure('Color',[1 1 1]);
subplot(1,2,1); imagesc(thr_Cor)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
set(gca,'YTick',tick,'YTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('EEG Channels', 'FontSize', 10)
title('Ajcacency matrix', 'FontSize', 15)
subplot(1,2,2);
scatter3(aa(:,1), aa(:,2), aa(:,3), 50, 'o', 'linewidth', 1); 
text(aa(:,1), aa(:,2), aa(:,3), bb, 'FontSize', 5)
[x,y,z] = adjacency_plot_und(thr_Cor,aa);
hold on
plot3(x,y,z)
axis off
rotate3d
title('Sensor level connectoivity', 'FontSize', 15)
%% Clustering coefficient (clustering_coef_bu)
C=clustering_coef_bu(thr_Cor);
figure('Color',[1 1 1]);
stem(C, 'linewidth', 1.5)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('Clustering Coefficient', 'FontSize', 10)
title('clustering__coef__bu', 'FontSize', 15)

%% Clustering coefficient (clustering_coef_bd)
C=clustering_coef_bd(thr_Cor);
stem(C, 'linewidth', 1.5)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('Clustering Coefficient', 'FontSize', 10)
title('clustering__coef__bd', 'FontSize', 15)

%% Clustering coefficient (clustering_coef_wd)
C=clustering_coef_wd(thr_Cor);
figure('Color',[1 1 1]);
stem(C, 'linewidth', 1.5)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('Clustering Coefficient', 'FontSize', 10)
title('clustering__coef__wd', 'FontSize', 15)

%% Clustering coefficient (clustering_coef_wu)
C=clustering_coef_wu(thr_Cor);
figure('Color',[1 1 1]);
stem(C, 'linewidth', 1.5)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('Clustering Coefficient', 'FontSize', 10)
title('clustering__coef__wu', 'FontSize', 15)

%% Assortativity coefficient (assortativity_bin)
r0 = assortativity_bin(thr_Cor,0);
r1 = assortativity_bin(thr_Cor,1);
r2 = assortativity_bin(thr_Cor,2);
r3 = assortativity_bin(thr_Cor,3);
r4 = assortativity_bin(thr_Cor,4);
figure('Color',[1 1 1]);
stem([r0; r1; r2; r3; r4], 'linewidth', 2)
xlim([0.5 5.5])
tick=1:5;
xticklabel={'flag=0','flag=1','flag=2','flag=3','flag=4'};
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 10)
ylabel('Assortativity coefficient', 'FontSize', 10)
title('Assortativity coefficient (assortativity__bin)', 'FontSize', 10)

%% Assortativity coefficient (assortativity_wei)
r0 = assortativity_wei(thr_Cor,0);
r1 = assortativity_wei(thr_Cor,1);
r2 = assortativity_wei(thr_Cor,2);
r3 = assortativity_wei(thr_Cor,3);
r4 = assortativity_wei(thr_Cor,4);
figure('Color',[1 1 1]);
stem([r0; r1; r2; r3; r4], 'linewidth', 2)
xlim([0.5 5.5])
tick=1:5;
xticklabel={'flag=0','flag=1','flag=2','flag=3','flag=4'};
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 10)
ylabel('Assortativity coefficient', 'FontSize', 10)
title('Assortativity coefficient (assortativity__wei)', 'FontSize', 10)

%% Node betweenness centrality (betweenness_bin & betweenness_wei)
BC1=betweenness_bin(thr_Cor);
BC2=betweenness_wei(thr_Cor);
figure('Color',[1 1 1]);
subplot(2,1,1); stem(BC1, 'linewidth', 1.5)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('Node betweenness centrality', 'FontSize', 10)
title('betweenness__bin', 'FontSize', 10)
subplot(2,1,2); stem(BC2, 'linewidth', 1.5)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('Node betweenness centrality', 'FontSize', 10)
title('betweenness__wei', 'FontSize', 10)

%% Indegree and outdegree
[id,od,deg] = degrees_dir(thr_Cor);
figure('Color',[1 1 1]);
subplot(3,1,1); stem(id, 'linewidth', 1.5)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('Node indegree', 'FontSize', 10)
title('Indegree', 'FontSize', 10)
subplot(3,1,2); stem(od, 'linewidth', 1.5)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('node outdegree', 'FontSize', 10)
title('Outdegree', 'FontSize', 10)
subplot(3,1,3); stem(deg, 'linewidth', 1.5)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('Degree', 'FontSize', 10)
title('Degree', 'FontSize', 10)

%% degrees_und
[deg] = degrees_und(thr_Cor);
figure('Color',[1 1 1]);
stem(deg, 'linewidth', 1.5)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('Degree', 'FontSize', 10)
title('degrees__und', 'FontSize', 10)

%% Global mean and pair-wise diffusion efficiency
[GEdiff,Ediff] = diffusion_efficiency(Cor);
figure('Color',[1 1 1]);
subplot(1,2,1); stem(GEdiff, 'linewidth', 1.5)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('Global mean iffusion efficiency', 'FontSize', 10)
title('Global mean diffusion efficiency (GEdiff)', 'FontSize', 10)
subplot(1,2,2); imagesc(Ediff)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
set(gca,'YTick',tick,'YTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('EEG Channels', 'FontSize', 10)
title('Global mean and pair-wise diffusion efficiency', 'FontSize', 10)

%% Distance matrix (Dijkstra's algorithm) distance_wei
[D,B]=distance_wei(thr_Cor);
figure('Color',[1 1 1]);
D=triu(D);
imagesc(D)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
set(gca,'YTick',tick,'YTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('EEG Channels', 'FontSize', 10)
title('Distance matrix (distance__wei)', 'FontSize', 10)

%% Global and local efficiency (efficiency_wei)
Eglob = efficiency_wei(thr_Cor);
Eloc = efficiency_wei(thr_Cor,2);
figure('Color',[1 1 1]);
subplot(2,1,1); stem(Eglob, 'linewidth', 1.5)
ylabel('Global efficiency', 'FontSize', 10)
title('efficiency__wei (global)', 'FontSize', 10)
subplot(2,1,2); stem(Eloc, 'linewidth', 1.5)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('Local efficiency', 'FontSize', 10)
title('efficiency__wei (local)', 'FontSize', 10)

%%  K-coreness centrality
[coreness,kn] = kcoreness_centrality_bd(thr_Cor);
figure('Color',[1 1 1]);
subplot(2,1,1); stem(coreness, 'linewidth', 1.5)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('Node coreness', 'FontSize', 10)
title('Node coreness', 'FontSize', 10)
subplot(2,1,2); stem(kn, 'linewidth', 1.5)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('size of k-core', 'FontSize', 10)
title('size of k-core', 'FontSize', 10)

%% Optimal community structure and modularity
Ci = modularity_dir(thr_Cor);
figure('Color',[1 1 1]);
stem(Ci, 'linewidth', 1.5)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('size of k-core', 'FontSize', 10)
title('size of k-core', 'FontSize', 10)

%%  Transitivity based on shortest paths
T1=path_transitivity(thr_Cor,'log');
T2=path_transitivity(thr_Cor,'inv');
figure('Color',[1 1 1]);
subplot(1,2,1); imagesc(T1)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
set(gca,'YTick',tick,'YTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('EEG Channels', 'FontSize', 10)
title('path_transitivity(thr__Cor,''log'')', 'FontSize', 10)
subplot(1,2,2); imagesc(T2)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
set(gca,'YTick',tick,'YTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('EEG Channels', 'FontSize', 10)
title('path_transitivity(thr__Cor,''inv'')', 'FontSize', 10)

%% Reachability and distance matrices
[R,D] = reachdist(thr_Cor);
figure('Color',[1 1 1]);
subplot(1,2,1); imagesc(R)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
set(gca,'YTick',tick,'YTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('EEG Channels', 'FontSize', 10)
title('Reachability', 'FontSize', 10)
subplot(1,2,2); 
D=triu(D);
imagesc(D)
xlim([1 length(bb)])
tick=1:1:length(bb);
xticklabel=char(bb);
set(gca,'XTick',tick,'XTickLabel',xticklabel, 'FontSize', 5)
set(gca,'YTick',tick,'YTickLabel',xticklabel, 'FontSize', 5)
xlabel('EEG Channels', 'FontSize', 10)
ylabel('EEG Channels', 'FontSize', 10)
title('Corresponding distance', 'FontSize', 10)

%% %%%%%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%%%%%%%