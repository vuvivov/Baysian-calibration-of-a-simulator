%moving prior to gpu. prior can only be normal
function g=metropolisGPUArray2(data,sampleSize,n,errorSd,prior)
data=gpuArray(data);sampleSize=gpuArray(sampleSize);
n=gpuArray(n);errorSd=gpuArray(errorSd);
metroSd=gpuArray(std(prior));
g=gpuArray.zeros(1,sampleSize)+mean(prior);
priorMean=gpuArray(prior.mean);priorSd=gpuArray(prior.std);
for i=1:n
    gg=gpuArray.randn(size(g)).*metroSd+g;
    alpha=min(1,piTauG2(gg,data(:,2),data(:,1),errorSd,priorMean,priorSd)./piTauG2(g,data(:,2),data(:,1),errorSd,priorMean,priorSd));
    u=gpuArray.rand(size(g));
    change=(u<alpha);
    g=gg.*change+g.*(1-change);
end
g=gather(g');