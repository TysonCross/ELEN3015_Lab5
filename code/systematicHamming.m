function [C,P_x] = systematicHamming(m,u,p)
%systematicHamming() performs systematic encoding of the Hamming(7,4) code

% Tyson Cross 1239448

usize = size(u);
x_m = order2bin(m);                % x^(n-k) = x^m
n = 2^m - 1;
k = n - m;

% initialise arrays
M_x = zeros(usize(1),n);        % m(x)
P_x = zeros(usize(1),n);        % parity bits
C  = zeros(usize(1),n);         % Hamming(7,4)

for i=1:usize(1)
    M_x(i,:)  = zeropad(gfconv(u(i,:),x_m),n,'after');
    [~,p_x] = gfdeconv(M_x(i,:),p);      % m(x)*x^3 / g(x)
    P_x(i,:) = zeropad(p_x,n,'after');
    C(i,:) = bitxor(P_x(i,:), M_x(i,:));
end

P_x = P_x(:,1:m);

end

