clc;clear;close all;
input_im = imread('../data/image3_input.bmp');
org_im = imread('../data/image3_org.bmp');
% gray_input = rgb2gray(input_im);
figure, imshow(input_im), title('Input Image');
figure, imshow(org_im), title('Original Image');
G_r = fft2(input_im(:,:,1),size(input_im,1),size(input_im,2));
G_g = fft2(input_im(:,:,2),size(input_im,1),size(input_im,2));
G_b = fft2(input_im(:,:,3),size(input_im,1),size(input_im,2));
F_r = fft2(org_im(:,:,1),size(org_im,1),size(org_im,2));
F_g = fft2(org_im(:,:,2),size(org_im,1),size(org_im,2));
F_b = fft2(org_im(:,:,3),size(org_im,1),size(org_im,2));
F_hat_r = (F_r) ./ (G_r);
F_hat_g = (F_g) ./ (G_g);
F_hat_b = (F_b) ./ (G_b);
figure, imshow(fftshift(F_hat_r), [0 100000]);
figure, imshow(fftshift(F_hat_g), [0 100000]);
figure, imshow(fftshift(F_hat_b), [0 100000]);
f_hat_r = real(ifft2(F_hat_r));
f_hat_g = real(ifft2(F_hat_g));
f_hat_b = real(ifft2(F_hat_b));
f_hat_r = f_hat_r(1:size(input_im,1), 1:size(input_im,2));
f_hat_g = f_hat_g(1:size(input_im,1), 1:size(input_im,2));
f_hat_b = f_hat_b(1:size(input_im,1), 1:size(input_im,2));
f_hat_r = f_hat_r - min(f_hat_r);
f_hat_g = f_hat_g - min(f_hat_g);
f_hat_b = f_hat_b - min(f_hat_b);
f_hat_r = f_hat_r ./ max(f_hat_r);
f_hat_g = f_hat_g ./ max(f_hat_g);
f_hat_b = f_hat_b ./ max(f_hat_b);


output_im(:,:,1) = f_hat_r;
output_im(:,:,2) = f_hat_g;
output_im(:,:,3) = f_hat_b;

figure, imshowpair(input_im, uint8(output_im), 'montage'), title('Input Image vs. Output Image');
imwrite(uint8(output_im), 'output_image.bmp');