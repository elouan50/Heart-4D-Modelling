clf; clear;

path = '..\data\subject3\FSI\displacement\';

intervol = readmatrix(strcat(path,'IntermediateVolumesForDeformation.csv'));
volcurve = readmatrix(strcat(path,'VolumeCurve.csv'));

gv = [
readmatrix(strcat(path,'GridVelocity_0.csv'));
readmatrix(strcat(path,'GridVelocity_1.csv'));
readmatrix(strcat(path,'GridVelocity_2.csv'));
readmatrix(strcat(path,'GridVelocity_3.csv'));
readmatrix(strcat(path,'GridVelocity_4.csv'));
readmatrix(strcat(path,'GridVelocity_5.csv'));
readmatrix(strcat(path,'GridVelocity_6.csv'));
readmatrix(strcat(path,'GridVelocity_7.csv'));
readmatrix(strcat(path,'GridVelocity_8.csv'));
readmatrix(strcat(path,'GridVelocity_9.csv'))
];

n = size(gv,1)/10;
indic = intervol(:,4);

function [i,p] = which_plot(volume, indic)
    i = 0;                              % Plots # varying from 0 to 9
    while (volume < indic(i+1) & i<9)   % Test lower boundary
        i = i+1;
    end
    if (i > 0)
        p = (volume-indic(i))/(indic(i)-indic(i+1)); % Linear ratio between two figs
    else
        p = (volume-indic(i+1))/(indic(i+1)-indic(i+2)); % If over the 0-boundary, we extrapolate thanks to the first two configurations
    end
end

% Preparations for a clean plotting
set(gcf, 'Position', get(0, 'Screensize')); % Big window
h = plot3(gv(1:n,1),gv(1:n,2),gv(1:n,3),'.'); % Plot example
axis tight manual                           % Locking axis size
ax = gca;                                   % Get the axis so
ax.NextPlot = 'replaceChildren';            % next plots use the same

% Let's record this to file
v = VideoWriter('3_interpolate_ventricle_evo.avi');
open(v);

% The video has 30 FPS and the recording is 5.39s long (that's what we read in the next line), so we get how many frames we want to plot. We also calculate how many data points won't be printed between two frames. Then the video will be "real time".
n_frames = floor(volcurve(size(volcurve,1),2)*30)+1;
n_skip = floor(size(volcurve,1)/(n_frames-1));

F(n_frames) = struct('cdata',[],'colormap',[]); % Struct to hold frames

for i = 1:n_frames
    [k,p] = which_plot(volcurve((i-1)*n_skip+1,1),indic);
    if (k>0)
        img_x = p*gv((n*(k-1)+1):(n*k),1) + (1-p)*gv((n*k+1):(n*(k+1)),1);
        img_y = p*gv((n*(k-1)+1):(n*k),2) + (1-p)*gv((n*k+1):(n*(k+1)),2);
        img_z = p*gv((n*(k-1)+1):(n*k),3) + (1-p)*gv((n*k+1):(n*(k+1)),3);
    else
        img_x = p*gv(1:n,1) + (1-p)*gv(n+1:2*n,1);
        img_y = p*gv(1:n,2) + (1-p)*gv(n+1:2*n,2);
        img_z = p*gv(1:n,3) + (1-p)*gv(n+1:2*n,3);
    end
    plot3(img_x, img_y, img_z,'.');
    drawnow
    frame = getframe(gcf);
    F(i) = frame;
    writeVideo(v,frame);
end

close(v);