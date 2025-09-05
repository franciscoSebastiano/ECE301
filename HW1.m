% Average image samples into representative images (n=5 samples)
both_leds = (1/5) * (im2double(imread("ab1.bmp")) + im2double(imread("ab4.bmp")) + im2double(imread("ab3.bmp")) + im2double(imread("ab2.bmp")) +im2double(imread("ab.bmp")));
left_led = (1/5) * (im2double(imread("a1.bmp")) + im2double(imread("a4.bmp")) + im2double(imread("a3.bmp")) + im2double(imread("a2.bmp")) + im2double(imread("a.bmp")));
right_led = (1/5) * (im2double(imread("b4.bmp")) + im2double(imread("b3.bmp")) + im2double(imread("b2.bmp")) + im2double(imread("b1.bmp")) + im2double(imread("b.bmp")));
background = im2double(imread("background.bmp"));

% create combined LED image by adding left and right led images together
combined_image = left_led + right_led - background;
% take absolute difference of the two images (leds added together, both leds on)
difference = imabsdiff(combined_image, both_leds);
% Remove data points greater than or equal to 1 since the camera will always behave nonlinearly beyond the maximum pixel value
limit = combined_image > 0.99;
difference = difference - difference .* limit;

% Red channel intensity vs nonlinearity data
r_intensity = reshape(both_leds(:,:,1), 1, []);
r_diff = reshape(difference(:,:,1), 1, []);

% Green channel intensity vs nonlinearity data
g_intensity = reshape(both_leds(:,:,2), 1, []);
g_diff = reshape(difference(:,:,2), 1, []);

% Blue channel intensity vs nonlinearity data
b_intensity = reshape(both_leds(:,:,3), 1, []);
b_diff = reshape(difference(:,:,3), 1, []);

figure
imshow(right_led);
figure
imshow(left_led);
figure
imshow(combined_image)

figure;
subplot(1,3,1);
scatter(r_intensity, r_diff, 'r');
xlim([0,1]);
subplot(1,3,2);
scatter(g_intensity, g_diff, 'g');
xlim([0,1]);
subplot(1,3,3);
scatter(b_intensity, b_diff, 'b');
xlim([0,1]);
