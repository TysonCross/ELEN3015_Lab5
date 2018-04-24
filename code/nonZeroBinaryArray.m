function [P] = nonZeroBinaryArray(m)
%nonZeroBinaryArray() creates a list of all non-zero integer of m-bits

% Tyson Cross 1239448

P = zeros(2^m-1,m);
for i=1:(2^m-1)
    P(i,:) = dec2binary(i,m);
end

end