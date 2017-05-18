%the simulator for time given vector h and vector' g
function time=t(h,g)
h_g=2*h*g.^(-1);
h_g=h_g+(h_g<=0)*2^63;
time=sqrt(h_g);
