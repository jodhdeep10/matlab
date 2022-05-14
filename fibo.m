clc
clear
f=@(x) (x.*(x-2));
L=input('Enter the value of left interval: ');
R=input('Enter the right interval: ');
n=input('Enter the number of iterations: ');
fib=ones(1,n);
for i=3:n+1
    fib(i)=fib(i-1)+fib(i-2);
end
for k=1:n
    ratio=fib(n-k+1)./fib(n-k+2);
    x2=L+ratio.*(R-L);
    x1=L+R-x2;
    fx1=f(x1);
    fx2=f(x2);
    tab(k,:)=[ratio L R x1 x2 fx1 fx2];
    if fx1<fx2
        R=x2;
    else if fx1>fx2
            L=x1;
    else if fx1==fx2
            if min(abs(x1),abs(L))==abs(L)
                R=x2;
            else
                L=x1;
            end
    end
    end
    end
end
p=(L+R)/2;
disp(f(p));