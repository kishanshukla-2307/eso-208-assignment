function Bairstow( p , order )
    q = fliplr(p) ;
    syms g(x)
    q = poly2sym(q);
    g(x) = q ;
    % taking other inputs
    r = input('Enter the value of r :  ');
    s = input('Enter the value of s :  '); 
    max_ite = input('Enter the Number of maximum iterations :  ');
    rel_err = input('Enter the maximum relative error (in %) : ');
    tolerance = input('Enter the closeness to root limit :  ');
    rootno=1;
    are = []; % array to store rel. apprx error after every iteration
    while length(p) > 2 % if the given polynomial is not linear
        n = length(p);  % number of cofficient / degree +1
        b = zeros(n);
        c = zeros(n-1);
        dr = 0;    % error in r
        ds = 0;    % error in s
        i = 1;
        while i< max_ite;

            b(n) = p(n);
            c(n-1) = b(n);
            b(n-1) = p(n-1) + r*b(n);
            c(n-2) = b(n-1) + r*c(n-1);

            for j= n-2:-1:1 ;
                b(j) = p(j) + r*b(j+1) + s*b(j+2);
                c(j) = b(j+1)+ r*c(j+1) + s*c(j+2);
            end ;
            dr = ((c(1)*b(2)-c(2)*b(1))/(c(2)*c(2)-c(1)*c(3)));
            ds= ((c(3)*b(1)-c(2)*b(2))/(c(2)*c(2)-c(1)*c(3)));
            s = s + dr;
            r = r + ds;

            err1 = abs(dr*100/r);
            err2 = abs(ds*100/s);
            are = [are, max(err1,err2)];
            
            if err1 <= rel_err && err2 <= rel_err  &&  b(1) <= tolerance && b(2) <= tolerance
                fprintf('Convergence of roots relative error reached \n')
                fprintf('root number %d is ', rootno)
                fprintf('%f%+fi\n', real((r + sqrt(r*r + 4*s))/2), imag( (r + sqrt(r*r + 4*s))/2 ) );
                fprintf('root number %d is ', rootno+1)
                fprintf('%f%+fi\n', real((r - sqrt(r*r + 4*s))/2), imag( (r - sqrt(r*r + 4*s))/2 ) );
                rootno=rootno+2;
                break;
            end;
            i=i+1;
        end

        % if maximum no. of iterations is done
        if i > max_ite
            fprintf('Convergence of maximum iteration reached \n')
            fprintf('root number %d is ', rootno)
            fprintf('%f%+fi\n', real((r + sqrt(r*r + 4*s))/2), imag( (r + sqrt(r*r + 4*s))/2 ) );
            fprintf('root number %d is ', rootno+1)
            fprintf('%f%+fi\n', real((r - sqrt(r*r + 4*s))/2), imag( (r - sqrt(r*r + 4*s))/2 ) );
            rootno=rootno+2;
        end

        % upating the polynomial after division
        p = b(3:n);

    end

    if length(p)==2
        fprintf('root number %d is %f ',rootno, -p(1)/p(2))
    end

    % plot of f(x) v/s x
    figure(1)
    fplot(g)
    grid
    title('Plot of f(x) v/s x');
    axis([-50 50 -10 inf])
    xlabel('x');
    ylabel('f(x)');
    ite=[1:length(are)];
    
    % plot of approx. relative error v/s iteration number
    figure(2)
    plot(ite, are,'-o')
    title('Plot of approx. relative error (in %) v/s iteration number ');
    xlabel('Iteration Number');
    ylabel('Approximate Relative Error (in %)');

end

