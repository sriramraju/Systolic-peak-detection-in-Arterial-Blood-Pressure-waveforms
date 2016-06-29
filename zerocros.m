
function [t,s]=zerocros(x,m)

if nargin<2
    
    m='b';
    
end

s=x>=0;

k=s(2:end)-s(1:end-1);

if any(m=='p')
    
    f=find(k>0);
    
elseif any(m=='n')
    
    f=find(k<0);
    
else
    f=find(k~=0);
    
end

s=x(f+1)-x(f);

%t=f-x(f)./s;

t=f;