window_size = 15;
p = 0.01;
k = 2.5;

i = 0;
start_fr = 1;

file_path = '../tracking/data/img';
file_format = 'png';

% running gaussian average algorithm

% initial mu, sigma
mu_mat = image_intensity(i+start_fr,file_path,file_format);
sig_t = movvar(mu_mat,5);
% pcolor(sig_mat);
% colorbar;

% update step
i = i + 1;
for i = 2:50
I_t = image_intensity(i,file_path,file_format);
mu_t = p * I_t + (1 - p) * mu_t;
d = (I_t - mu_t).^ 2;
sig_t = d * p + (1 - p) * sig_t;
end
fg_bg = abs(I_t - mu_t)./sig_t > k;
pcolor(fg_bg)