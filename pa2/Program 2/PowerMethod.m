function PowerMethod
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
    
    z1 = ones([1 n]);
    z2 = zeros([1 n]);
    z1(2:n) = 0;
    euc_norm = 1;
    y = zeros([1 n]);
    err = 0;
    lbda1 = 0;
    lbda2 = 0;
    
    y = z1 / euc_norm;
    z2 = A*y';
    lbda1 = y * z2;
    z1 = z2;
    while 1
        sum=0;
        for k=1:n
            sum = sum + z1(k)*z1(k);
        end
        euc_norm = sqrt(sum);
        y = z1 / euc_norm;
        z2 = A*y;
        lbda2 = y' * z2;
        err = abs( (lbda2 - lbda1)/lbda1 );
        if err <= tolerance
            break;
        end
        z1 = z2;
        lbda1 = lbda2;
    end
    fileID = fopen('outputPowerMethod.txt','w');
    fprintf(fileID,'Maximum Eigenvalue is %f\r\n',lbda2);
    fclose(fileID);
end

