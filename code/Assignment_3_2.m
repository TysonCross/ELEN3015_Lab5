% ELEN3015 Lab5 Assignment 3.2
% Tyson Cross 1239448
clc; clear all;

% setup
filename1 = 'input_codewords_error.txt';
filename2 = 'input_codewords_corrected_mod.txt';
filename3 = 'input_codewords_corrected_remainder.txt';

p = [1 1 0 1];      % irreducible polynomial: 1 + x + x^3
m = 3;           	% number of parity bits
n = 2^m - 1;        % length of codeword
k = n - m;        	% length of message

H = parityMatrix(m,p);
G = generatorMatrix(H);
C = {G,H};

% encode
u = nonZeroBinaryArray(4);
u = u(1:n,:);               % only need n rows
v = mod(u*G,2);

% % create errors in all 7 bit positions
% v_err = v;
% for i=1:7
%     val = v_err(i,i);
%     if val==1
%         v_err(i,i) = 0;
%     elseif val==0
%         v_err(i,i) = 1;
%     else
%         error('not a valid binary array')
%     end
% end
% dlmwrite(filename1,v_err,' ');


%% Question 1:
disp('Question 1:'); disp(' ');

receieved_message = dlmread(filename1);
disp('Message recieved:');
disp(receieved_message);

disp('Checking for errors using transpose of the parity matrix'); disp(' ');

% check for errors
for i=1:n
    codeword = receieved_message(i,:);
    syndrome = mod(codeword*H',2);      % get the syndrome from the matrix product with H'
    if sum(syndrome)~=0
        fprintf(['Error detected in recieved message at row ', num2str(i)])
        [correction_possible,row_loc] = ismember(syndrome,H','rows');
        if ~correction_possible
            disp('Error correction not possible')
        else
            fprintf(' in position %d \n', row_loc);
            val = codeword(row_loc);
            if val==1
                codeword(row_loc) = 0;
            elseif val==0
                codeword(row_loc) = 1;
            else
                error('Not a valid binary array')
            end
            receieved_message(i,:) = codeword;
        end
    end
end
disp(' ')
    
if isequal(v,receieved_message)
    disp('All errors corrected'); disp(' ');
    dlmwrite(filename2,receieved_message,' ');
    output_message = receieved_message;
    disp('Corrected message is:')
    disp(output_message)
else
    disp('Uncorrected errors!')
end

disp('--------------------------------------------------------');disp(' ');

%% Question 2:
disp('Question 2:'); disp(' ');

clear receieved_message;

receieved_message = dlmread(filename1);
disp('Message recieved:');
disp(receieved_message);

disp('Checking for errors using modulo polynomial division'); disp(' ');

for i=1:n
    codeword = receieved_message(i,:);
    [~, rem] = gfdeconv(codeword,p);    % get the syndrome from the residue
    syndrome = zeropad(rem,m,'after');
    if sum(syndrome)~=0
        fprintf(['Error detected in recieved message at row ', num2str(i)])
        [correction_possible,row_loc] = ismember(syndrome,H','rows');
        if ~correction_possible
            disp('Error correction not possible')
        else
            fprintf(' in position %d \n', row_loc);
            val = codeword(row_loc);
            if val==1
                codeword(row_loc) = 0;
            elseif val==0
                codeword(row_loc) = 1;
            else
                error('Not a valid binary array')
            end
            receieved_message(i,:) = codeword;
        end
    end
end

disp(' ')
    
if isequal(v,receieved_message)
    disp('All errors corrected'); disp(' ');
    dlmwrite(filename3,receieved_message,' ');
    output_message = receieved_message;
    disp('Corrected message is:')
    disp(output_message)
else
    disp('Uncorrected errors!')
end