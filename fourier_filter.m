function [I] = fourier_filter(I)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[rows columns dimension] = size(I);

if dimension > 1  
   gray = rgb2gray(I);
end
gray = imresize(I, [256 256]); %resize image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% Add grid noise to it.
rowVector = (1 : rows)';
period = 10; % 20 rows
amplitude = 0.5; % Magnitude of the ripples.
offset = 1 - amplitude; % How much the cosine is raised above 0.
cosVector = amplitude * (1 + cos(2 * pi * rowVector / period))/2 + offset;
gridImage = repmat(cosVector, [1, columns]);

% Multiply the grid by the image
gray = gridImage .* double(gray);
plotgray = gray;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filter=ones(rows,columns); % filter initially only ones in it
%according to notch filter equation it will find point on image is on imaginary circle.i found circle coordinates.
for i=1:rows-1
  for j=1:columns-1
  d0 = (i-130)^2 + (j-130)^2 <= 32^2 && (i-130)^2 + (j-130)^2 >=20^2;
      if d0
         filter(i,j)=0;
     else
         filter(i,j)=1;
     end
   end
 end
f = fftshift(fft2(gray));
G = abs(ifft2(f.*filter));

figure
imshow(f,[])

figure
subplot(2,2,3)
axis on;
imshow(I,[]);
title('Original Image');

subplot(2,2,1)
imshow(gridImage)
axis on;
title('Noised image');

subplot(2,2,2)
imshow(plotgray,[]);
axis on;
title('Original Image with Periodic "Noise" grid');

subplot(2,2,4)
imshow(G,[]);
axis on;
title('After Fourier Transform');

end

        