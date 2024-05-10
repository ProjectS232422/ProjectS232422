% Region-Based Segmentation algorithm

% Load the uploaded image
imagePath = 'Picture 4 .jpeg';
image = imread(imagePath);

% Convert the image to double precision for K-Means clustering
imageDouble = im2double(image);

% Reshape the image into a 2D matrix (rows: pixels, columns: RGB channels)
[nRows, nCols, ~] = size(imageDouble);
pixelValues = reshape(imageDouble, nRows * nCols, []);

% Define the number of clusters (regions)
numClusters = 2; % Adjust as needed

% Perform K-Means clustering
[clusterIndices, clusterCenters] = kmeans(pixelValues, numClusters);

% Reshape the cluster indices back into the original image size
clusterIndicesImage = reshape(clusterIndices, nRows, nCols);

% Extract the cluster containing the oil leak (assuming it's the cluster with the largest mean intensity)
clusterMeans = zeros(numClusters, 1);
for i = 1:numClusters
    clusterMeans(i) = mean(pixelValues(clusterIndices == i));
end
[~, leakCluster] = max(clusterMeans);

% Create a binary mask for the detected oil leak region
leakMask = clusterIndicesImage == leakCluster;

% Overlay the detected oil leak region on the original image
leakRegion = bsxfun(@times, image, cast(leakMask, class(image)));
imshow(leakRegion);
