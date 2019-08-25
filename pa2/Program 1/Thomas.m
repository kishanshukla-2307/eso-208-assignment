function  Thomas()
    filename = input('Enter the input filename : ','s');
    fileID = fopen(filename,'r');
    n = fscanf( fileID , 'n = %f' , 1 );
    fgets(fileID);
    l = fscanf( fileID , '%f' , [1 n] );
    fgets(fileID);
    d = fscanf( fileID , '%f' , [1 n] );
    fgets(fileID);
    u = fscanf( fileID , '%f' , [1 n] );
    fgets(fileID);
    b = fscanf( fileID , '%f' , [1 n] );
    fclose(fileID);
    alpha = zeros(1,n);
    beta = zeros(1,n);
    x = zeros(1,n);

    for i=1:n
        if i==1
            alpha(i) = d(i);
            beta(i) = b(i);
            continue;
        end 

        alpha(i) = d(i) - (l(i)/alpha(i-1))*u(i-1);
        beta(i) = b(i) - (l(i)/alpha(i-1))*beta(i-1);
    end
    
    x(n) = beta(n)/alpha(n);
    for i=(n-1):-1:1
        x(i) = (beta(i) - u(i)*x(i+1))/alpha(i);
    end
    fileID = fopen('outputThomas.txt','w');
    fprintf(fileID, 'Solution is \r\n');
    fprintf(fileID, '\t%f \r\n',x);
    fclose(fileID);
end

