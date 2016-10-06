function im = image_intensity(frame_no,file_path,file_format)
    im = imread(sprintf('%s%05d.%s', file_path, frame_no, file_format));
    if ndims(im) == 3 % grayscale color images
        im = rgb2gray(im);
    end;
    im = double(im);
    im = im / 255;
end

