function Fixed_point
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    f = input('Enter the function : ' , 's');
    syms g(x)
    g(x) = f;
    xk =  double( input('Enter starting guess : ' ) );
    fprintf('Enter following three stopping criteria : \n');
    max_itr = input('Maximum itration number : ');
    max_conv_rel_err = input('Convergence Criteria for Relative Error(in %) : ');
    max_conv_rel_err = max_conv_rel_err/100;
    min_closeness_to_root = input('Closeness to Root : ');
    no_itr = 0 ;
    are = [ ];
    in = [ ];
    while no_itr <= max_itr 
        no_itr = no_itr + 1 ;
        are = [ are , abs( (xk - g(xk) )/xk) ];
        in = [ in , no_itr ];
        if  abs( ( xk - g(xk) )/g(xk) )< max_conv_rel_err
            fprintf('Convergence Relative error limit reached\n%f\n',xk);
            break;
        elseif abs( g(xk)-xk ) < min_closeness_to_root
            fprintf('Closeness to root limit reached\n%f\n' ,xk);
            break;
        end
        xk = g(xk);
    end
    if no_itr > max_itr
        fprintf('Maximum itrations limit reached\n%d\n' ,xk);
    else
    end
    fplot( x , g(x) );
    figure(2)
    plot( in , are , '-o' ) , xlabel('X') , ylabel('Y') ;


end

