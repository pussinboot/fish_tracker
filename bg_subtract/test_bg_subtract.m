window_size = 5;
p = 0.01;
k = 100;

start_fr = 30;
end_fr = 50;
% file_path = '../tracking/data/img';
file_path = '../tracking/data/porco_rosso';
file_format = 'png';

% running gaussian average algorithm

% initial mu, sigma
mu_t = image_intensity(start_fr,file_path,file_format);
sig_t = movvar(mu_t,5);
% pcolor(sig_mat);
% colorbar;

% update step
for i = 2:end_fr
I_t = image_intensity(i,file_path,file_format);
mu_t = p * I_t + (1 - p) * mu_t;
d = (I_t - mu_t).^ 2;
sig_t = d * p + (1 - p) * sig_t;
end
fg_bg = abs(I_t - mu_t)./sig_t > k;
image(I_t.*(1-fg_bg)*255)