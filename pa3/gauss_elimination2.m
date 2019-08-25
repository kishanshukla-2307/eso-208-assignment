function x=gauss_elimination2(A,n)
%Gauss Elimination Algorithm
a=A;
x=zeros(1,n);
for k=1:1:n
    max_row=k;
    for row=k+1:1:n
        if abs(A(row,k))>abs(A(max_row,k))
           max_row=row;
        end
    end
    t=A(max_row,:);
    A(max_row,:)=A(k,:);
    A(k,:)=t;
    for i=k+1:1:n
        for j=k+1:1:n+1
        A(i,j) = A(i,j)-(A(k,j)*(A(i,k)/A(k,k)));
        end
        A(i,k)=0;
    end
end
for i=n:-1:1
    sum=0;
    for j=n:-1:(i+1)
        sum = sum + (A(i,j)*x(j));
    end
    x(i)=(A(i,(n+1))-sum)/A(i,i);
end
end