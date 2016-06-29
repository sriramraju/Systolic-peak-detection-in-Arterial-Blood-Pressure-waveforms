clc; 
close all; 
clear all;  

a=load('1.mat');

load annotd.mat

d=d(:,4);

a1=a.val;

s0=a1(2,:)';

fs=250;

tpeaks=0;

bm1=0;

ND=floor(1*60*fs);

MF=ceil(length(s0)/ND);

s1=[s0' zeros(1,ND)]';

N1=1;

for bm=1:MF

N2=bm*ND;

range=[N1 N2];

s2=s1(N1:N2);

L=length(s2);  % computing length of the input signal 

t=(0:1/fs:(L-1)/fs); % converting sample number to sample time

x1=s2-min(s2);

x1=x1./max(abs(x1));

snr1=30;

xn=awgn(x1,snr1,'measured'); % adding noise to signal example 5 dB

xn=xn';

%---------------------------------------------------------------------
L=50; ag=2;

s=L/(2*ag);
n=-L/2:1:L/2;
G=exp(-0.5*((n/s).^2));
h=diff(G);

xtv=filtfilt(h,1,xn);
 
xtv=xtv./max(abs(xtv));

%-------------------------------
 NW=floor(0.15*fs);
 b=rectwin(NW)/NW;
 a=1;
 [xtvs envf1]=shannonenergy(b,a,xtv);
% [xtvs xtvs1 envf1]=energyenv(b,a,xtv);

LGW=floor(50); 
ag=2;

[rlap s z1]=msm_fogd(LGW,ag,envf1);

figure(1);subplot(511); plot(t,xn);axis tight; grid on; 
subplot(512); plot(t,xtv);axis tight; grid on; 
subplot(513); plot(t,envf1);axis tight; grid on;  
subplot(514); plot(t,z1);axis tight; grid on; 
subplot(515); plot(t,s2);axis tight; grid on;  hold on;stem(t(rlap),s2(rlap),'or');

cpeak=rlap;

NW=30;

NW1=30; 

nq=1; 

sig2=[zeros(1,NW1)'; s2; zeros(1,NW1)'];

cpeak=cpeak+NW;

for k=1:length(cpeak)
            
     WI=cpeak(k)-NW;
     
     WE=cpeak(k)+NW;
     
     wsig=sig2(WI:WE);
     
     [R_VS1 R_L1]=max((wsig));
     
     R_W(nq,:)=[R_VS1  R_L1+WI ];
     
     nq=nq+1;
     
end

B_L=R_W(:,2)-NW-1;

if (B_L(end)>ND) 
    
    B_L(end)=ND;
      
end

if (B_L(1)<=0) 
    
    B_L(1)=1;
      
end 

A_L=d;
f=find(N1 < A_L & A_L < N2);
A_L1=A_L(f);
A_L1=A_L1-N1+1;

if bm==MF
A_L=d;
N2=length(s0);
f=find(N1 < A_L & A_L < N2);
A_L1=A_L(f);
A_L1=A_L1-N1+1;  
end
    

tpeaks=length(B_L);

atpeaks=length(A_L1);

dpeaks(bm,:)=[tpeaks atpeaks]

close all; 

B_L = B_L(2:end-1);

for i = 2:length(B_L)
    temps(i-1)=t(B_L(i))-t(B_L(i-1));
end

figure(2);subplot(611); plot(t,xn);axis tight; grid on; 
subplot(612); plot(t,xtv);axis tight; grid on; 
subplot(613); plot(t,envf1);axis tight; grid on;  
subplot(614); plot(t,z1);axis tight; grid on; hold on;
subplot(615); plot(t,xn);axis tight; grid on;  hold on;stem(t(B_L),xn(B_L),'or');
% subplot(616); plot(t,xn);axis tight; grid on;  hold on;stem(t(A_L1),xn(A_L1),'or');
subplot(616); plot(temps);axis tight; grid on;


f1 = figure(2);
scrsz = get(0,'ScreenSize');
set(f1, 'Position', [1  1  scrsz(3) scrsz(4) ] );



pause;

clear B_L A_L cpeak R_W  rlap tpeaks atpeaks

N1=N2+1;

bm

end

dpeaks
