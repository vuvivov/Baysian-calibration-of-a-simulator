%modified from piTauG to increase gpu utilization
%changed to gpuArray.ones and normpdf
%prior can only be normal
function p=piTauG2(g,tau,h,errorSd,priorMean,priorSd)
p=exp(-.5*sum((t(h,g)-(tau*gpuArray.ones(1,length(g)))).^2)/errorSd^2)/errorSd.*normpdf(g,priorMean,priorSd);