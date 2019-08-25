function Clamped( DS )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n = size(DS,1);
lt = zeros(n-1);       %%   thomas variables
ut = zeros(n-1);
dt = zeros(n-1);
bt = zeros(n-1);
alpha = input('Enter the value of alpha : ');
beta = input('Enter the value of beta : ');
for i=1:n-2
    dt(i) = 2*(h(DS, i) + h(DS, i+1));
    ut(i) = h(DS, i+1);
    lt(i) = h(DS, i);
    bt(i) = 6*(f(DS,i+2,i+1) - f(DS,i+1,i));
end

A = zeros(n,n);
A(n-1,:) = [2 1 zeros(1,n-2)];
A(n,:) = [zeros(1,n-2) 1 2];
bt(n-1) = (6/h(DS, 1))*(f(DS, 2, 1) - alpha);
bt(n) = (6/h(DS, n-2))*(beta - f(DS, n, n-1));
for i=1:n-2
    A(i,i) = lt(i);
    A(i,i+1) = dt(i);
    A(i,i+2) = ut(i);
end
v = Gauss_Elimination( A , bt );
q = zeros(n-1,4);
u = zeros(n);

for i=1:n-1
    temp1 = [1 -DS(i,1)];
    temp2 = conv(temp1, conv(temp1, temp1))/h(DS, i);
    temp1 = h(DS, i)*temp1;
    temp2 = temp2 - [zeros(2,1);temp1']';
    temp2 = v(i+1)*temp2/6;
    temp3 = [1 -DS(i+1,1)];
    temp4 = -conv(temp3, conv(temp3, temp3))/h(DS, i);
    temp3 = h(DS, i)*temp3;
    temp4 = temp4 + [zeros(2,1);temp3']';
    temp4 = v(i)*temp4/6;
    q(i,:) = temp2 + temp4;
    temp1 = DS(i+1,2)*[1 -DS(i,1)]/h(DS,i) - DS(i,2)*[1 -DS(i+1,1)]/h(DS,i);
    q(i,:) = q(i,:) + [zeros(2,1);temp1']';
end
for i=1:n-1
    u(i) = polyval( polyder(q(i,:)), DS(i,1));
end
u(n) = polyval( polyder(q(n-1,:)), DS(n,1));
u = u(:,1);

figure 
for i=1:n-1
    x = DS(i,1):0.1:DS(i+1,1);
    plot( x, polyval(q(i,:),x) )
    hold on
    
end
scatter(DS(:,1),DS(:,2))
hold off
title('Natural Spline')

file = fopen( 'output(clamped_spline).txt', 'wt' );
for i=1:n-1;
    fprintf(file,'%d ' ,q(i,:));
    fprintf(file,'\n');
end
fprintf(file,'\n first derivatives -> ');
fprintf(file,'%d ' ,u);

fprintf(file,'\n Second derivatives -> ');
fprintf(file,'%d ' ,v);
fclose(file);

end



