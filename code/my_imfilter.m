function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% See 'help imfilter' or 'help conv2'. While terms like "filtering" and
% "convolution" might be used interchangeably, and they are indeed nearly
% the same thing, there is a difference:
% from 'help filter2'
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.

% Your function should work for color images. Simply filter each color
% channel independently.

% Your function should work for filters of any width and height
% combination, as long as the width and height are odd (e.g. 1, 7, 9). This
% restriction makes it unambigious which pixel in the filter is the center
% pixel.

% Boundary handling can be tricky. The filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% you look at 'help conv2' and 'help imfilter' you see that they have
% several options to deal with boundaries. You should simply recreate the
% default behavior of imfilter -- pad the input image with zeros, and
% return a filtered image which matches the input resolution. A better
% approach is to mirror the image content over the boundaries for padding.

% % Uncomment if you want to simply call imfilter so you can see the desired
% % behavior. When you write your actual solution, you can't use imfilter,
% % filter2, conv2, etc. Simply loop over all the pixels and do the actual
% % computation. It might be slow.
% % output = imfilter(image, filter);


[ r_im c_im l_im ] = size(image);
[ r_fltr c_fltr ] = size(filter);

modi_R_im = zeros(r_im + r_fltr - 1, c_im + c_fltr - 1);
modi_G_im = zeros(r_im + r_fltr - 1, c_im + c_fltr - 1);
modi_B_im = zeros(r_im + r_fltr - 1, c_im + c_fltr - 1);
output = zeros(r_im, c_im);

    
for i = 1:size(modi_R_im,1)
    for j = 1:size(modi_R_im,2)
        if (i <= (r_fltr-1)/2) && (j <= (c_fltr-1) / 2)
            modi_R_im(i,j) = image(i,j,1);
            modi_G_im(i,j) = image(i,j,2);
            modi_B_im(i,j) = image(i,j,3);
        elseif (i <= (r_fltr-1)/2) && (j > (c_fltr-1) / 2) && (j <= size(image,2) + (c_fltr-1)/2)
            modi_R_im(i,j) = image(i,j-(c_fltr-1)/2,1);
            modi_G_im(i,j) = image(i,j-(c_fltr-1)/2,2);
            modi_B_im(i,j) = image(i,j-(c_fltr-1)/2,3);
        elseif (i <= (r_fltr-1)/2) && (j > size(image,2) + (c_fltr-1)/2) && (j <= size(modi_R_im,2))
            modi_R_im(i,j) = image(i,j-(c_fltr-1),1);
            modi_G_im(i,j) = image(i,j-(c_fltr-1),2);
            modi_B_im(i,j) = image(i,j-(c_fltr-1),3);
            
        elseif (i > (r_fltr-1)/2) && (i <= size(image,1) + (r_fltr-1)/2) && (j <= (c_fltr-1)/2)
            modi_R_im(i,j) = image(i-(r_fltr-1)/2,j,1);
            modi_G_im(i,j) = image(i-(r_fltr-1)/2,j,2);
            modi_B_im(i,j) = image(i-(r_fltr-1)/2,j,3);
        elseif (i > (r_fltr-1)/2) && (i <= size(image,1) + (r_fltr-1)/2) && (j > (c_fltr-1)/2) && (j <= size(image,2) + (c_fltr-1)/2)
            modi_R_im(i,j) = image(i-(r_fltr-1)/2,j-(c_fltr-1)/2,1);
            modi_G_im(i,j) = image(i-(r_fltr-1)/2,j-(c_fltr-1)/2,2);
            modi_B_im(i,j) = image(i-(r_fltr-1)/2,j-(c_fltr-1)/2,3);
        elseif (i > (r_fltr-1)/2) && (i <= size(image,1) + (r_fltr-1)/2) && (j > size(image,2) + (c_fltr-1)/2) && (j <= size(modi_R_im,2))
            modi_R_im(i,j) = image(i-(r_fltr-1)/2,j-(c_fltr-1),1);
            modi_G_im(i,j) = image(i-(r_fltr-1)/2,j-(c_fltr-1),2); 
            modi_B_im(i,j) = image(i-(r_fltr-1)/2,j-(c_fltr-1),3); 
            
        elseif (i > size(image,1) + (r_fltr-1)/2) && (i <= size(modi_R_im,1)) && (j <= (c_fltr-1)/2)
            modi_R_im(i,j) = image(i-(r_fltr-1),j,1);
            modi_G_im(i,j) = image(i-(r_fltr-1),j,2);
            modi_B_im(i,j) = image(i-(r_fltr-1),j,3);
        elseif (i > size(image,1) + (r_fltr-1)/2) && (i <= size(modi_R_im,1)) && (j > (c_fltr-1)/2) && (j <= size(image,2) + (c_fltr-1)/2)
            modi_R_im(i,j) = image(i-(r_fltr-1),j-(c_fltr-1)/2,1);
            modi_G_im(i,j) = image(i-(r_fltr-1),j-(c_fltr-1)/2,2);
            modi_R_im(i,j) = image(i-(r_fltr-1),j-(c_fltr-1)/2,3);
        else
            modi_R_im(i,j) = image(i-(r_fltr-1),j-(c_fltr-1),1);
            modi_G_im(i,j) = image(i-(r_fltr-1),j-(c_fltr-1),2);
            modi_B_im(i,j) = image(i-(r_fltr-1),j-(c_fltr-1),3);
        end
    end
end
    
%     modi_R_im = padarray(R_im, [ (r_fltr-1)/2 (c_fltr-1)/2 ], 'symmetric', 'both');
%     modi_G_im = padarray(G_im, [ (r_fltr-1)/2 (c_fltr-1)/2 ], 'symmetric', 'both');
%     modi_B_im = padarray(B_im, [ (r_fltr-1)/2 (c_fltr-1)/2 ], 'symmetric', 'both');
    
    for i = 1:size(image,1)
        for j = 1:size(image,2)
            output(i,j,1) = sum(sum(modi_R_im(i:i+r_fltr-1, j:j+c_fltr-1).*filter));
            output(i,j,2) = sum(sum(modi_G_im(i:i+r_fltr-1, j:j+c_fltr-1).*filter));
            output(i,j,3) = sum(sum(modi_B_im(i:i+r_fltr-1, j:j+c_fltr-1).*filter));
        end
    end
end


 
 
 

    


    





