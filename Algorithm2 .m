% K-Means Clustering algorithm 

% Load the image
image = imread('Picture 4 .jpeg'); % Replace 'image.jpg' with the path to your image

% Convert the image to double precision for K-Means clustering
imageDouble = im2double(image);

% Reshape the image into a 2D matrix (rows: pixels, columns: RGB channels)
[nRows, nCols, ~] = size(imageDouble);
pixelValues = reshape(imageDouble, nRows * nCols, []);

% Define the number of clusters (regions)
numClusters = 3; % Adjust as needed

% Perform K-Means clustering
[clusterIndices, clusterCenters] = kmeans(pixelValues, numClusters);

% Reshape the cluster indices back into the original image size
clusterIndicesImage = reshape(clusterIndices, nRows, nCols);

% Visualize the clustered image
imshow(label2rgb(clusterIndicesImage));
