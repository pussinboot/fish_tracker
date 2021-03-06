% ***********************************************************************
% Copyright (c) Laura Sevilla-Lara and Erik G. Learned-Miller, 2012.
% ***********************************************************************

function track2video(data, output_name, file_path, file_format, start_fr, wsize, show_track)
    
linewidth = 2;
mov = VideoWriter(sprintf('%s.avi', output_name));
open(mov)

for i=1:size(data, 1)
    im = double(imread(sprintf('%s%05d.%s', file_path, i+start_fr, file_format)));
    if ndims(im) ~= 3
        im = cat(3, im, im, im);
    end;
    % draw each of the rectangles
    im = uint8(drawRect(im, data(i, :), wsize, 'r', linewidth)); 
    if show_track
        imshow(im);
        pause(0.1);
    end;
    % mov = addframe(mov, im);
    writeVideo(mov, im);

end;
    
close(mov);
    
    
    
