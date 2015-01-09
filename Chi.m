% The function gives the Chi-squared distance between two 
% distributions, or between one distribution and a set of distributions
% or between two sets of distributions. 

% p and q are the vector/matrices for which chi-square is to be calculated.
% In case p and q are matrices chi-square will be calculated columnwise and
% pairwise

% Please note this function is dependent on order of the input arguments
% and is not symmetrical. Ensure proper ordering of input arguments.


function [CHI] = Chi(p,q)

if(nargin == 2)
    
    % Check for Inf, NA and NaN in the input
    if(sum(~isfinite(p(:)))+sum(~isfinite(q(:)))) > 0
        fprintf('Function cannot handle Infinite values');
        CHI = 0;
        return; 
    end

    if(sum(p) ~= 1 || sum(q) ~= 1)
        fprintf('Sum of one or more input distributions is greater than 1. Please cross check. Computing the CHI nonetheless');
    end
    
    % Find the actual Chi-square distance
    
    CHI = sum(bsxfun(@rdivide,((bsxfun(@minus,p,q)).^2),q));
    
    % Check for infinite values in the output. 
    
    if(sum(~isfinite(CHI)))
        fprintf('Infinite values detected. Please cross check');
    end
    
elseif(nargin > 2)
    
    fprintf('Too many arguments');

else

    fprintf('Too few arguments');

end
