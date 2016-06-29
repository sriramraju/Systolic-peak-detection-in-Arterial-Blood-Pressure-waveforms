

function [rlap s z1]=msm_fogd(LGW,ag,see)


% G=gausswin(LGW,ag);

L=LGW;

s=L/(2*ag);

n=-L/2:1:L/2;
G=exp(-0.5*((n/s).^2));

h=diff(G);

z=conv(see,h);
LG=length(h);

if(mod(LG,2)==1)
    LG=LG-1;
end

z1=z((LG/2):end-(LG/2));

[rlap,s]=zerocros(z1,'n');

% figure(3);subplot(211);plot(G);axis tight;grid on;
% subplot(212);plot(h);axis tight;grid on;