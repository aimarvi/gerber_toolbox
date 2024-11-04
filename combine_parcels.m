dat = MRIread('data/kaneff01/julian_parcels_all.mgz').vol;
surf_dat = MRIread('data/kaneff01/out_surf.mgz').vol;

[vals, idx] = unique(surf_dat);

subj = 'kaneff01';

template = zeros(104,104,52);
fnames = dir(fullfile('data', subj, '*all.mgz'));

for i = 1:numel(fnames)
    disp(fnames(i).name);
    vol_path = fullfile('data', subj, fnames(i).name);
    dat = MRIread(vol_path).vol;

    non_zero_vals = unique(dat(dat ~= 0));
    disp(['There are ' num2str(numel(non_zero_vals)) ' non-zero values']);
    for j = 1:numel(non_zero_vals)
        val = non_zero_vals(j);  % Current unique non-zero value
        template_val = i * 100 + j;
        indices = find(dat == val);
        template(indices) = template_val;
    end
end

mri.vol = template;
fout = 'meta_parcel.nii';
MRIwrite(mri, fullfile('data', subj, fout), 'int');

testin = MRIread(fullfile('data', subj, fout)).vol;

