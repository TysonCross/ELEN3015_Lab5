function [bin] = order2bin(m)
%order2bin returns a binary vector representation of x^m

bin = zeros(1,m+1);
bin(m+1) = 1;

end

