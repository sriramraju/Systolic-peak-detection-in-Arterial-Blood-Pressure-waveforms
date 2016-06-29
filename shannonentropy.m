function envf=shannonentropy(b,a,xtv)
xtvs=abs(xtv);  
th=1*std(xtvs);
xtvs1=((xtvs>th).*xtvs)+eps;
xtvs2=-xtvs1.*log(xtvs1);
envf=filtfilt(b,a,xtvs2);
envf=envf./max(envf);