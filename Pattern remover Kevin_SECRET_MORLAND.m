clear all
close all

image = imread('toto3.png');
image = imresize(image,[256 256]);

[rows columns dimension] = size(image);

if dimension > 1  
   image = rgb2gray(image);
end

choice = questdlg('Would you apply a grid ?','Grid','Yes','No','No');
% Handle response
switch choice
    case 'Yes'
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure(11); imshow(image,[]) % original
        % Add grid noise to it.
        rowVector = (1 : rows)';
        period = 10; % 20 rows
        amplitude = 0.5; % Magnitude of the ripples.
        offset = 1 - amplitude; % How much the cosine is raised above 0.
        cosVector = amplitude * (1 + cos(2 * pi * rowVector / period))/2 + offset;
        gridImage = repmat(cosVector, [1, columns]);

        % Multiply the grid by the image
        image = gridImage .* double(image);
        figure(1); imshow(image,[]) % original

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'No'
        figure(1); imshow(image,[]) % original
end

Spec = fftshift(fft2(image)); %2D Spectrum of the image 

amplitudeImage = log(abs(Spec)); %Amplitude of the image
figure(3); imshow(amplitudeImage,[])
figure(4); plot(amplitudeImage)
xlim([0 255])

amplitudeThreshold = 10.9;
brightSpikes = amplitudeImage > amplitudeThreshold; % Binary image.
figure(5); imshow(brightSpikes,[]) 

brightSpikes(115:143, :) = 0;
figure(6); imshow(brightSpikes,[]) % We exclude the center of the spectum

Spec(brightSpikes) = 0;
amplitudeImage2 = log(abs(Spec));
figure(8); imshow(amplitudeImage2,[])

filteredImage = ifft2(fftshift(Spec));
amplitudeImage3 = abs(filteredImage);
figure(9); imshow(amplitudeImage3,[])

figure(10); plot(log(abs(fftshift(fft2(amplitudeImage3)))))
xlim([0 255])






