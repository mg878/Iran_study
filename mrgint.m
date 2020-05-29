% This function computes a marginal integral of the Beta distribution for a
% given value of the outbreak size x and number of detected cases k. The
% shape parameters are alpha and beta_ with a support of p_min and p_max. 
function output = mrgint(x,k,alpha,beta_,p_min,p_max,l)
% Increments for integration
d = (p_max-p_min)/l;
% Starting value of p
p = p_min;
output = 0;
while p<p_max
    output = output + (p^k)*((1-p)^(x-k))*(((p-p_min)^(alpha-1))*((p_max-p)^(beta_-1)))/(beta(alpha,beta_)*((p_max-p_min)^(alpha+beta_-1)));
    p = p+d;
end
output = output*nchoosek(x,k);
end