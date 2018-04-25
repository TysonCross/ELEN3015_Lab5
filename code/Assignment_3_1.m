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
    
C1 = {G1,H1};

% codeword
% u = [1 0 0 1];      % corresponds to polynomial (1 + x^3)
u = binaryArray(4); % all possible 4-bit values
usize = size(u);

% C1
v1 = mod(u*G1,2);

% output
disp('C1:')
disp('H ='); disp(H1);
disp('G ='); disp(G1);
disp('Input (u) = ')
disp(u);  disp(' ');
disp('v = uG'); disp(' ');
disp('v = '); disp(v1); disp(' ');
disp('--------------------------------------------------------');disp(' ');
%{
Comment:
 In v1, the first three bits are the added parity bits,
 and the last four bits are the data message (u)
%}

%% Question 2:
disp('Question 2:'); disp(' ');

p = [1 1 0 1];      % irreducible polynomial: 1 + x + x^3

m = 3;           	% number of parity bits
n = 2^m - 1;        % length of codeword
k = n - m;        	% length of message
assert(k==usize(2)); % confirm that k is the message length


% parity check and generator matrices
disp([' g(x) = ', num2str(p) ]); disp(' ');
fprintf(' g(x) = '); gfpretty(p); disp(' ');
disp('Generating the H and G parity and generator matrices...'); disp(' ');
H2 = parityMatrix(m,p);
G2 = generatorMatrix(H2);
C2 = {G2,H2};

v2 = mod(u*G2,2);

% output
disp('C2:')
disp('H ='); disp(H2);
disp('G ='); disp(G2);
disp('Input (u) = ')
disp(u);  disp(' ');
disp('v = uG'); disp(' ');
disp('v = '); disp(v2); disp(' ');


%% Note:
disp('*Note'); disp(' ');

C_mult = gfconv(u(10,:),p);
[~,C_div] = gfdeconv(u(10,:),p);

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
disp('C1 = '); disp(C1{1}); disp(' ');
disp('C2 = '); disp(C2{2}); disp(' ');
if isequal(C1,C2)
    disp([   'C1 and C2 are identical.']);
  	disp([  'The irreducible polynomial 1+x+x^3 creates the parity ',...
            'and generator matrices shown in Handout equation (2.6)']);
    disp([  'In the generated codewords, v, the first m (three) ',...
            'bits are the parity bits, and the next four bits are ',...
            'the original message (u)']);
else
    disp('C1 and C2 do not match')
end
disp(' ');
disp('--------------------------------------------------------');disp(' ');


%% Question 4:
disp('Question 4:');  disp(' ');

% M_x = gfconv(u,x_m);                      % m(x)
% [~,P_x] = gfdeconv(M_x,p);                % Parity bits: m(x)*x^3 / g(x)
% C3 = bitxor(zeropad(P_x,length(M_x),'after'),M_x);

[v3,P_x] = systematicHamming(m,u,p);
assert(isequal(v1,v3));

% output
fprintf('g(x) = '); gfpretty (p); disp(' ');
disp(['g(x) as a binary row vector: ', num2str(p)]); disp(' '); disp(' ');
disp('Input m(x) = ')
disp(u);  disp(' ');
disp('P(x) = m(x)(X^(n-k))/g(x) = ');
disp(P_x);
disp(' *Note: P(x) and m(x) are zero-padded to the length of codeword (n)');
disp(' ');
disp('v =  m(x) + P(x)');
disp(' ');
disp('v = ');
disp(v3); disp(' ');
disp('--------------------------------------------------------');disp(' ');

%% Question 5:
disp('Question 5:');  disp(' ');

% all possible combinations of the basis vectors in G 
d_min = minHammingDistance(C1{1});   

% output
disp(['d_min of C1 = ', num2str(d_min)]); disp(' ')
disp('--------------------------------------------------------');disp(' ');

%% Question 6:
disp('Question 6:');  disp(' ');

u_nozero = nonZeroBinaryArray(k);
v = mod(u_nozero*G1,2);
% Calculate the weight of every nonzero codeword
w_min = minHammingWeight(v);

% output
disp('All possible non-zero codewords of C1 = ')
disp(v);
disp(['w_min of C1 = ', num2str(w_min)]); disp(' ')
disp('--------------------------------------------------------');disp(' ');

%% Question 7:
disp('Question 7:');  disp(' ');

% output
disp(' "It is sufficient to arrange it that the minimum weight of a code');
disp('word is 3 (or k)... because the Hamming distance between two code words, ');
disp('A and B, say, is the weight of their sum, which sum is another code word.');
disp('This means that if all weights of non-zero code words are at least');
disp('3 (or k) the minimum Hamming distance between code words will be ');
disp('at least 3 (or k)."');
disp('Source: www-math.mit.edu/~djk/18.310/18.310F04/matrix_hamming_codes.html');
disp('--------------------------------------------------------');disp(' ');

%% Question 8:
disp('Question 8:');  disp(' ');

student_no = [1 2 3 9 4 4 8];
for i=1:3
    student_no_bin(i,:) = dec2binary(student_no(end-3+i),4);
end

c = mod(student_no_bin*G1,2);
% output
disp(['Student Number = ', num2str(student_no)]); disp(' ');
disp('Binary row vectors of the last three digits =  ');
disp(student_no_bin);
disp('Codewords C = ');
disp(c); disp(' ');
disp('--------------------------------------------------------');disp(' ');
