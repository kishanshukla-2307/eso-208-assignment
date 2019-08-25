function least_square_approx(x,y)

% filename=input('Enter file name: ','s');   
% filedata=textread(filename,'%f');
% A=filedata(1:end);
% n=length(A);
% A=reshape(A,2,n/2);
% x=A(1,:);
% y=A(2,:);
n=length(x);
DS = [x y];
order=input('Enter order of polynomial ');
is_intercept=input('Choose whether intercept is zero [Y/N] ? ','s');
if is_intercept=='Y'
    flag=0;
else
    flag=1;
end
if flag==1
    coeff=zeros(order+1,order+2);
    for i=0:1:order
        for j=0:1:order
            sum=0;
            for k=1:1:n
                sum=sum+power(x(k),(i+j));
            end
            coeff(i+1,j+1)=sum;
        end
    end
    for i=0:1:order
        sum=0;
        for k=1:1:n
            sum=sum+(power(x(k),i)*y(k));
        end
        coeff(i+1,order+2)=sum;
    end
    
    v=fliplr(gauss_elimination2(coeff, order+1));
    
    
elseif flag==0
    coeff=zeros(order,order+1);
    for i=1:1:order
        for j=1:1:order
            sum=0;
            for k=1:1:n
                sum=sum+power(x(k),(i+j));
            end
            coeff(i,j)=sum;
        end
    end
    for i=1:1:order
        sum=0;
        for k=1:1:n
            sum=sum+(power(x(k),i)*y(k));
        end
        coeff(i,order+1)=sum;
    end
    
    v=fliplr(gauss_elimination(coeff, order));
    v=[v,0];
    
end

mean_y = mean(y);
for i=1:n
    y_new(i)=polyval(v,x(i));
end
sigma=0;
error=0;


for i=1:n
    sigma=sigma+(mean_y-y(i))^2;
    error=error+(y(i)-y_new(i))^2;
end
r=(sigma-error)/sigma;

file = fopen( 'output(least square).txt', 'wt' );
fprintf(file,'%d',v);
fprintf(file,'r^2 is : %f',r);

% fplot(p,[x(1),x(end)])
% hold on
% scatter(x,y)
% hold off

figure
plot( x, polyval(v,x) )
hold on
scatter(DS(:,1),DS(:,2))
hold off
title('Least Square')



end