function Bisection()  
    f = input('Enter the function : ' , 's');
    syms g(x)
    g(x) = f;
    l =  double( input('Enter first guess : ' ) );
    h =  double( input('Enter second guess : ' ) );
    mid_val = ( l+h )/2;
    fprintf('Enter following three stopping criteria : \n');
    max_itr = input('Maximum itration number : ');
    max_conv_rel_err = input('Convergence Criteria for Relative Error : ');
    max_conv_rel_err = max_conv_rel_err/100;
    min_closeness_to_root = input('Closeness to Root : ');
    no_itr = 0 ;
    are = [ ];
    in = [ ];
    while no_itr <= max_itr 
        mid_val = ( l + h )/2;
        no_itr = no_itr + 1 ;
        are = [ are , abs( l - h ) ];
        in = [ in , no_itr ];
        if  abs( mid_val - h ) < max_conv_rel_err
            fprintf('Convergence Relative error limit reached\n%d\n',mid_val);
            break;
        elseif abs( g(mid_val) ) < min_closeness_to_root
            fprintf('Closeness to root limit reached\n%d\n' ,mid_val);
            break;
        end
        if g(mid_val)*g(h) < 0
            l = mid_val;
        elseif g(mid_val)*g(l) < 0
            h = mid_val;
        end
    end
    if no_itr > max_itr
        fprintf('Maximum itrations limit reached\n%d\n' ,mid_val);
    else
    end
    fplot( x , g(x) );
    figure(2)
    plot( in , are , '-o' ) , xlabel('X') , ylabel('Y') ;
end

