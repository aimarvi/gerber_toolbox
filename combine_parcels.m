subj = 'kaneff01';

% initialize a template for the meta parcel
template = zeros(104,104,52);
fnames = dir(fullfile('data', subj, '*all.mgz'));

for i = 1:numel(fnames)
    vol_path = fullfile('data', subj, fnames(i).name);
    dat = MRIread(vol_path).vol;

    non_zero_vals = unique(dat(dat ~= 0));
    disp(['There are ' num2str(numel(non_zero_vals)) ' non-zero values in ' fnames(i).name]);
    for j = 1:numel(non_zero_vals)
        val = non_zero_vals(j);  % Current unique non-zero value
        template_val = i * 100 + j; 
        indices = find(dat == val);
        template(indices) = template(indices) + template_val; % label the meta parcel
    end
end

mri.vol = template; % save the template as a struct for MRIwrite()
fout = 'meta_parcel.nii';
MRIwrite(mri, fullfile('data', subj, fout), 'double');

% try to load in the meta parcel
parcel_path = fullfile('data', subj, 'meta_parcel.nii');
parcel_dat = MRIread(parcel_path).vol;
fout = fullfile('data', subj, 'meta_surf_parcel.nii');

command = ['mri_vol2surf --mov ' parcel_path ' --o ' fout...
    ' --hemi lh --regheader cvs_avg35_inMNI152 --projdist 1.2'];
system(command);

% why is surface full of zero ??
meta_parcel = MRIread(fout).vol;
ex_parcel = MRIread(vol_path).vol;