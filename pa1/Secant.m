function Secant  
    f = input('Enter the function : ' , 's');
    syms g(x)
    g(x) = f;
    l =  int32( input('Enter first guess : ' ) );
    h =  int32( input('Enter second guess : ' ) );
    fprintf('Enter following three stopping criteria : \n');
    max_itr = input('Maximum itration number : ');
    max_conv_rel_err = input('Convergence Criteria for Relative Error (in %) : ');
    max_conv_rel_err = max_conv_rel_err/100;
    min_closeness_to_root = input('Closeness to Root : ');
    no_itr = 0 ;
    are = [ ];
    in = [ ];
    while no_itr <= max_itr 
        new = l - g(l)*(l-h)/(g(l)-g(h));
        no_itr = no_itr + 1 ;
        are = [ are , abs( l - h ) ];
        in = [ in , no_itr ];
        if  abs( l - h ) < max_conv_rel_err
            fprintf('Convergence Relative error limit reached\n%.10f\n',new);
            break;
        elseif abs( g(new) ) < min_closeness_to_root
            fprintf('Closeness to root limit reached\n%.10f\n' ,new);
            break;
        end
        h = l;
        l = new;
    end
    if no_itr > max_itr
        fprintf('Maximum itrations limit reached\n%.10f\n' ,new);
    else
    end
    fplot( x , g(x) );
    figure(2)
    plot( in , are , '-o' ) , xlabel('X') , ylabel('Y') ;
end

