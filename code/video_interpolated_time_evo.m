clf; clear;

subject = 1; % Can be 1,2,3
rectified = true; % Can be true or false

% Import data
path = strcat('..\data\subject',num2str(subject),'\FSI\displacement\');
intervol = readmatrix(strcat(path,'IntermediateVolumesForDeformation.csv'));
volcurve = readmatrix(strcat(path,'VolumeCurve.csv'));

grid_velocity = cell(1,10);
for i = 1:10
    grid_velocity{i} = readmatrix(strcat(path,'GridVelocity_',num2str(i-1),'.csv'));
end

% And set some local parameters

n = size(grid_velocity{i},1)/10;
indic = intervol(:,4);

% As seen before, the 10th volume indication is weird
% If set before, we rectify it here
if rectified
    indic(10) = indic(10) + 0.1;
    name = strcat(num2str(subject), '_interpolate_ventricle_evo_rectified.avi');
else
    name = strcat(num2str(subject), '_interpolate_ventricle_evo.avi');
end

% Define a fonction that'll be useful later
% Given a volume and a scale, we determine which ladder is to be used to
% best represent the volume, and a ratio to the next ladder.

function [i,p] = which_plot(volume, indic)
    i = 0;                              % Plots # varying from 0 to 9
    while (volume < indic(i+1) & i<9)   % Test lower boundary
        i = i+1;
    end
    if (i > 0)
        p = (volume-indic(i))/(indic(i)-indic(i+1)); % Linear ratio between two figs
    else
        p = (volume-indic(1))/(indic(1)-indic(2)); % If over the 0-boundary, we extrapolate thanks to the first two configurations
    end
end


% Preparations for a clean plotting
set(gcf, 'Position', get(0, 'Screensize')); % Big window
h = plot3(grid_velocity{1}(:,1),grid_velocity{1}(:,2),grid_velocity{1}(:,3),'.'); % Plot example
axis tight manual                           % Locking axis size
ax = gca;                                   % Get the axis so
ax.NextPlot = 'replaceChildren';            % next plots use the same

% Let's record this to a video file
v = VideoWriter(name);
open(v);


% The video has 30 FPS so acccordingly to the video duration, we get how many frames we want to plot.
% We also calculate how many data points won't be printed between two frames. Then the video will be "real time".
    
n_frames = floor(volcurve(size(volcurve,1),2)*30)+1;
n_skip = floor(size(volcurve,1)/(n_frames-1));

F(n_frames) = struct('cdata',[],'colormap',[]); % Struct to hold frames

% Matrix containing all positions
output = cell(2,n_frames);

% Iteration on all frames: refresh the position for every frame

for i = 1:n_frames
    output{1,i} = volcurve((i-1)*n_skip+1,2); % Time stamp for position

    [k,p] = which_plot(volcurve((i-1)*n_skip+1,1),indic); % Get # and rate
    if (k>0)                                              % If interpolation
        img_x = p*grid_velocity{k}(:,1) + (1-p)*grid_velocity{k+1}(:,1);
        img_y = p*grid_velocity{k}(:,2) + (1-p)*grid_velocity{k+1}(:,2);
        img_z = p*grid_velocity{k}(:,3) + (1-p)*grid_velocity{k+1}(:,3);
    else                                                  % If extrapolation
        img_x = p*grid_velocity{1}(:,1) + (1-p)*grid_velocity{2}(:,1);
        img_y = p*grid_velocity{1}(:,2) + (1-p)*grid_velocity{2}(:,2);
        img_z = p*grid_velocity{1}(:,3) + (1-p)*grid_velocity{2}(:,3);
    end

    % Record position
    output{2,i} = [img_x, img_y, img_z];

    % Plot the frame
    plot3(img_x, img_y, img_z,'.');
    drawnow

    % And record it
    frame = getframe(gcf);
    F(i) = frame;
    writeVideo(v,frame);
end

close(v);



% Record the video as a CSV file.
% /!\ Costly operation, uncomment only if needed (make take a few minutes)

% writecell(output, strcat(num2str(subject),'_basic_ventricle_evo.csv'));
