fs_dir = '/Applications/freesurfer/7.3.2/';
fs_subject_dir = [fs_dir filesep 'subjects' filesep 'cvs_avg35_inMNI152'];

brain_data = read_freesurfer_brain(fs_subject_dir);