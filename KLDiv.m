% The function gives the Kullback-Leibler divergence between two 
% distributions, or between one distribution and a set of distributions
% or between two sets of distributions. 

% P and q are the vector/matrices for which kld is to be calculated.
% In case p and q are matrices KLD will be calculated columnwise.
% An optional argument specifying the type of KLD can be specified
% f for forward, r for reverse and b for bidirectional KLD

function [kld] = KLDiv(p,q,varargin)

if((nargin < 2)||(nargin>3))
     fprintf('Invalid number of arguments');
elseif(nargin == 2) 
     s = 'b';
else 
     s = varargin(1);
end

if(sum(~isfinite(p(:)))+sum(~isfinite(q(:)))) > 0
     fprintf('Function cannot handle Infinite values');
end

% Find the terms with non-zero probabilities in both 'p' and 'q' and retain only those

k = (p > 0) & (q > 0);
p = p(k);
q = q(k);

% Find the actual K.L.Divergence

if(strcmp(s ,'f'))
    kld = sum(bsxfun(@times,p,log2(bsxfun(@rdivide,p,q))));
elseif(strcmp(s,'r'))
    kld = sum(bsxfun(@times,q,log2(bsxfun(@rdivide,q,p))));
elseif(s=='b')
    kld = (sum(bsxfun(@times,p,log2(bsxfun(@rdivide,p,q)))) + sum(bsxfun(@times,q,log2(bsxfun(@rdivide,q,p)))))/2;
end

    

