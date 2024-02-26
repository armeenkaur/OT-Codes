% Max z = 2x1 + 3x2 + 4x3 + 7x4  
% st 2x1 + 3x2 - x3 + 4x4 <= 8
%    x1 + 2x2 + 6x3 - 7x4 <= -3
%    x1, x2, x3, x4 >= 0

clc;
A = [2 3 -1 4; 1 2 6 -7];
b = [8; -3];
c = [2 3 4 7];

% Finding the number of choices(as in which variables to put to 0)
%  = number of variables - number of equations

n = size(A,2); % 2 picks columns
m = size(A,1); % 1 picks rows
if n>m
    ncm = nchoosek(n,m);
    p = nchoosek(1:n,m); %indices return krta hai
    s = [];
    for i = 1:ncm
        y = zeros(n,1);
        A1 = A(:,p(i,:));
        X = inv(A1)*b;
        if all(X >= 0 & X ~= inf)
            y(p(i,:)) = X;
            s =[s y];
        end
    end
    Z = c*s;
    [obj,index] = max(Z);
    BFS = s(:,index)
    optVal = [BFS' obj]
    disp(optVal(1,5))
else
    disp("No Solution");
end