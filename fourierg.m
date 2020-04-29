function [I] = fourierg(I)
I=I-mean(I(:));
f = fftshift(fft2(I));
fabs=abs(f);

thresh=0.9*max(fabs(:));

% Find pixels that are brighter than the threshold.
mask = fabs > thresh; 
% Erase those from the image
fabs(mask) = 0;
% Shift back and inverse fft
filteredImage = ifft2(fftshift(fabs)) + mean2(I);
imshow(filteredImage, []);

end