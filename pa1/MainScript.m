is_polynomial = input('If equation is polynomial enter Y otherwise N : ' , 's');
if( is_polynomial == 'Y' );
    % Bairstow and muller method 
    order = input('Enter the Order of Polynomial : ');
    fprintf('Enter the coefficients of polynomial : \n');
    coeff = [];
    i=1;
    while i <= order+1
        temp = input('');
        coeff = [ coeff , temp ];
        i = i + 1;
    end
    fprintf( 'Enter any one of the following methods:\n 1) Muller \n 2) Bairstow\n' );
    method = input('Enter here : ' , 's' );
    if( strcmp(method ,'Muller') )
        Muller( coeff , order );
    end
    if( strcmp(method ,'Bairstow') )
        Bairstow( coeff , order ); 
    end
end
if ( is_polynomial == 'N' );
    %Bisection , Fixed point , Regula-Falsi , Newton-Raphson , Secant; 
    fprintf( 'Enter any one of the following methods:\n 1) Bisection \n 2) Regula_falsi \n 3) Fixed_point \n 4) Newton_Raphson \n 5) Secant \n ' );
    method = input('Enter here : ' , 's' );
    if( strcmp(method ,'Bisection') )
        Bisection();
    end
    if( strcmp(method ,'Fixed_point') )
        Fixed_point(); 
    end
    if( strcmp(method ,'Regula_falsi') )
        Regula_falsi();
    end
    if( strcmp(method ,'Newton_Raphson') )
        Newton_Raphson();
    end
    if( strcmp(method ,'Secant') )
        Secant();
    end
        
end
    