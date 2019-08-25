fprintf('1. Solve a System of Equation\n2. Perform a LU Decomposition\n3. Perform a Matrix Inversion\n')
task = input('Enter 1 , 2 or 3 : ');
if task == 1
    method = input('Is system tri-diagonal, enter Y or N : ','s');
    if method == 'Y'
        Thomas();
    elseif method == 'N'
        Gauss_Elimination();
    end
elseif task ==2
    method = input('Is matrix symmetric and positive definite, enter Y or N : ','s');
    if method == 'Y'
        Cholesky();
    elseif method == 'N'
        Doolittle_nd_crout()
    end
elseif task ==3
    Gauss_Jordon();
end