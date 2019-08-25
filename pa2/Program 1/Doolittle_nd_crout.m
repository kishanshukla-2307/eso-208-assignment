function Doolittle_nd_crout
    filename = input('Enter the input filename : ','s');
    fileID = fopen(filename,'r');
    n = fscanf( fileID , 'n = %f' , 1 );
    fgets(fileID);
    A = fscanf( fileID , '%f' , [n n] );
    fclose(fileID);
    A = A';
    l = zeros([n n]);
    u = zeros([n n]);
    trans = eye(n,n);
    fprintf('Choose one of the following methods: \n1. Doolittle\n2. Crout\n');
    t = input('Enter 1 or 2\n');
    
    if t==1
        fileID = fopen('outputDoolittle.txt','w');
    elseif t==2
        fileID = fopen('outputCrout.txt','w'); 
    end
    
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
        fprintf(fileID,'\r\n%dth Step Pivoting : \r\n\r\n',i);
        fprintf(fileID,'\tRow interchange: %d <-> %d\r\n',i,rno);
        temp = A(:,cno);
        A(:,cno) = A(:,i);
        A(:,i) = temp;
        fprintf(fileID,'\tColumn interchange: %d <-> %d\r\n',i,cno);
    end
    if t==1
       for i=1:n
           l(i,i)=1;
       end
       for i=1:n
          for j=1:i-1
              sum=0;
              for k=1:j-1
                  sum = sum + l(i,k)*u(k,j);
              end
              l(i,j) = (A(i,j)-sum)/u(j,j);
          end
          for j=i:n
              sum=0;
              for k=1:i-1
                  sum = sum + l(i,k)*u(k,j);
              end
              u(i,j) = A(i,j) - sum;
          end
       end
    elseif t==2
       for i=1:n
           u(i,i)=1;
       end
       for j=1:n
          for i=1:j-1
              sum=0;
              for k=1:i-1
                  sum = sum + l(i,k)*u(k,j);
              end
              u(i,j) = (A(i,j)-sum)/l(i,i);
          end
          for i=j:n
              sum=0;
              for k=1:j-1
                  sum = sum + l(i,k)*u(k,j);
              end
              l(i,j) = A(i,j) - sum;
          end
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
    for i = 1:size(u,1)
        fprintf(fileID,'\t');
        for j=1:size(u,2)
            fprintf(fileID,'%f\t',u(i,j));
        end
            fprintf(fileID,'\r\n');
    end   
    fclose(fileID);
end

