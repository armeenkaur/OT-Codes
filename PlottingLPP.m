clc;
c = [5 3];
A = [3 5; 5 2];
b = [15; 10];
x = 0:1:max(b);
y1 = ((15 - A(1,2)*x)/A(1,1));
y2 = ((10 - A(2,2)*x)/A(2,1));
y1 =  max(0,y1);
y2 =  max(0,y2);
plot(x, y1, "r", x, y2, "b");
title("LPP Plot");
xlabel("x-axis");
ylabel("y-axis");
legend("Line 1", "Line 2");
grid on;
py1 = find(y1 == 0);
py2 = find(y2 == 0);
px = find(x == 0);
line1 = [x(:,[py1 px]);y1(:,[py1 px])]';
line2 = [x(:,[py2 px]);y2(:,[py2 px])]';
corPt = unique([line1; line2], 'rows');
%finding intersection points of lines
pt = [0; 0];
for i = 1:size(A, 1)
    A1 = A(i,:);
    B1 = b(i,:);
    for j = i+1:size(A,1)
        A2 = A(j,:);
        B2 = b(j,:);
        A4 = [A1;A2];
        B4 = [B1;B2];
        % X = A4/B4
        X = inv(A4) * B4;
        pt = [pt X];
    end
end
ptt = pt';
allpts = [ptt; corPt];
points = unique(allpts, 'rows');
%corner points of feasible region
PT = constraint(points);
P = unique(PT, 'rows');
%compute obj fxn
FX = sum(P .* c, 2);
Vert_Fns = [P, FX];
%Find optimal value
[fxval,indfx] = max(FX);
optval = Vert_Fns(indfx,:);
optimal_BFS = array2table(optval, 'VariableNames',{'x1', 'x2', 'ObjectiveFunctionValue'});
%display optimal solution
disp('Optimal Solution: ');
disp(optimal_BFS);
%display optimal objective function value
disp('Optimal Obejctive Function Value: ');
disp(fxval);