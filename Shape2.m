% Sample data
X = [-37.36, -37.45, -37.64, -37.45, -37.64, -37.91];
Y = [23.36, 23.55, 23.55, 23.36, 23.55, 23.64];
Z = [51.33, 51.22, 51.12, 51.33, 51.02, 51.12];

% Create a meshgrid for X and Y
[Xgrid, Ygrid] = meshgrid(linspace(min(X), max(X), 100), linspace(min(Y), max(Y), 100));

% Interpolate Z values using griddata
Zgrid = griddata(X, Y, Z, Xgrid, Ygrid);

% Create the mesh plot
figure;
mesh(Xgrid, Ygrid, Zgrid);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Mesh Plot of Sensor Data');

% Add scatter points for the original data
hold on;
scatter3(X, Y, Z, 100, 'r', 'filled');
hold off;

% Show grid and adjust view
grid on;
view(3);
