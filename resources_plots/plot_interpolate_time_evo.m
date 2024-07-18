clf; clear;

subject = 1;    % can be 1,2,3

% Import files for data
path = strcat('..\data\subject',num2str(subject),'\FSI\displacement\');
intervol = readmatrix(strcat(path, 'IntermediateVolumesForDeformation.csv'));
volcurve = readmatrix(strcat(path, 'VolumeCurve.csv'));
indic = intervol(:,1);

% Function that will return the index of the upper bound plot,
% and percentage of distance to next plot
function [i,p] = which_plot(volume, indic)
    i = 0;                              % Plots # varying from 0 to 9
    while (volume < indic(i+1) & i<9)   % Test lower boundary
        i = i+1;
    end
    if (i > 0)
        p = (volume-indic(i))/(indic(i)-indic(i+1)); % Linear ratio between two figs
    else
        p = (volume-indic(i+1))/(indic(i+1)-indic(i+2)); % Linear ratio between two figs
    end
end


% We will sample the volume evolution accordingly to AVI format constraints
% The video has 30 FPS (AVI format constraint)
FPS = 30;
% The recording should respect given time
duration = volcurve(size(volcurve,1),2);

% How many frames we want to plot (+1 because we also want timestep 0)
n_frames = floor(duration*FPS)+1;
% How many time steps we want to skip each time to respect real time
n_skip = floor(size(volcurve,1)/(n_frames-1));

% Matrices to record approximations values
interpolation_linear = zeros(n_frames,2);
approximation_floor = zeros(n_frames,2);

% Filling the matrices
for i = 1:n_frames
    [k,p] = which_plot(volcurve((i-1)*n_skip+1,1),indic);
    if (k > 0)
        interpolation_linear(i,1) = (indic(k)-indic(k+1))*p + indic(k);
    else
        interpolation_linear(i,1) = (indic(1)-indic(2))*p + indic(1);
    end
    interpolation_linear(i,2) = volcurve((i-1)*n_skip+1,2);

    approximation_floor(i,1) = indic(k+1);
    approximation_floor(i,2) = volcurve((i-1)*n_skip+1,2);
end

% We'll plot two figures for the two solutions
tiledlayout(2,1);
nexttile;
hold on;


%% Floor approximation
% Plotting volume
plot(volcurve(:,2),volcurve(:,1),'.',color='blue');
xlabel('time (s)');
ylabel('volume');
title('Volume approximation (floor version)');

% Plotting floor-value
plot(approximation_floor(:,2),approximation_floor(:,1), '*', color="green");

% Plotting boundaries
for i=1:size(intervol,1)
    yline(indic(i,1), '-', indic(i,1));
end

hold off;
nexttile;
hold on;


%% Linear interpolation
% Plotting volume
plot(volcurve(:,2),volcurve(:,1),'.',color='blue');
xlabel('time (s)');
ylabel('volume');
title('Volume interpolation (linear version)');

% Plotting interpolate-value
plot(interpolation_linear(:,2),interpolation_linear(:,1), '*', color="green");

% Plotting boundaries
for i=1:size(intervol,1)
    yline(indic(i,1), '-', indic(i,1));
end

hold off;
