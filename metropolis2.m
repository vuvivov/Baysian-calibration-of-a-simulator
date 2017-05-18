%modified from metropolis by using piTauG3
%precompute for t
function g=metropolis2(data,sampleSize,errorSd,prior)
tau=data(:,2);
h=data(:,1);
v1=tau'*tau;
v2=sum(h)*2;
v3=(tau'*sqrt(h*2))*2;
g=zeros(sampleSize,1);
g(1)=mean(prior);priorMean=prior.mean;priorSd=prior.std;
for i=2:(sampleSize)
    g(i)=metropolisGpuEleNormal2(g(i-1),v1,v2,v3,errorSd,priorMean,priorSd);
end