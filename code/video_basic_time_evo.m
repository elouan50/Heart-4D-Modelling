clf; clear;

subject = 1; % Can be 1,2,3

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


% Define a fonction that'll be useful later
% Given a volume and a scale, we determine which ladder is floor approximation

function i = which_plot(volume, indic)
    i = 1;                   
    while (volume < indic(i) & i<10)
        i = i+1;
    end
end

% Preparations for a clean plotting
set(gcf, 'Position', get(0, 'Screensize')); % Big window
h = plot3(grid_velocity{1}(:,1),grid_velocity{1}(:,2),grid_velocity{1}(:,3),'.'); % Plot example
axis tight manual                           % Locking axis size
ax = gca;                                   % Get the axis so
ax.NextPlot = 'replaceChildren';            % next plots use the same

% Let's record this to a video file
v = VideoWriter(strcat(num2str(subject),'_basic_ventricle_evo.avi'));
open(v);


% The video has 30 FPS so acccordingly to the video duration, we get how many frames we want to plot.
% We also calculate how many data points won't be printed between two frames. Then the video will be "real time".

n_frames = floor(volcurve(size(volcurve,1),2)*30)+1;
n_skip = floor(size(volcurve,1)/n_frames-1);

F(n_frames) = struct('cdata',[],'colormap',[]); % Struct to hold frames

% Matrix containing all positions
output = cell(2,n_frames);

% Iteration on all frames: refresh the position for every frame

for i = 1:n_frames
    output{1,i} = volcurve((i-1)*n_skip+1,2); % Time stamp for position

    k = which_plot(volcurve((i-1)*n_skip+1,1),indic); % Get plot #

    % Get values
    img_x = grid_velocity{k}(:,1);
    img_y = grid_velocity{k}(:,2);
    img_z = grid_velocity{k}(:,3);

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
