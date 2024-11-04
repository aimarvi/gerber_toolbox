function mv2surf(vol_path, hemi)

fout = [hemi '_tmp-out.mgz'];
command = ['mri_vol2surf --mov ' vol_path ' --o ' fout...
    ' --hemi ' hemi ' --regheader cvs_avg35_inMNI152 --projdist 1.2'];
system(command)

end