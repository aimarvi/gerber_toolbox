FS_DIR = '/Applications/freesurfer/7.3.2';
FS_SUBJ_DIR = [FS_DIR filesep 'subjects' filesep 'cvs_avg35_inMNI152'];
PROJ_DIR = '~/mount2/recons';

surf_out = './surface';

brain_data = read_freesurfer_brain(FS_SUBJ_DIR);

subj = 'kaneff01';
hem = 'rh';
exp = 'vis';
contrast = 'Fa-O';

vol_path = [PROJ_DIR filesep '..' filesep 'vols_' exp...
    filesep subj filesep 'bold' filesep exp '.sm3.all'...
    filesep contrast filesep 'sig.nii.gz'];

fout = [surf_out filesep subj '.mgz'];

command = ['mri_vol2surf --mov ' vol_path ' --o ' fout...
    ' --hemi ' hem ' --regheader cvs_avg35_inMNI152 --projdist 1.2'];
system(command);

readin = MRIread(fout);
data_surf = single(readin.vol);
data_surf(~data_surf)=nan;

thresholded = single(readin.vol);
thresholded(thresholded<3) = nan;

figure;
% The second parameter is the initial viewing position
plot_mesh_brain(brain_data.inflated_right,[90 0]);
clim([-4 1]);
colormap gray

transparency = 0.3;

% Plot
paint_mesh(thresholded,transparency);

% Finally the colormap and range need to be changed for this "layer"
% because they are still identical to the previous ones. 
clim([0 20]);
colormap hot