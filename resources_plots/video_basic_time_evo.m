clf; clear;

path = '..\data\subject1\FSI\displacement\';

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

function i = which_plot(volume, indic)
    i = 0;                              % Plots # varying from 0 to 9
    while (volume < indic(i+1) & i<9)   % Table indexes from 1 to 10
        i = i+1;
    end
end

% Preparations for a clean plotting
set(gcf, 'Position', get(0, 'Screensize')); % Big window
h = plot3(gv(1:n,1),gv(1:n,2),gv(1:n,3),'.'); % Plot example
axis tight manual                           % Locking axis size
ax = gca;                                   % Get the axis so
ax.NextPlot = 'replaceChildren';            % next plots use the same

% Let's record this to file
v = VideoWriter('x_basic_ventricle_evo.avi');
open(v);

% The video has 30 FPS and the recording is 5.39s long (that's what we read in the next line), so we get how many frames we want to plot. We also calculate how many data points won't be printed between two frames. Then the video will be "real time".
n_frames = floor(volcurve(size(volcurve,1),2)*30)+1;
n_skip = floor(size(volcurve,1)/n_frames-1);

F(n_frames) = struct('cdata',[],'colormap',[]); % Struct to hold frames

for i = 1:n_frames
    k = which_plot(volcurve((i-1)*n_skip+1,1),indic);
    plot3(gv((n*k+1):(n*(k+1)),1), gv((n*k+1):(n*(k+1)),2), gv((n*k+1):(n*(k+1)),3),'.');
    drawnow
    frame = getframe(gcf);
    F(i) = frame;
    writeVideo(v,frame);
end

close(v);