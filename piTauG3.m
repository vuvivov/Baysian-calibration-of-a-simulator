%modified from piTauG to enable gpu arrayfun
%changed implementation of t through v1 v2 and v3
%chanded pdf to normpdf. 
%prior can only be normal
function p=piTauG3(g,v1,v2,v3,errorSd,priorMean,priorSd)
p=exp(-0.5 * ((g - priorMean)./priorSd).^2) ./ (sqrt(2*pi) .* priorSd);
if g<=0
    g=1/2^63;
end
p=p.*exp(-.5*(v1+v2/g-v3/sqrt(g))/errorSd^2)/errorSd;