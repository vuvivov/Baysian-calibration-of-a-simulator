%modified from metropolisGpuEleNormal for serial use
function g=metropolisGpuEleNormal2(g,v1,v2,v3,errorSd,priorMean,priorSd)
gg=randn()*priorSd+g;
alpha=min(1,piTauG3(gg,v1,v2,v3,errorSd,priorMean,priorSd)/piTauG3(g,v1,v2,v3,errorSd,priorMean,priorSd));
u=rand();
if u<alpha
    g=gg;
end