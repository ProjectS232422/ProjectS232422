% Load the thermal image
thermalImage = imread('Picture 4 .jpeg'); % Replace 'thermal_image.jpg' with the path to your thermal image

% Convert the thermal image to grayscale
grayThermalImage = rgb2gray(thermalImage);

% Define a temperature threshold for detecting oil leaks
temperatureThreshold = 100; % Adjust as needed based on your specific application

% Thresholding: Segment regions with temperature above the threshold
oilLeakRegions = grayThermalImage > temperatureThreshold;

% Visualize the detected oil leak regions on the original thermal image
imshow(thermalImage);
hold on;
contour(oilLeakRegions, 'r', 'LineWidth', 2);
hold off;
