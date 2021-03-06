clc;clear;close all;
input_im = imread('../data/image1_input.bmp');
org_im = imread('../data/image1_org.bmp');
% gray_input = rgb2gray(input_im);
figure, imshow(org_im), title('Original Image');
G_r = fft2(input_im(:,:,1),size(input_im,1),size(input_im,2));
G_g = fft2(input_im(:,:,2),size(input_im,1),size(input_im,2));
G_b = fft2(input_im(:,:,3),size(input_im,1),size(input_im,2));
figure, imshow(fftshift(G_r), [0 100000]);
figure, imshow(fftshift(G_g), [0 100000]);
figure, imshow(fftshift(G_b), [0 100000]);
F_r = fft2(org_im(:,:,1),size(org_im,1),size(org_im,2));
F_g = fft2(org_im(:,:,2),size(org_im,1),size(org_im,2));
F_b = fft2(org_im(:,:,3),size(org_im,1),size(org_im,2));
F = my_motion(15,60);
H = fft2(F,size(org_im,1),size(org_im,2)); 
F_hat_r = H .* F_r;
F_hat_g = H .* F_g;
F_hat_b = H .* F_b;
figure, imshow(fftshift(F_hat_r), [0 100000]);
figure, imshow(fftshift(F_hat_g), [0 100000]);
figure, imshow(fftshift(F_hat_b), [0 100000]);
f_hat_r = uint8(ifft2(F_hat_r));
f_hat_g = uint8(ifft2(F_hat_g));
f_hat_b = uint8(ifft2(F_hat_b));

output_im(:,:,1) = f_hat_r;
output_im(:,:,2) = f_hat_g;
output_im(:,:,3) = f_hat_b;

figure, imshowpair(input_im, output_im, 'montage'), title('Input Image vs. Output Image');
figure, imshow(output_im - input_im);
imwrite(output_im, 'output_image.bmp');