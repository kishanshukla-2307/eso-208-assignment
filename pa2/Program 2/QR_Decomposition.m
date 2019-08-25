function QR_Decomposition
    filename = input('Enter the input filename : ','s');
    fileID = fopen(filename,'r');
    n = fscanf( fileID , 'n = %f' , 1 );
    fgets(fileID);
    A = fscanf( fileID , '%f' , [n n] );
    fgets(fileID);
    tolerance = fscanf(fileID, '%f' , 1 );
    tolerance = tolerance/100;
    fclose(fileID);
    A = A';
    A1 = A;
    
    q = zeros([n n]);
    r = zeros([n n]);
    z = zeros([n 1]);
    err = 1;
     while err >= tolerance
        euc_norm = 0;
        sum=0;
        for l=1:n
            sum = sum + A1(l,1)*A1(l,1);
        end
        euc_norm = sqrt(sum);
        q(:,1) = A1(:,1) / euc_norm;
        for k=2:n
            sum2 = zeros([n 1]);
            for l=1:k-1
                sum2 = sum2 + (A1(:,k)'*q(:,l))*q(:,l);
            end
            z = A1(:,k) - sum2;
            sum=0;
            for l=1:n
                sum = sum + z(l)*z(l);
            end
            euc_norm = sqrt(sum);
            q(:,k) = z / euc_norm;
        end

        for i=1:n
            for j=1:n
                r(i,j) = q(:,i)' * A1(:,j);
            end
        end
        
        A2 = r*q;
        max = 0;
        for i=1:n
            if max < abs( (A2(i,i)-A1(i,i))/A1(i,i) )
                max = abs( (A2(i,i)-A1(i,i))/A1(i,i) );
            end
        end
        err=max;
        A1 = A2;
     end
     fileID = fopen('outputQRDecomposition.txt','w');
     fprintf(fileID,'Eigen values are :\r\n');
     for i=1:n
         fprintf(fileID,'%d. %d\r\n',i,A1(i,i));
     end
     fclose(fileID);
end

