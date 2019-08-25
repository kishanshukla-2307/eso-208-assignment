function soln = Gauss_Elimination( A , b )
    n = size(A,1);
    soln = zeros(1,n);

    for k=1:n
        max=abs(A(k,k));
        rno=k;
        for i=k+1:n
            if max < abs(A(i,k))
                max = abs(A(i,k));
                rno = i;
            end
        end
        
        temp = b(rno);
        b(rno) = b(k);
        b(k) = temp;
        
        temp = A(k,:);
        A(k,:) = A(rno,:);
        A(rno,:) = temp;

        for i=k+1:n
            l = A(i,k)/A(k,k);
            for j=k+1:n
                A(i,j) = A(i,j) - l*A(k,j);
            end
            b(i) = b(i) - l*b(k);
            A(i,k)=0;
        end
    end
    soln(n) = b(n)/A(n,n);
    for i=n-1:-1:1
        sum=0;
        for j=i+1:n
            sum = sum + A(i,j)*soln(j);
        end
        soln(i) = (b(i)-sum)/A(i,i);
    end

end

