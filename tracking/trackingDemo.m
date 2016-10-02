
% ***********************************************************************
% Copyright (c) Laura Sevilla-Lara and Erik G. Learned-Miller, 2012.
% ***********************************************************************


% default input parameters 
params.file_path = './data/porco_rosso';
params.file_format = 'png';
params.output_name = 'porco_rosso';
params.start_fr = 97; %19;
params.end_fr = 252; %92; 
params.init_pos = [200, 347];%[248, 552];
params.wsize = [270, 400]; %[32, 60];

params.nbins = 16; 
params.feat_width = 5; 
params.feat_sig = 0.625; 
params.sp_width = [9, 15];
params.sp_sig = [1, 2];
params.max_shift = 30;

% track target along sequence 
positions = trackDF(params); 

% render video of the track (and show the images if you choose to)
show_track = 1; 
track2video(positions, params.output_name, params.file_path, params.file_format, params.start_fr, params.wsize, show_track);

