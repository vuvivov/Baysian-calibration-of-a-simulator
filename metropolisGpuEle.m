function g=metropolisGpuEle(data,sampleSize,n,errorSd,prior)
tau=gpuArray(data(:,2));
h=gpuArray(data(:,1));
n=gpuArray(n);
errorSd=gpuArray(errorSd);
v1=tau'*tau;
v2=sum(h)*2;
v3=(tau'*sqrt(h*2))*2;
priorMean=gpuArray.ones(sampleSize,1).*prior.mean;priorSd=gpuArray(prior.std);
g=arrayfun(@metropolisGpuEleNormal,n,v1,v2,v3,errorSd,priorMean,priorSd);
g=gather(g);