% ELEN3015 Lab5 Assignment 3.1
% Tyson Cross 1239448
% addpath('utilities');
clc; clear all;

% ELEN3015 Lab5 Assignment 3.1
% Tyson Cross 1239448
% addpath('utilities');
clc; clear all;



%% Question 1:
% setup
m = 3;          % number of parity bits
p = [1 1 0 1];  % irreducible polynomial corresponding to m: 1 + x + x^3

% length of codeword, information and parity bits
n = 2^m - 1;
k = n - m;

% parity check and generator matrices
% The resulting matrices are the same as Handout equation (2.6)
H = parityMatrix(m,p);
G = generatorMatrix(H);
%{
H = [   1     0     0     1     0     1     1;...
        0     1     0     1     1     1     0;...
        0     0     1     0     1     1     1];

G = [   1     1     0     1     0     0     0;...
        0     1     1     0     1     0     0;...
        1     1     1     0     0     1     0;...
        1     0     1     0     0     0     1];
%}

% codeword
u = [1 0 0 1];  % corresponds to polynomial (1 + x^4)

% C1
C1 = mod(u*G,2);

% output
disp('Question 1:'); disp(' ');
disp('H ='); disp(H);
disp('G ='); disp(G);
disp('Input codeword ='); disp(u);
disp('C1 ='); disp(C1);
disp('--------------------------------------------------------');disp(' ');
%{
Comment:
 In C1, the first three bits are the added parity bits,
 and the last four bits are the data message (u)
%}

%% Question 2:
% setup
q = [1 1 0 1];  % irreducible polynomial: 1 + x + x^3
C2 =  gfconv(u,q);
C2_mod = gftuple(C2,3)

disp('Question 2:'); 
disp('Input codeword ='); disp(u); gfpretty(u);
disp('p(x) ='); disp(q); gfpretty(q);
disp('C2 ='); disp(C2); gfpretty(C2)
disp('C2 (simple) ='); disp(C2_mod); gfpretty(C2_mod)
disp('--------------------------------------------------------');disp(' ');
%{
Comment:
 C2 is the result of polynomial multiplication between the two row vectors,
 in the Galois field G(3): (1 + x + x^3)(1 + x^4) = 1 + x + x^4 + x^6
= [1 1 0 0 1 0 1]
{This can be reduced via modulus (1 + x + x^3) }
= (x)x^3 + (x^3)(x^3) = 0
%}

%% Question 3:
disp('Question 2:');  disp(' ');
disp('???')
disp('--------------------------------------------------------');disp(' ');


%% Question 4:

m_x = u; % [1 0 0 1] = 
P_x = 
