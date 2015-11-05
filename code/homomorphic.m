clc;clear;close all;
input_im = imread('../data/image3_input.bmp');
% gray_input = rgb2gray(input_im);
figure, imshow(input_im), title('Original Image');
G_r = fft2(input_im(:,:,1),size(input_im,1),size(input_im,2));
G_g = fft2(input_im(:,:,2),size(input_im,1),size(input_im,2));
G_b = fft2(input_im(:,:,3),size(input_im,1),size(input_im,2));
figure, imshow(fftshift(G_r), [0 100000]);
figure, imshow(fftshift(G_g), [0 100000]);
figure, imshow(fftshift(G_b), [0 100000]);
% 
% Hp = (1 - lpfilter('gaussian', 2*size(my_gray_input,1), 2*size(my_gray_input,2),1));
% figure, imshow(fftshift(Hp), [ ]);
% Gp = Hp.*F;
% figure, imshow(fftshift(Gp), [0 1000]);
% gp = real(ifft2(Gp));
% gpc = gp(1:size(my_gray_input,1), 1:size(my_gray_input,2));
% figure, imhist(gpc,64);
% figure, imshow(gpc, [ ]), title('Homomorphic filter');


fgauss = my_fgauss(4, [41 41]);
H = fft2(fgauss, size(input_im,1), size(input_im,2));
% p = [0 -1 0;-1 4 -1; 0 -1 0];
% P = fft2(p, 2*size(input_im,1), 2*size(input_im,2));
% figure, imshow(fftshift(real(P)));
figure, imshow(fftshift(real(H)));
K = 0.05;
F_hat_r = (H.*conj(H) ./ (H.*(H.*conj(H) + K))) .* G_r;
F_hat_g = (H.*conj(H) ./ (H.*(H.*conj(H) + K))) .* G_g;
F_hat_b = (H.*conj(H) ./ (H.*(H.*conj(H) + K))) .* G_b;
figure, imshow(fftshift(F_hat_r), [0 100000]);
figure, imshow(fftshift(F_hat_g), [0 100000]);
figure, imshow(fftshift(F_hat_b), [0 100000]);
f_hat_r = real(ifft2(F_hat_r));
f_hat_g = real(ifft2(F_hat_g));
f_hat_b = real(ifft2(F_hat_b));
f_hat_r = f_hat_r(1:size(input_im,1), 1:size(input_im,2));
f_hat_g = f_hat_g(1:size(input_im,1), 1:size(input_im,2));
f_hat_b = f_hat_b(1:size(input_im,1), 1:size(input_im,2));
output_im(:,:,1) = f_hat_r;
output_im(:,:,2) = f_hat_g;
output_im(:,:,3) = f_hat_b;

% output_im = my_imfilter(input_im,fgauss);
% figure, imshow(uint8(output_im));

% for i = 1:size(my_gray_input,1)
%     for j = 1:size(my_gray_input,2)
%         weight(i,j,1) = he_input(i,j,1) / double(my_gray_input(i,j,1) + 1);
%         output_im(i,j,1) = input_im(i,j,1) * weight(i,j,1);
%         output_im(i,j,2) = input_im(i,j,2) * weight(i,j,1);
%         output_im(i,j,3) = input_im(i,j,3) * weight(i,j,1);
%     end
% end

% output_im = rgb2hsv(input_im);
% output_im(:,:,3) = g_blur_im / 255;
% output_im(:,:,2) = output_im(:,:,2) * 1;
% output_im = hsv2rgb(output_im);

figure, imshowpair(input_im, uint8(output_im), 'montage'), title('Input Image vs. Output Image');
imwrite(uint8(output_im), 'output_image.bmp');