function [G] = generatorMatrix(H)
%generatorMatrix() creates a generator matrix G from the parity matrix H

% Tyson Cross 1239448

[m n] = size(H);
j = n-m;
I = eye(m);
I_j = eye(j);

if H(:, (j+1):n) == I
    G = [I_j H(:,1:j)'];
elseif H(:, 1:m) == I
    G = [H(:,m+1:n)' I_j];
end

end

