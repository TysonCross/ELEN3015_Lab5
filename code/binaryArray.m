function [P] = binaryArray(m)
%binaryArray() creates an array of all integers of m-bits in binary

% Tyson Cross 1239448

P = zeros(2^m-1,m);
for i=1:(2^m)
    P(i,:) = dec2binary(i-1,m);
end

end