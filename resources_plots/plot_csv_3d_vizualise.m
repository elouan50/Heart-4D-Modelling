clf; clear;

file = '../data/subject1/FSI/displacement/GridVelocity_0.csv';
A = readmatrix(file);
% columns of A are X, Y, Z, vx, vy, vz

% Plotting t0
plot3(A(:,1), A(:,2), A(:,3),'.',color='blue');
