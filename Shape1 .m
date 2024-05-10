% Sample gas sensor data (replace with your actual data)
X = [-37.36, -37.45, -37.64, -37.45, -37.64, -37.91];
Y = [23.36, 23.55, 23.55, 23.36, 23.55, 23.64];
Z = [51.33, 51.22, 51.12, 51.33, 51.02, 51.12];
GasLevels = [0.2, 0.5, 0.7, 0.4, 0.9, 0.3]; % Sample gas concentration levels (normalized between 0 and 1)

% Create a 3D scatter plot with color-coded points based on gas levels
scatter3(X, Y, Z, 100, GasLevels, 'filled');
colormap(jet); % Choose a colormap (e.g., jet for heatmap-like colors)
colorbar;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D Scatter Plot with Gas Concentration Color-Coding');
