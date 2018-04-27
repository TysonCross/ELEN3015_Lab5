function [d_min] = minHammingDistance(C,dir)
%minHammingDistance measures the minimum Hamming distance in a code by
%comparing all combinations of each row (or column) XORed with each other
%row (or column)
% Tyson Cross 1239448

if nargin < 2
    dir = 'r';
end

csize = size(C);
if strcmp(dir,'row') || strcmp(dir,'r')
    combinations = nchoosek([1:csize(1)],2);
    do_row_wise = true;
    d_min = csize(2);
elseif strcmp(dir,'column') || strcmp(dir,'col') || strcmp(dir,'c')  
	combinations = nchoosek([1:csize(2)],2);
    do_row_wise = false;
    d_min = csize(1);
else
    error('Please specify row or column')
end

if do_row_wise
    for i=1:length(combinations)
       a = C(combinations(i,1),:);
       b = C(combinations(i,2),:);
       val = sum(bitxor(a,b));
       if val<d_min
           d_min = val;
       end
    end
else
	for i=1:length(combinations)
       a = C(:,combinations(i,1));
       b = C(:,combinations(i,2));
       val = sum(bitxor(a,b));
       if val<d_min
           d_min = val;
       end
	end
end
end