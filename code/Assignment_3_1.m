% ELEN3015 Lab5 Assignment 3.1
% Tyson Cross 1239448
% addpath('utilities');
clc; clear all;

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
u = [1 0 1 1];      % corresponds to polynomial (1 + x^2 + x^3)

% C1
C1 = mod(u*G1,2);

% output
disp('H ='); disp(H1);
disp('G ='); disp(G1);
disp(['Input = ', num2str(u)]);  disp(' ');
disp([' C1   = ', num2str(C1)]); disp(' ');
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
disp('Generating the H and G parity and generator matrices...'); disp(' ');
H2 = parityMatrix(m,p);
G2 = generatorMatrix(H2);

C2 = mod(u*G2,2);

disp([' g(x) = ', num2str(p) ]); disp(' ');
disp(['Input = ', num2str(u)]);  disp(' ');
disp(['  C2  = ', num2str(C2)]); disp(' ');

%% Note:
disp('*NB*'); disp(' ');

C_mult = gfconv(u,p);
[~,C_div] = gfdeconv(u,p);
disp(' (1 + X^2 + X^3) · (1 + X + X^3) = '); gfpretty(C_mult);
disp (' ');
disp(['As a binary row vector: ', num2str(C_mult)]); disp(' ')
disp('But (1 + X + X^2  + X^3  + X^4  + X^5  + X^6) mod (1 + X + X^3) = '); gfpretty(C_div);
disp (' '); 
disp(['As a binary row vector: ', num2str(C_div)]); disp(' ')
disp('--------------------------------------------------------');disp(' ');
%{
Comment:
 C is the result of polynomial multiplication between the two row vectors,
 in the Galois field G(3): (1 + x^2 + x^3)(1 + x + x^3)(1 + x^4) = 1 + x + x^4 + x^6
= [1 1 0 0 1 0 1]
{This can be reduced via modulus (1 + x + x^3) }
= (x)x^3 + (x^3)(x^3) = 0
%}

%% Question 3:

disp('Question 3:');  disp(' ');
if isequal(C1,C2)
    disp([   'C1 and C2 are the same, because the input code word, ',...
            'and generator matrices are identical.']);
  	disp([  'The irreducible polynomial 1+x+x^3 creates the parity ',...
            'and generator matrices shown in Handout equation (2.6)']);
else
    disp('C1 and C2 do not match')
end
disp('--------------------------------------------------------');disp(' ');


%% Question 4:

m_x = u; % [1 0 0 1] = 
