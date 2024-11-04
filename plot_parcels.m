% plot on template MNI brain
FS_DIR = '/Applications/freesurfer/7.3.2';
FS_SUBJ_DIR = [FS_DIR filesep 'subjects' filesep 'cvs_avg35_inMNI152'];
brain_data = read_freesurfer_brain(FS_SUBJ_DIR);

subj = 'kaneff01';
hemi = 'lh';
fnames = dir(fullfile('data', subj, '*all.mgz'));

figure;
plot_mesh_brain(brain_data.inflated_left,[-115 0]); % The second parameter is the initial viewing position
colormap gray
clim([-4 1])

colormap_list = {hot, jet, parula, autumn, winter, spring, summer, cool}; % Add more colormaps if needed
num_colormaps = numel(colormap_list);

transparency = 0;
meta_surf = zeros(1, 137427);
for i = 1:numel(fnames)
    vol_path = fullfile('data', subj, fnames(i).name);
    mv2surf(vol_path, hemi)

    surf = MRIread([hemi '_tmp-out.mgz']).vol;
    delete '*_tmp-out.mgz'
    meta_surf(surf>0) = meta_surf(surf>0) + i;
    % surf(~surf)=nan;
    % surf(surf>0)=i;
end
disp(unique(meta_surf))
meta_surf(~meta_surf) = nan;

paint_mesh(meta_surf,transparency);
colormap(parula);
clim([1 15]);
