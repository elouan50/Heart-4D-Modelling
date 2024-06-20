clf; clear;

subject = 1;

path = strcat('..\data\subject',num2str(subject),'\FSI\displacement\');

intervol = readmatrix(strcat(path,'IntermediateVolumesForDeformation.csv'));

grid_velocity = cell(1,10);
for i = 1:10
    grid_velocity{i} = readmatrix(strcat(path,'GridVelocity_',num2str(i-1),'.csv'));
end

n = size(grid_velocity{1},1);
indic = intervol(:,1);

point1 = 61;
point2 = floor(rand()*n);
point3 = floor(rand()*n);

T1 = zeros(10,4);
T2 = zeros(10,4);
T3 = zeros(10,4);

for i=1:10
    T1(i,1:3) = grid_velocity{i}(point1 , 1:3);
    T1(i,4) = i;
    T2(i,1:3) = grid_velocity{i}(point2 , 1:3);
    T2(i,4) = i;
    T3(i,1:3) = grid_velocity{i}(point3 , 1:3);
    T3(i,4) = i;
end



tiledlayout(3,3);
nexttile;

plot(indic,T1(:,1),'*',color='red');
hold on;
for i = 1:length(indic)
    text(indic(i), T1(i,1), num2str(T1(i,4)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
hold off;
title("x-axis for point 1");
nexttile;

plot(indic,T2(:,1),'*',color='red');
hold on;
for i = 1:length(indic)
    text(indic(i), T2(i,1), num2str(T2(i,4)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
hold off;
title("x-axis for point 2");
nexttile;

plot(indic,T3(:,1),'*',color='red');
hold on;
for i = 1:length(indic)
    text(indic(i), T3(i,1), num2str(T3(i,4)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
hold off;
title("x-axis for point 3");
nexttile;

plot(indic,T1(:,2),'*',color='green');
hold on;
for i = 1:length(indic)
    text(indic(i), T1(i,2), num2str(T1(i,4)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
hold off;
title("y-axis for point 1");
nexttile;

plot(indic,T2(:,2),'*',color='green');
hold on;
for i = 1:length(indic)
    text(indic(i), T2(i,2), num2str(T2(i,4)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
hold off;
title("y-axis for point 2");
nexttile;

plot(indic,T3(:,2),'*',color='green');
hold on;
for i = 1:length(indic)
    text(indic(i), T3(i,2), num2str(T3(i,4)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
hold off;
title("y-axis for point 3");
nexttile;

plot(indic,T1(:,3),'*',color='blue');
hold on;
for i = 1:length(indic)
    text(indic(i), T1(i,3), num2str(T1(i,4)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
hold off;
title("z-axis for point 1");
nexttile;

plot(indic,T2(:,3),'*',color='blue');
hold on;
for i = 1:length(indic)
    text(indic(i), T2(i,3), num2str(T2(i,4)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
hold off;
title("z-axis for point 2");
nexttile;

plot(indic,T3(:,3),'*',color='blue');
hold on;
for i = 1:length(indic)
    text(indic(i), T3(i,3), num2str(T3(i,4)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
hold off;
title("z-axis for point 3");



