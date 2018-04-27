function [padded_array] = zeropad(array_to_be_padded, len, pos)
%zeropad() pads an numeric array with zeros to be specific length
% Tyson Cross 1239448

if nargin < 3
    pos = 'front';
end

if len<length(array_to_be_padded)
    warning('Padding not possible')
end

padded_array = [array_to_be_padded];

for i=1:len-length(array_to_be_padded)
    if strcmp(pos,'front') || strcmp(pos,'prefix') || strcmp(pos,'before')
        padded_array = [0 padded_array];
    elseif strcmp(pos,'behind') || strcmp(pos,'suffix') || strcmp(pos,'after')
        padded_array = [padded_array 0];
    else
        error('Padding position not recognised')
    end
end
end