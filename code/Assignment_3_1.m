% ELEN3015 Lab5 Assignment 3.1
% Tyson Cross 1239448
% addpath('utilities');
clc; clear all;



%% Question 1:
disp('Question 1:'); disp(' ');

% The matrices from the Handout equation (2.6)
H1 = [  1     0     0     1     0     1     1 ;...
        0     1     0     1     1     1     0 ;...
        0     0     1     0     1     1     1 ];

G1 = [ 	1     1     0     1     0     0     0 ;...
        0     1     1     0     1     0     0 ;...
        1     1     1     0     0     1     0 ;...
        1     0     1     0     0     0     1 ];

% codeword
u = [1 0 0 1];      % corresponds to polynomial (1 + x^3)

% C1
C1 = mod(u*G1,2);

% output
disp('H ='); disp(H1);
disp('G ='); disp(G1);
disp(['Input (u) = ', num2str(u)]);  disp(' ');
disp('C1 = uG'); disp(' ');
disp(['C1 = ', num2str(C1)]); disp(' ');
disp('--------------------------------------------------------');disp(' ');
%{
Comment:
 In C1, the first three bits are the added parity bits,
 and the last four bits are the data message (u)
%}

%% Question 2:
disp('Question 2:'); disp(' ');

p = [1 1 0 1];      % irreducible polynomial: 1 + x + x^3

m = 3;           	% number of parity bits
n = 2^m - 1;        % length of codeword
k = n - m;        	% length of message
assert(k== length(u));


% parity check and generator matrices
disp([' g(x) = ', num2str(p) ]); disp(' ');
fprintf(' g(x) = '); gfpretty(p); disp(' ');
disp('Generating the H and G parity and generator matrices...'); disp(' ');
H2 = parityMatrix(m,p);
G2 = generatorMatrix(H2);

C2 = mod(u*G2,2);

% output
disp('H ='); disp(H2);
disp('G ='); disp(G2);
disp(['Input (u) = ', num2str(u)]);  disp(' ');
disp('C2 = uG'); disp(' ');
disp(['C2 = ', num2str(C2)]); disp(' ');

%% Note:
disp('*Note'); disp(' ');

C_mult = gfconv(u,p);
[~,C_div] = gfdeconv(u,p);

% output
disp(' ');
fprintf(' (1 + X^3) · (1 + X + X^3) = '); gfpretty(C_mult);
disp (' ');
disp(['As a binary row vector: ', num2str(C_mult)]); disp(' ');
disp(' ');
fprintf(' (1 + X^3) ÷ (1 + X + X^3) = '); gfpretty(C_div);
disp (' '); 
disp(['As a binary row vector: ', num2str(C_div)]); disp(' ');
disp('Both of these solutions are equivalent under Galois Field G(3)');
disp(' ')
disp('--------------------------------------------------------');disp(' ');
%{
Comment:
Multiplication is the same as division:
 The result of polynomial multiplication between two row vectors,
 in the Galois field G(3): (1 + x^3)(1 + x + x^3) = 1 + x + x^4 + x^6
= [1 1 0 0 1 0 1]
{This is reduced via modulo (1 + x + x^3)}
= x = 0 1
%}

%% Question 3:
disp('Question 3:');  disp(' ');

% output
disp(['C1 = ', num2str(C1)]); disp(' ');
disp(['C2 = ', num2str(C2)]); disp(' ');
if isequal(C1,C2)
    disp([   'C1 and C2 are the same, because the input code word, ',...
            'and generator matrices are identical.']);
  	disp([  'The irreducible polynomial 1+x+x^3 creates the parity ',...
            'and generator matrices shown in Handout equation (2.6)']);
        disp([  'The first m (three) bits are the parity bits,',...
            'and the next four bits are the original message (u)']);
else
    disp('C1 and C2 do not match')
end
disp(' ');
disp('--------------------------------------------------------');disp(' ');


%% Question 4:
disp('Question 4:');  disp(' ');

x_m = [0 0 0 1];                % x^(n-k) = x^m = [0 0 0 1]
M_x = gfconv(u,x_m);            % previous codeword u = [1 0 0 1]

[~,P_x] = gfdeconv(M_x,p);       	% Parity bits: m(x)*x^3 / g(x)
C3 = bitxor(zeropad(P_x,length(M_x),'after'),M_x);

% output
disp(['Input = ', num2str(u)]);  disp(' ');
fprintf('g(x) = '); gfpretty (p); disp(' ');
disp(['g(x) as a binary row vector: ', num2str(p)]); disp(' ')
disp(' ');
fprintf('m(x)*X^(n-k) = '); gfpretty (M_x); disp(' ');
disp(['m(x)*X^(n-k) as a binary row vector: ', num2str(M_x)]); disp(' ')
disp(' ');
fprintf('P(x) = m(x)(X^(n-k))/g(x) = '); gfpretty(P_x); disp(' ');
disp(['P(x) as a binary row vector: ', num2str(P_x)]); disp(' ')
disp(' ');
disp('C3 =  m(x) + P(x)  *Note: P(x) is zero-padded to the length of m(x)');
disp(' ');
fprintf('C3 = '); gfpretty(C3); disp(' ');
disp(['C3 as a binary row vector: ', num2str(C3)]); disp(' ')
disp('--------------------------------------------------------');disp(' ');



