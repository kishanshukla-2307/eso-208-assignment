function Muller( coeff , order )
    x1 = input('Enter first guess : ');
    x2 = input('Enter second guess : ');
    x3 = input('Enter third guess : ');
    fprintf('Enter following three stopping criteria : \n');
    max_itr = input('Maximum itration number : ');
    max_conv_rel_err = input('Convergence Criteria for Relative Error : ');
    max_conv_rel_err = max_conv_rel_err/100;
    min_closeness_to_root = input('Closeness to Root : ');
    coeff = fliplr(coeff) ;
    syms g(x)
    q = poly2sym(coeff);
    g(x) = q ;
    no_itr = 0 ;
    are = [ ];
    in = [ ];
    while no_itr <= max_itr
        c = polyval( coeff , x3);
        temp1 = ( polyval( coeff , x3)-polyval( coeff , x2) )/( x3-x2 );
        temp2 = ( polyval( coeff , x3)-polyval( coeff , x1) )/( x3-x1 );
        a = ( temp1 - temp2 ) / ( x2 - x1 );
        b = temp2 + a * ( x3 - x1 );
        x_new = x3 + (-b + sqrt( b^2 - 4*a*c )) / ( 2*a );
        no_itr = no_itr + 1 ;
        are = [ are , abs( (x_new - x3)/x3 ) ];
        in = [ in , no_itr ];
        if  abs( (x_new - x3)/x3 ) < max_conv_rel_err
            fprintf('Convergence Relative error limit reached\n');
            fprintf('Root is %f%+fi\n', real( x3 ), imag( x3 ) );
            break;
        elseif abs( polyval( coeff , x3) ) < min_closeness_to_root
            fprintf('Closeness to root limit reached\n');
            fprintf('Root is %f%+fi\n', real( x3 ), imag( x3 ) );
            break;
        end
        x1 = x2;
        x2 = x3;
        x3 = x_new;
    end
    if no_itr > max_itr
        fprintf('Maximum itrations limit reached\n');
        fprintf('Root is %f%+fi\n', real( x3 ), imag( x3 ) );
    else
    end
    
    figure(1)
    fplot(g)
    grid
    title('Plot of f(x) v/s x');
    axis([-50 50 -10 inf])
    xlabel('x');
    ylabel('f(x)');
    
    figure(2)
    plot( in , are , '-o' )
    title('Plot of approx. relative error (in %) v/s iteration number ');
    xlabel('Iteration Number');
    ylabel('Approximate Relative Error (in %)');
end
