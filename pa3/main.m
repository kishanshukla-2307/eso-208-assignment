filename = input('Enter the input filename : ','s');
fileID = fopen( filename, 'r');
n = fscanf( fileID, 'n = %f', 1);
fgets(fileID);
DS = zeros(n, 2);
DS = fscanf(fileID, '%f,%f', [2 n] );
DS = DS';
fclose(fileID);
fprintf('What do you want to do?\nA. fit a least square polynomial\n')
fprintf('B. Fit a lagrange interpolation polynomial\n')
fprintf('C. Fit cubic splines\n')
choice = input('Enter A, B or C : ','s');
if choice == 'A'
    least_square_approx(DS(:,1), DS(:,2));
elseif choice == 'B'
    Lagrange( DS );
elseif choice == 'C'
    t = input('Choose one :\nA. Natural Spine\nB. Not-a-knot\nC.Periodic\nD.Clamped Spine\n','s');
    if t == 'A'
        naturalspline(DS);
    elseif t == 'B'
        not_a_knot(DS(:,1), DS(:,2));
    elseif t == 'C'
        periodic(DS);
    elseif t == 'D'
        Clamped(DS);
    end
else
    fprintf('Invalid input !!!')
end