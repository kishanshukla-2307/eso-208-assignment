function periodic( DS )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n = size(DS,1);
lt = zeros(n-1);       %%   thomas variables
ut = zeros(n-1);
dt = zeros(n-1);
bt = zeros(n-1);

for i=1:n-2
    dt(i) = 2*(h(DS, i) + h(DS, i+1));
    if i==n-1
        ut(i) = 0;
    else
        ut(i) = h(DS, i+1);
    end
    if i==1
        lt(1) = 0;
    else 
        lt(i) = h(DS, i);
    end
    bt(i) = 6*(f(DS,i+2,i+1) - f(DS,i+1,i));
end

A = zeros(n-2,n-2);
for i=1:n-3
    A(i,i) = dt(i);
    A(i+1,i) = lt(i+1);
    A(i,i+1) = ut(i);
end
A(n-2,n-2) = dt(n-2);
A(1,n-2) = h(DS, 1);
A(n-2,1) = h(DS, n-1);
v = Gauss_Elimination( A , bt );
v = [v(n-2) v v(1)];
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
file = fopen( 'output(periodic_spline).txt', 'wt' );
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

