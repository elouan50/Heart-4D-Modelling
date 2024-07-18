clf; clear;

subject = 1; % Can be 1,2,3

% Import files for data
path = strcat('..\data\subject',num2str(subject),'\FSI\displacement\');
intervol = readmatrix(strcat(path,'IntermediateVolumesForDeformation.csv'));

% Import data
grid_velocity = cell(1,10);
for i = 1:10
    grid_velocity{i} = readmatrix(strcat(path,'GridVelocity_',num2str(i-1),'.csv'));
end

n = size(grid_velocity{1},1);
indic = intervol(:,1);
convvol = zeros(10,2);


% Calculate volumes using two methods:
% 1. Either whole convex hull
% 2. Separate two parts (the parameter t can be adjusted for convenience

t = 0.62;                       % Boundary between high and low parts (shoud be 0<t<1)

for i=1:10
    ventricle = grid_velocity{i}(:, 1:3); % Ventricle position
    [hull,convvol(i,1)] = convhull(ventricle); % Naive hull
    z_boundary = t*max(ventricle(:,3)) + (1-t)*min(ventricle(:,3));
    slice_high = [];
    slice_low = [];
    for j = 1:n                       % Decide for each point if high or low
        if ventricle(j,3) >= z_boundary
            slice_high = [slice_high ; ventricle(j,:)];
        else
            slice_low = [slice_low ; ventricle(j,:)];
        end
    end
    [hull, avl] = convhull(slice_low);
    [hull, avh] = convhull(slice_high);
    convvol(i,2) = avl+avh;
end

% Finally normalizing accordingly to the first point of ref volumes
convvol(:,1) = convvol(:,1)*intervol(1)/convvol(1,1);
convvol(:,2) = convvol(:,2)*intervol(1)/convvol(1,2);

% Plotting 3d figures
hold on;
plot3(slice_high(:,1),slice_high(:,2),slice_high(:,3),'.',color='blue');
plot3(slice_low(:,1),slice_low(:,2),slice_low(:,3),'.',color='red');
hold off;

% Plotting graphs
figure();
hold on;
plot(indic,'*');
plot(convvol(:,1),'*');
plot(convvol(:,2),'*');
legend('labeled volumes','convhull volumes','semiconvhull volumes');
hold off;