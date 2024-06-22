clf; clear;

subject = 1;

path = strcat('subject',num2str(subject),'\FSI\displacement\');

intervol = readmatrix(strcat(path,'IntermediateVolumesForDeformation.csv'));
indic = intervol(:,1);

x = (1:10)';

p = polyfit(x(1:9),indic(1:9),1);

x_10 = 10*p(1)+p(2)

hold on;
plot(indic,'*');
plot(p(1)*x+p(2));
plot(10,x_10,'+',color="black");
legend('labeled volumes','linear regression','determined value x\_10');
hold off;