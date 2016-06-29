function [xtvs2 envf]=shannonenergy(b,a,xtv)
xtvs=xtv.^2;  
th=0.5*std(xtvs);
xtvs1=((xtvs>th).*xtvs)+eps;
xtvs2=-xtvs1.*log(xtvs1);
envf=filtfilt(b,a,xtvs2);
envf=envf./max(envf);