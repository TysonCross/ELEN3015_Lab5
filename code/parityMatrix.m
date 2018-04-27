function [H] = parityMatrix(m,p)
%parityMatrix() creates a parity matrix H of size (n,k) from m & polynomial p
% Tyson Cross 1239448

if length(p)~=(m+1)
    error('Irreducible Polynomial incorrect length')
end

n = 2^m - 1;
val = (0:n-1)';
H = gftuple(val,p)';                % parity-check matrix from Galois field

end