h = input('Enter the grid size: ');
method = input('Enter 1 for Backward diff method or 2 for ghost node: ');
b = 0;
l = 2;
n = l/h;
y1 = input('Enter function value at starting point: ');
b = input('Enter derivative value at end point: ');
alpha = zeros(1,n-1);
beta = zeros(1,n-1);
gamma = zeros(1,n-1);
s = zeros(1,n-1);
% p(x) = 1;
% q(x) = -(x+3)/(x+1);
% r(x) = (x+3)/((x+1)*(x+1));
% f(x) = 2*(x+1)+3*(r(x))
temp = [];
for i=1:n-1
    x = h*i;
    temp = [temp x];
    alpha(i) = 1/(h*h) +((x+3)/(x+1))/(2*h);
    beta(i) = -2*(1)/(h*h) + (x+3)/((x+1)*(x+1));
    gamma(i) = 1/(h*h) -((x+3)/(x+1))/(2*h);
    s(i) = 2*(x+1)+3*((x+3)/((x+1)*(x+1)));
end
s(1) = s(1) - alpha(1)*y1;
if method == 1
    alpha(n-1) = alpha(n-1) - gamma(n-1)/3;
    beta(n-1) = beta(n-1) + 4*gamma(n-1)/3;
    s(n-1) = s(n-1) - 2*gamma(n-1)*b*h/3;
    alpha(1) = 0;
    gamma(n-1) = 0;
    y = Thomas(alpha, beta, gamma, s, n-1);
    temp1 = 2*b*h/3 + 4*y(n-1)/3 - y(n-2)/3;
    y = [y1 y temp1];
    file = fopen( 'output(central_diff).txt', 'wt' );
    fprintf(file,'X    temperature\n');
    temp = [0 temp n*h];
    for i=1:n+1
        fprintf(file,'%f    %f\n',temp(i),y(i));
    end
    scatter(temp, y);
elseif method == 2
    x = n*h;
    temp1 = 1/(h*h) -(-(x+3)/(x+1))/(2*h);
    temp2 = 1/(h*h) +(-(x+3)/(x+1))/(2*h);
    alpha = [alpha  temp1+temp2];
    beta = [beta ,-2*(1)/(h*h)+(x+3)/((x+1)*(x+1))];
    gamma = [gamma,1/(h*h)-((x+3)/(x+1))/(2*h)];
    s = [s, 2*(x+1)+3*((x+3)/((x+1)*(x+1)))-2*b*h*(gamma(n))];
    alpha(1) = 0;
    gamma(n) = 0;
    y = Thomas(alpha, beta, gamma, s, n);
    y = [y1 y];
    file = fopen( 'output(central_diff).txt', 'wt' );
    fprintf(file,'X    temperature\n');
    temp = [0 temp n*h];
    for i=1:n+1
        fprintf(file,'%f    %f\n',temp(i),y(i));
    end
    scatter(temp, y);
end
