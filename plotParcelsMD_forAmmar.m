%% Definitions
project_dir = '/Users/tamaregev/Dropbox/postdoc/Fedorenko/Prosody/Localizer';
results_dir = [project_dir filesep 'Results'];

figures_dir = [project_dir filesep 'Figures'];

%addpath(genpath('/Users/tamaregev/Dropbox/MATLAB/lab/myFunctions'))
addpath('/Users/tamaregev/Dropbox/MATLAB/lab/CommonResources')%for suptitle

results_toolbox_dir = [results_dir '/toolbox_results_important'];

%% plot parcels - MD

%init spm and evlab toolbox:
%addpath('/Users/tamaregev/Dropbox/MATLAB/Toolbox/spm12')
addpath('/Users/tamaregev/Dropbox/MATLAB/Toolbox/spm-main')
fs_dir = '/Applications/freesurfer/7.4.1/';
addpath(genpath(fs_dir));

gerber_toolbox_path = '/Users/tamaregev/Dropbox/MATLAB/Toolbox/Gerber_toolbox';
addpath(genpath(gerber_toolbox_path));


parcels_dir = [project_dir filesep 'Parcels'];
T_labels = readtable([parcels_dir filesep 'MD_parcel_labels.xlsx']);


surf_dir = [parcels_dir filesep 'surf'];
mkdir(surf_dir)

parcels_image=[parcels_dir filesep 'MDfuncparcels_Apr2017_sym_91x109x91_rounded.nii'];

%read parcels nifti:
HeaderInfo = spm_vol(parcels_image);
a = spm_read_vols(HeaderInfo);

%plot
bash_path=getenv('PATH');
setenv('PATH',[bash_path,':/Applications/freesurfer/7.4.1/',':/Applications/freesurfer/7.4.1/bin',':/Applications/freesurfer/7.4.1/subjects']);

numROIs = length(unique(a))-1;
colors = [163, 131, 100]./255;
%colors = jet(numROIs);

clim = [1 numROIs];

%whichROIs = 1:numROIs;
whichROIs = unique(a);
lateralROIs = whichROIs([2:10,12:20]);
medialROIs = whichROIs([11,21]);

inflated = true;


%%%%%%% Lateral view
h=figure;set(h,'position',[10 10 1000 600])
whichHemi = 'lh';
subplot(1,2,1)
[h,hs] = plotVol2Surf(fs_dir,surf_dir,HeaderInfo.fname,clim,colors,inflated,whichHemi,whichROIs,0,'lateral');

whichHemi = 'rh';
subplot(1,2,2)
[h,hs] = plotVol2Surf(fs_dir,surf_dir,HeaderInfo.fname,clim,colors,inflated,whichHemi,whichROIs,1,'lateral');
hs=suptitle('MD symettric');
set(hs,'fontsize',22)
saveas(gcf,[figures_dir filesep 'MD_parcels_all_lateral'],'fig')
saveas(gcf,[figures_dir filesep 'MD_parcels_all_lateral'] ,'png')
%saveas(gcf,[figures_dir filesep 'MD_parcels_all_lateral_rainbow'],'fig')
%saveas(gcf,[figures_dir filesep 'MD_parcels_all_lateral_rainbow'] ,'png')

%%%%%%% Medial view
h=figure;set(h,'position',[10 10 1000 600])
whichHemi = 'lh';
subplot(1,2,1)
[h,hs] = plotVol2Surf(fs_dir,surf_dir,HeaderInfo.fname,clim,colors,inflated,whichHemi,whichROIs,0,'medial');

whichHemi = 'rh';
subplot(1,2,2)
[h,hs] = plotVol2Surf(fs_dir,surf_dir,HeaderInfo.fname,clim,colors,inflated,whichHemi,whichROIs,1,'medial');
hs=suptitle('MD symmetric');
set(hs,'fontsize',22)

saveas(gcf,[figures_dir filesep 'MD_parcels_all_medial'],'fig')
saveas(gcf,[figures_dir filesep 'MD_parcels_all_medial'] ,'png')

%%%%%%% Lateral view - only lateral parcels

h=figure;set(h,'position',[10 10 1000 600])
whichHemi = 'lh';
subplot(1,2,1)
[h,hs] = plotVol2Surf(fs_dir,surf_dir,HeaderInfo.fname,clim,colors,inflated,whichHemi,lateralROIs,0,'lateral');

whichHemi = 'rh';
subplot(1,2,2)
[h,hs] = plotVol2Surf(fs_dir,surf_dir,HeaderInfo.fname,clim,colors,inflated,whichHemi,lateralROIs,1,'lateral');
hs=suptitle('MD symmetric - only lateral');
set(hs,'fontsize',22)

saveas(gcf,[figures_dir filesep 'MD_parcels_lateral_lateral'],'fig')
saveas(gcf,[figures_dir filesep 'MD_parcels_lateral_lateral'] ,'png')

%%%%%%% Medial view - only medial parcels

h=figure;set(h,'position',[10 10 1000 600])
whichHemi = 'lh';
subplot(1,2,1)
[h,hs] = plotVol2Surf(fs_dir,surf_dir,HeaderInfo.fname,clim,colors,inflated,whichHemi,medialROIs,0,'medial');

whichHemi = 'rh';
subplot(1,2,2)
[h,hs] = plotVol2Surf(fs_dir,surf_dir,HeaderInfo.fname,clim,colors,inflated,whichHemi,medialROIs,1,'medial');
hs=suptitle('MD symmetric - only medial');
set(hs,'fontsize',22)

saveas(gcf,[figures_dir filesep 'MD_parcels_medial_medial'],'fig')
saveas(gcf,[figures_dir filesep 'MD_parcels_medial_medial'] ,'png')
