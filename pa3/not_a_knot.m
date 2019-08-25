function not_a_knot(x,y)

% filename=input('Enter file name: ','s');   
% filedata=textread(filename,'%f');
% A=filedata(1:end);
% n=length(A);
% A=reshape(A,2,n/2);
% x=A(1,:);
% y=A(2,:);
DS = [x y];
n=length(x)-1;

for i=1:1:n
    h(i)=x(i+1)-x(i);%h here is one forward as given in slides. Heree  it starts from h1
    fdd(i)=(y(i+1)-y(i))/h(i);%first divided difference
end
coeff=zeros(n+1,n+2);
for i=1:1:n-1
    coeff(i,n+2)=(6*fdd(i+1))-(6*fdd(i));
    coeff(i,i+1)=2*(h(i+1)+h(i));
    coeff(i,i)=h(i);
    coeff(i,i+2)=h(i+1);    
end
coeff(n,1)=h(2);
coeff(n,2)=-h(1)-h(2);
coeff(n,3)=h(1);
coeff(n+1,n)=-h(n-1)-h(n);
coeff(n+1,n+1)=h(n-1);
coeff(n+1,n-1)=h(n);
%v(i) is for second derivative at ith node
v=gauss_elimination2(coeff,n+1);
%u(i) is for first derivative at ith node
for i=1:1:n
    u(i)=-((h(i)/6)*v(i+1))-((h(i)*v(i))/3)+fdd(i);
end
u(n+1)=((v(n+1)*h(n))/3)+((v(n)*h(n))/6)+fdd(n);
for i=1:1:n
    t1=[1 -x(i)];
    t1=conv(t1,conv(t1,t1));
    t1=t1/h(i);
    t2= [1 -x(i+1)];
    t2=conv(t2,conv(t2,t2));
    t2=t2/h(i);
    q(i,:)=((v(i+1)/6)*(t1-[0 0 h(i) -h(i)*x(i)]))+((v(i)/6)*(-t2+[0 0 h(i) -h(i)*x(i+1)]))+[0 0 fdd(i) -fdd(i)*x(i)+y(i)];
end

figure 
for i=1:n-1
    x = DS(i,1):0.1:DS(i+1,1);
    plot( x, polyval(q(i,:),x) )
    hold on
end
scatter(DS(:,1),DS(:,2))
hold off
title('Natural Spline')
file = fopen( 'output(notaknot_spline).txt', 'wt' );
for i=1:n;
    fprintf(file,'%d ' ,q(i,:));
    fprintf(file,'\n');
end
fprintf(file,'\n first derivatives -> ');
fprintf(file,'%d ' ,u);

fprintf(file,'\n Second derivatives -> ');
fprintf(file,'%d ' ,v);
fclose(file);

% figure(1)
% 
% for i=1:n
%     fplot(poly2sym(q(i,:)),[x(i),x(i+1)],'b')
%     hold on
% end
% scatter(x,y)
% hold off
% title('NotAKnot spline')
% 
% 
% file = fopen( 'output(ntaknt_spline).txt', 'wt' );
% for i=1:n;
%     fprintf(file,'%d ' ,q(i,:));
%     fprintf(file,'\n');
% end
% fprintf(file,'\n first derivatives -> ');
% fprintf(file,'%d ' ,u);
% 
% fprintf(file,'\n Second derivatives -> ');
% fprintf(file,'%d ' ,v);



end
