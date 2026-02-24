%% Manipulating Multidimensional Arrays
% This example shows how to work with arrays having more than two dimensions. 
% Multidimensional arrays can be numeric, character, cell, or structure arrays.
% 
% Multidimensional arrays can be used to represent multivariate data. MATLAB® 
% provides a number of functions that directly support multidimensional arrays.
%% Creating Multi-Dimensional Arrays
% Multidimensional arrays in MATLAB are created the same way as two-dimensional 
% arrays. For example, first define the 3-by-3 matrix, and then add a third dimension.

A = [5 7 8;
   0 1 9;
   4 3 6];
A(:,:,2) = [1 0 4;
   3 5 6;
   9 8 7]
%% 
% The |cat| function is a useful tool for building multidimensional arrays. 
% |B = cat(DIM,A1,A2,...)| builds a multidimensional array by concatenating |A1, 
% A2 ...| along the dimension |DIM|.

B = cat( 3, [2 8; 0 5], [1 3; 7 9], [2 3; 4 6])
%% 
% Calls to |cat| can be nested.

A = cat(3,[9 2; 6 5], [7 1; 8 4]);
B = cat(3,[3 5; 0 1], [5 6; 2 1]);
C = cat(4,A,B,cat(3,[1 2; 3 4], [4 3; 2 1]));
%% Finding the Dimensions
% |size| and |ndims| return the size and number of dimensions of matrices.

SzA   = size(A)
DimsA = ndims(A)
SzC   = size(C)
DimsC = ndims(C)
%% Accessing Elements
% To access a single element of a multidimensional array, use integer subscripts. 
% For example, using |A| defined from above, |A(1,2,2)| returns 1.
% 
% Array subscripts can also be vectors. For example:

K = C(:,:,1,[1 3])
%% Manipulating Multi-Dimensional Arrays
% |reshape|, |permute|, and |squeeze| are used to manipulate N-dimensional arrays. 
% |reshape| behaves as it does for 2-D arrays. The operation of |permute| is illustrated 
% below.
% 
% Let |A| be a 3-by-3-by-2 array. |permute(A,[2 1 3])| returns an array with 
% the row and column subscripts reversed (dimension 1 is the row, dimension 2 
% is the column, dimension 3 is the depth and so on). Similarly, |permute(A,[3,2,1])| 
% returns an array with the first and third subscripts interchanged.

A = rand(3,3,2);
B = permute(A, [2 1 3]);
C = permute(A, [3 2 1]);
%% Selecting 2-D Matrices From Multi-Dimensional Arrays
% Functions like |eig| that operate on planes or 2-D matrices do not accept 
% multi-dimensional arrays as arguments. To apply such functions to different 
% planes of the multi-dimensional arrays, use indexing or |for| loops. For example:

A = cat( 3, [1 2 3; 9 8 7; 4 6 5], [0 3 2; 8 8 4; 5 3 5], ...
   [6 4 7; 6 8 5; 5 4 3]);
% The EIG function is applied to each of the horizontal 'slices' of A.
for i = 1:3
   eig(squeeze(A(i,:,:)))
end
%% 
% |interp3|, |interpn|, and |ndgrid| are examples of interpolation and data 
% gridding functions that operate specifically on multidimensional data. Here 
% is an example of |ndgrid| applied to an N-dimensional matrix.

x1 = -2*pi:pi/10:0;
x2 = 2*pi:pi/10:4*pi;
x3 = 0:pi/10:2*pi;
[x1,x2,x3] = ndgrid(x1,x2,x3);
z = x1 + exp(cos(2*x2.^2)) + sin(x3.^3);
slice(z,[5 10 15], 10, [5 12]);
axis tight
%% 
% You can build multidimensional cell arrays and multidimensional structure 
% arrays, and can also convert between multidimensional numeric and cell arrays.
% 
% To find out more, consult the MATLAB documentation on multidimensional 
% arrays.
% 
% Copyright 1984-2014 The MathWorks, Inc.
