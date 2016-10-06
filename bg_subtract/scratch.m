
file_path = '../tracking/data/porco_rosso';
file_format = 'png';
frame_no = 1;
im = (imread(sprintf('%s%05d.%s', file_path, frame_no, file_format)));
im = double(rgb2gray(im));
image(im);