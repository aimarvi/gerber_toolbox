FS_DIR = '/Applications/freesurfer/7.3.2';
FS_SUBJ_DIR = [FS_DIR filesep 'subjects' filesep 'cvs_avg35_inMNI152'];
PROJ_DIR = '~/mount2/recons';

surf_out = './surface';

brain_data = read_freesurfer_brain(FS_SUBJ_DIR);

subj = 'kaneff01';
hem = 'lh';
exp = 'langloc';
contrast = 'S-NW';

% vol_path = [PROJ_DIR filesep '..' filesep 'vols_' exp...
%     filesep subj filesep 'bold' filesep exp '.sm3.all'...
%     filesep contrast filesep 'sig.nii.gz'];
% 
% parcel_path = [PROJ_DIR filesep '..' filesep 'data_analysis' ...
%     filesep 'masks' filesep 'vols' filesep subj filesep ...
%     'lang_parcels_all.mgz'];
% fout = [surf_out filesep subj '_' exp '_parcels.mgz'];

parcel_path = fullfile('data', subj, 'meta_parcel.nii');
parcel_dat = MRIread(parcel_path).vol;
fout = fullfile('data', subj, 'meta_surf_parcel.nii');

command = ['mri_vol2surf --mov ' parcel_path ' --o ' fout...
    ' --hemi ' hem ' --regheader cvs_avg35_inMNI152 --projdist 1.2'];


readin = MRIread(fout);
data_surf = single(readin.vol);
data_surf(~data_surf)=nan;

thresholded = single(readin.vol);
thresholded(thresholded<3) = nan;

figure;
% The second parameter is the initial viewing position
plot_mesh_brain(brain_data.pial_left,[-115 0]);
clim([-4 1]);
colormap gray

transparency = 0.3;

% Plot
paint_mesh(data_surf,transparency);

% Finally the colormap and range need to be changed for this "layer"
% because they are still identical to the previous ones. 
clim([0 600]);
colormap hot