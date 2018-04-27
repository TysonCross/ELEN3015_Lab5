function [w_min] = minHammingWeight(C)
%minHammingWeight measures the minimum Hamming weight (sum of 1s in non-zero rows) 
% Tyson Cross 1239448

csize = size(C);
w_min = csize(2);
len = csize(1);

for i=1:len
   val = sum(C(i,:));
   if val<w_min
       w_min = val;
   end
end
end