function Newton_Raphson  
    f = input('Enter the function : ' , 's');
    syms g(x)
    g(x) = f;
    fp = input('Enter the derivative of the function : ' , 's');
    syms gp(x)
    gp(x) = fp;
    lo =  int32( input('Enter first guess : ' ) );
    fprintf('Enter following three stopping criteria : \n');
    max_itr = input('Maximum itration number : ');
    max_conv_rel_err = input('Convergence Criteria for Relative Error (in %) : ');
    max_conv_rel_err = max_conv_rel_err/100;
    min_closeness_to_root = input('Closeness to Root : ');
    no_itr = 0 ;
    are = [ ];
    in = [ ];
    while no_itr <= max_itr 
        ln = lo - g(lo)/gp(lo);
        no_itr = no_itr + 1 ;
        are = [ are , abs( (ln-lo)/lo ) ];
        in = [ in , no_itr ];
        if  abs( (ln-lo)/lo ) < max_conv_rel_err
            fprintf('Convergence Relative error limit reached\n%.30f\n',ln);
            break;
        elseif abs( g(ln) ) < min_closeness_to_root
            fprintf('Closeness to root limit reached\n%.30f\n' ,ln);
            break;
        end
        lo = ln;
    end
    if no_itr > max_itr
        fprintf('Maximum itrations limit reached\n%.30f\n' ,ln);
    else
    end
    fplot( x , g(x) );
    figure(2)
    plot( in , are , '-o' ) , xlabel('X') , ylabel('Y') ;
end

