clear;
original_image = imread('cow.png');
mask = create_mask(size(original_image,1), size(original_image,2), 'vertical');

for radius=1:10
    for i=1:3
        image(:,:,i) = original_image(:,:,i) .* (1-mask);
    end
    image_bak = image;
    image = inpaint(image, mask, radius);
    % Calculate signal-noise ratio
    snr(radius) = psnr(image, original_image);
end

for i=1:3
    image(:,:,i) = original_image(:,:,i) .* (1-mask);
end
best_radius = find(snr==max(snr),1) -1;
image = inpaint(image, mask, best_radius);

figure;
imshow(image);

figure;
plot(snr);
xlabel 'Neighborhood size'
ylabel 'Peak Signal-Noise Ratio'