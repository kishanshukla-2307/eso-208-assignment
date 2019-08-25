function Regula_falsi ()
    f = input('Enter the function : ' , 's');
    syms g(x)
    g(x) = f;
    l = input('Enter first guess : ' );
    h = input('Enter second guess : ' );
    while g(l)*g(h) > 0
        fprintf('Inputs given are not satisfying required condition!! Please try again.\n');
        l = input('Enter first guess : ' );
        h = input('Enter second guess : ' );
    end
    if g(l)==0
        fprintf('%f given as input is root of the function\n',l);
    elseif g(h)==0
        fprintf('%f given as input is root of the function\n',h);
    end
    fprintf('Enter following three stopping criteria : \n');
    max_itr = input('Maximum itration number : ');
    max_conv_rel_err = input('Convergence Criteria for Relative Error (in %) : ');
    max_conv_rel_err = max_conv_rel_err/100;
    min_closeness_to_root = input('Closeness to Root : ');
    no_itr = 0 ;
    are = [];
    in = [];
    last = l;
    while no_itr < max_itr 
        curr = l - g(l)*(l-h)/(g(l)-g(h));
        no_itr = no_itr + 1;
        are = [ are , abs( curr - last )/last ];
        in = [ in , no_itr ];
        if  abs( ( curr - last )/last ) <= max_conv_rel_err
            fprintf('Convergence Relative error limit reached\n%.10f\n',curr);
            break;
        elseif abs( g(curr) ) <= min_closeness_to_root
            fprintf('Closeness to root limit reached\n%.10f\n' ,curr);
            break;
        end
        last = curr;
        if g(curr)*g(h) < 0
            l = curr;
        elseif g(curr)*g(l) < 0
            h = curr;
        end
    end
    if no_itr >= max_itr
        fprintf('Maximum itrations limit reached\n%.10f\n' ,curr);
    end
    fplot( x , g(x) );
    figure(2)
    plot( in , are , '-o' ) , xlabel('X') , ylabel('Y') ;
end

