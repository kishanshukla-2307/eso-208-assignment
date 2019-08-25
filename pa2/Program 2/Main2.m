task = input('Enter L for only largest and A for all eigenvalues : ','s');
if task == 'L'
    PowerMethod();
elseif task =='A'
    QR_Decomposition();
end