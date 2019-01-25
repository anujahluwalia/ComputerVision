function [ composite_img ] = compositeH( H2to1, template, img )
mask_im = template == 0;
mask_final = not(mask_im);
composite_img = mask_im.*img + mask_final.*template;
end