clf; clear;

file0 = '../data/subject1/FSI/displacement/VolumeCurve.csv';
file1 = '../data/subject1/FSI/displacement/VolumeFlux.csv';
A0 = readmatrix(file0);
A1 = readmatrix(file1);
% The two files show respectively the ventricule's volume and blood flow
% function of the time

tiledlayout(2,1);

% Plotting volume
nexttile;
plot(A0(:,2),A0(:,1),'.',color='blue');
title('Volume(t)');

% Plotting flow
nexttile;
plot(A1(:,2),A1(:,1),'.',color='green');
title('Volume Flow(t)');
