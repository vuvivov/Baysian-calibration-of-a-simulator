function g=metropolisCpuEle(data,sampleSize,n,errorSd,prior)
tau=data(:,2);
h=data(:,1);
v1=tau'*tau;
v2=sum(h)*2;
v3=(tau'*sqrt(h*2))*2;
priorMean=prior.mean;priorSd=prior.std;
g=ones(sampleSize,1);
g=arrayfun(@metropolisGpuEleNormal,g*n,g*v1,g*v2,g*v3,g*errorSd,g*priorMean,g*priorSd);