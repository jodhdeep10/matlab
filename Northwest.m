clc
clear 
x = [2 10 4 5;6 12 8 11;3 9 5 7];
s = [12 25 20];
d = [25 10 15 5];
[m, n] = size(x);
x1 = zeros(m,n);
d_sum = 0;
s_sum = 0;
for j=1:m
    s_sum = s_sum+s(j);
end
for i=1:n
    d_sum = d_sum+d(i);
end

diff=abs(s_sum-d_sum);

% Adding new dummy row is the demand is greater than the supply sum.
if(s_sum<d_sum)
    
    new_row=zeros(1,n);
    x=[x;new_row];
    m=m+1;
    s=[s diff];
    
end

% Adding new dummy column if the supply is greater than the demand sum
if(s_sum>d_sum)
    new_col=zeros(m,1);
    x=[x new_col];
    n=n+1;
    d=[d diff];
end

% main algorithm of northwest where we find th minimum of the cost 
% from the supply and demand row sum and then choose the most optmised path. 
for i=1:m
    for j=1:n
        min_sd=min(s(i),d(j));
        x1(i,j)=min_sd;
        s(i)=s(i)-min_sd;
        d(j)=d(j)-min_sd;
    end
end

min_cost=0;
for i=1:m
    for j=1:n
        min_cost=min_cost+(x(i,j).*x1(i,j));
    end
end

disp('The transportation cost is ');
disp(min_cost);