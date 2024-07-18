clf; clear;

subject = 1; % Can be 1,2,3

% Importing files for data
path = strcat('..\data\subject',num2str(subject),'\FSI\displacement\');

% Import data
intervol = readmatrix(strcat(path,'IntermediateVolumesForDeformation.csv'));
indic = intervol(:,1);

% x-axis
x = (1:10)';

% Calculate coefficients for linear regression
p = polyfit(x(1:9),indic(1:9),1);

x_10 = 10*p(1)+p(2);                 % The corrected value

disp(strcat("Old value for 10: ", num2str(indic(10)) ,", new value for 10: ",num2str(x_10)));

% Plot graph
hold on;
plot(indic,'*');
plot(p(1)*x+p(2));
plot(10,x_10,'+',color="black");
legend('labeled volumes','linear regression','determined value x\_10');
hold off;