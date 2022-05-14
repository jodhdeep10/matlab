clc
clear
% Objecive function
type = 'min';

c=[3 5];
A=[-1 -3; -1 -1 ];
B=[-3 -2];

% Dual simplex algorithm for solving LPPs of the type

%               max (min) z = cx
%            Subject to Ax <= b
%                        x >= 0

% Ensure that the problem is of maximization type
if type == 'max'
    mm = 0;
else
    mm = 1;
    c = -c;
   
end

% Transpose b
b = B';

[m, n] = size(A);

% Add artifical variables and identity matrix along with RHS values

A = [A eye(m) b];


% Add the cost values for the existing and the artifical variables
% A = [A; [c zeros(1, m + 1)]];

%REMOVED FROM HERE


A


bv = n + 1 : n + m;
zjcj=[c zeros(1, m + 1)];
run=true;
[m, n] = size(A);
cost=A(:,n);
while run
    zc=A(1:m,1:n-1);
    if any(A(:,n)<0)
%         zc=zjcj(1:end-1);
        [minc,pvtrow]=min(cost);
%         fprintf('The most Negative is %d witn Column %d',minzc,pvtcol);
        sol=A(:,n);
        row=zc(pvtrow,:);
        if all(zjcj>=0)
            disp('Error!!LPP is Unbounded');
        else
            for i=1:n-1
                if(row(i)<0)
                    ratio(i)=zjcj(i)./row(i)
                else
                    ratio(i)=inf;
                end
            end
            [minratio,pvtcol]=min(ratio);
            fprintf('The minimum ratio is %d and Leaving Variable is %d\n',minratio,pvtrow);
            
        end
        bv(pvtrow)=pvtcol;
        disp('New Basic Variables:');
        disp(bv);
        
        pvtkey=A(pvtrow,pvtcol);
        A(pvtrow,:)=A(pvtrow,:)./pvtkey;
        for i=1:size(A,1)
            if i~=pvtrow
                A(i,:)=A(i,:)-A(i,pvtcol).*A(pvtrow,:);
            end
        end
        
        zjcj=zjcj-zjcj(pvtcol).*A(pvtrow,:);
        zcj=[A];
        simp2=array2table(zcj)
        
        bfsl=zeros(1,size(A,2));
        bfsl(bv)=A(:,end);
        bfsl(end)=sum(bfsl.*cost);
        
        cbfs=array2table(bfsl)
    else
        run=false;
        disp('Optimal Solution Reached!');
    end
end























[c zeros(1, m + 1)]