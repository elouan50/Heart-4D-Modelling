clf; clear;

subject = 3;    % can be 1,2,3
plot = 2;       % can be in 1:10

A = readmatrix(strcat('../data/subject',num2str(subject),'/FSI/displacement/GridVelocity_',num2str(plot-1),'.csv'));
% columns of A are X, Y, Z, vx, vy, vz

% Plotting the figure
plot3(A(:,1), A(:,2), A(:,3),'.',color='blue');
