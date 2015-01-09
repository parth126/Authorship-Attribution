% The function gives the Kullback-Leibler divergence between two 
% distributions, or between one distribution and a set of distributions
% or between two sets of distributions. 

% p and q are the vector/matrices for which kld is to be calculated.
% In case p and q are matrices KLD will be calculated columnwise and pairwise.

% An optional argument 'Type' specifying the type of KLD can be specified
% f for forward, r for reverse and b for bidirectional KLD. Default argument for 
% Type is 'b', i.e. bidirectional.


function [KLD] = KLDiv(p,q,varargin)

if((nargin < 2)||(nargin>3))
     fprintf('Invalid number of arguments');
elseif(nargin == 2) 
     Type = 'b';
else 
     Type = varargin(1);
end

% Check for Inf, NA and NaN in the input.

if(sum(~isfinite(p(:)))+sum(~isfinite(q(:)))) > 0
     fprintf('Function cannot handle Infinite values');
     KLD = 0;
     return; 
end

if(sum(p) ~= 1 || sum(q) ~= 1)
    fprintf('Sum of one or more input distributions is greater than 1. Please cross check. Computing the KLD nonetheless');
end

% Find the terms with non-zero probabilities in both 'p' and 'q' and retain only those

k = ((p > 0) & (q > 0));
p = p(k);
q = q(k);

% Find the actual K.L.Divergence

if(strcmp(Type ,'f'))
    KLD = sum(bsxfun(@times,p,log2(bsxfun(@rdivide,p,q))));
elseif(strcmp(Type,'r'))
    KLD = sum(bsxfun(@times,q,log2(bsxfun(@rdivide,q,p))));
elseif(strcmp(Type,'b'))
    KLD = (sum(bsxfun(@times,p,log2(bsxfun(@rdivide,p,q)))) + sum(bsxfun(@times,q,log2(bsxfun(@rdivide,q,p)))))/2;
end
