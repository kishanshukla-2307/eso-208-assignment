function Gauss_Jordon
    filename = input('Enter the input filename : ','s');
    fileID = fopen(filename,'r');
    n = fscanf( fileID , 'n = %f' , 1 );
    fgets(fileID);
    A = fscanf( fileID , '%f' , [n n] );
    fclose(fileID);
    A = A';
    
    A = [A eye(n)];
    
    for k=1:n
        for j=k+1:2*n
            A(k,j) = A(k,j) / A(k,k);
        end
        A(k,k) = 1;
        for i=1:n
            if i==k
                continue;
            end
            f = A(i,k);
            for j=k:2*n
                A(i,j) = A(i,j) - f*A(k,j);
            end
        end
    end
    invA = A(1:n , n+1:2*n);
    fileID = fopen('outputGaussJordon.txt','w');
    fprintf(fileID, 'Inverse is \r\n');
    for i = 1:size(invA,1)
        fprintf(fileID,'\t');
        for j=1:size(invA,2)
            fprintf(fileID,'%f\t',invA(i,j));
        end
            fprintf(fileID,'\r\n');
    end 
    fclose(fileID);
end

