function  Lagrange( DS )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    for i=1:size(DS,1)
        p = 1;
        for j=1:size(DS,1)
            if j~=i
                temp = [1 -DS(j,1)];
                p = conv(temp, p);
                p = p/(DS(i,1)-DS(j,1));
            end
        end
        p = p*DS(i,2);
        if i==1
            final_poly = p;
            continue;
        end
        final_poly = final_poly + p;
    end
    figure (1)
    scatter (DS(:,1), DS(:,2));
    x = min(DS(:,1)):0.1:max(DS(:,1));
    hold on
    plot( x, polyval(final_poly,x) )
    hold off
    title('Natural Spline'); 
    
    file = fopen( 'output(lagrange).txt', 'wt' );
    fprintf(file,'%d ' ,final_poly);
    fclose(file);
end

