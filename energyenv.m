function [xtvs xtvs1 envf]=energyenv(b,a,xtv)
xtvs=xtv.^2;  
xtvs1=xtvs.*(xtvs>std(xtvs));
envf=filtfilt(b,a,xtvs1);
envf=envf./max(envf);