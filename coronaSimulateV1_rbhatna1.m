% CORONASIMULATE  Simulate coronagraph and Gerchberg-Saxton algorithm
%
% A simulation of a coronagraph and the Gerchberg-Saxton algorithm, in the
% context of NASA's Roman Space Telescope, developed to help teach ENCMP
% 100 Computer Programming for Engineers at the University of Alberta. The
% program saves data to a MAT file for subsequent evaluation.

%{
    Copyright (c) 2021, University of Alberta
    Electrical and Computer Engineering
    All rights reserved.

    Student name:
    Student CCID:
    Others:

    To avoid plagiarism, list the names of persons, other than a lecture
    instructor, whose code, words, ideas, or data were used. To avoid
    cheating, list the names of persons, other than a lab instructor, who
    provided substantial editorial or compositional assistance.

    After each name, including the student's, enter in parentheses an
    estimate of the person's contributions in percent. Without these
    numbers, adding to 100%, follow-up questions may be asked.

    For anonymous sources, enter code names in uppercase, e.g., SAURON,
    followed by percentages as above. Email a list of online sources
    (links suffice) to a teaching assistant before submission.
%}
clear
rng('default')

im = loadImage;
[im,Dphi] = opticalSystem(im,300);
images = gerchbergSaxton(im,20,Dphi);

frames = getFrames(images);
save frames frames

% im = loadImage returns an indexed image, im, of an exoplanet (2M1207b)
% orbiting a distant star. The image, a 2D matrix, is downloaded from a
% NASA website. It should be displayed with a grayscale colour map.
function im = loadImage
path = 'https://exoplanets.nasa.gov/system/resources/';
file = 'detail_files/300_26a_big-vlt-s.jpg';
im = imread(strcat(path,file));
im = rgb2gray(im);
end

function [im,Dphi] = opticalSystem(im,width)
im = occultSquare(im,width);
[IMa,IMp] = dft2(im);
imR = uint8(randi([0 255],size(im)));
[~,Dphi] = dft2(imR);
im = idft2(IMa,IMp-Dphi);
end

function im = occultSquare(im,width)

[rows,columns]=size(im);

middle_image=[round(rows/2),round(columns/2)];

a=-round(width/2):round(width/2);

image_vector_x=middle_image(1)+a;
image_vector_y=middle_image(2)+a;

im(image_vector_x,image_vector_y)=0;

end

% [IMa,IMp] = dft2(im) returns the amplitude, IMa, and phase, IMp, of the
% 2D discrete Fourier transform of an indexed image, im. The image, a 2D
% matrix, is expected to be of class 'uint8'. The phase is in degrees.
function [IMa,IMp] = dft2(im)
IM = fft2(im);
IMa = abs(IM);
IMp = rad2deg(angle(IM));
end

% im = idft2(IMa,IMp) returns an indexed image, im, of class 'uint8' that
% is the inverse 2D discrete Fourier transform (DFT) of a 2D DFT specified
% by its amplitude, IMa, and phase, IMp. The phase must be in degrees.
function im = idft2(IMa,IMp)
IM = IMa.*complex(cosd(IMp),sind(IMp));
im = uint8(ifft2(IM,'symmetric'));
end

function images = gerchbergSaxton(im,maxIters,Dphi)
[IMa,IMp] = dft2(im);
images = cell(maxIters+1,1);
for k = 0:maxIters
    fprintf('Iteration %d of %d\n',k,maxIters)
    im = idft2(IMa,IMp+k/maxIters* Dphi);
    images{k+1} = im;
end
end

function frames = getFrames(images)
numFrames = numel(images);
for k = 1:numFrames%:-1:1
    image(images{k})
    colormap(gray)
    title('Coronagraph Simulation')
    axis image off
    frames(k) = getframe(gcf);
end
%close all
end
