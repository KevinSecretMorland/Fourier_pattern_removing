image = imread('original_big.jpg');
image = imresize(image,[256 256]);

[rows columns dimension] = size(image);

if dimension > 1  
   gray = rgb2gray(image);
end
gray = imresize(image, [256 256]); %resize image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% 
% % Add grid noise to it.
% rowVector = (1 : rows)';
% period = 10; % 20 rows
% amplitude = 0.5; % Magnitude of the ripples.
% offset = 1 - amplitude; % How much the cosine is raised above 0.
% cosVector = amplitude * (1 + cos(2 * pi * rowVector / period))/2 + offset;
% gridImage = repmat(cosVector, [1, columns]);
% 
% % Multiply the grid by the image
% gray = gridImage .* double(gray);
% plotgray = gray;

figure(1); imshow(abs(gray),[]) % original


ff = fft2(gray)
Spec_center = fftshift(fft2(gray)); %2D Spectrum of the image 
figure
imshow((Spec_center),[])

amplitudeImage = log(abs(Spec_center)); %Amplitude of the image

toto =  amplitudeImage(Spec_center);

figure
imshow(amplitudeImage,[])

figure
imshow(toto,[])



