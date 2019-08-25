function Cholesky
    filename = input('Enter the input filename : ','s');
    fileID = fopen(filename,'r');
    n = fscanf( fileID , 'n = %f' , 1 );
    fgets(fileID);
    A = fscanf( fileID , '%f' , [n n] );
    fclose(fileID);
    A = A';
    l = zeros([n n]);
    
    fileID = fopen('outputCholesky.txt','w');
    
    for i=1:n
        max = A(i,i);
        rno = i;
        cno = i;
        for j=i:n
            for k=i:n
                if A(j,k) > max
                    max = A(j,k);
                    rno = j;
                    cno = k;
                end
            end
        end
        temp = A(rno,:);
        A(rno,:) = A(i,:);
        A(i,:) = temp;
        fprintf(fileID,'%dth Step Pivoting : \r\n\r\n',i);
        fprintf(fileID,'\tRow interchange: %d <-> %d\r\n',i,rno);
        temp = A(:,cno);
        A(:,cno) = A(:,i);
        A(:,i) = temp;
        fprintf(fileID,'\tColumn interchange: %d <-> %d\r\n',i,cno);
    end
    
    for j=1:n
        for i=j:n
            sum = 0;
            if i == j
                for k=1:j-1
                    sum = sum + l(j,k)*l(j,k);
                end
                l(i,i) = sqrt( A(j,j) - sum );
                continue;
            end
            for k=1:j-1
                sum = sum + l(i,k)*l(j,k);
            end
            l(i,j) = (A(i,j) - sum)/l(j,j);
        end
    end
    fprintf(fileID, '\r\nL is \r\n');
    for i = 1:size(l,1)
        fprintf(fileID,'\t');        
        for j=1:size(l,2)
            fprintf(fileID,'%f\t',l(i,j));
        end
            fprintf(fileID,'\r\n');
    end
    fprintf(fileID, '\r\nU is \r\n');
    for i = 1:size(l',1)
        fprintf(fileID,'\t');
        for j=1:size(l',2)
            fprintf(fileID,'%f\t',l(j,i));
        end
            fprintf(fileID,'\r\n');
    end   
    fclose(fileID);
end
