% This function finds the distance between two vectors/matrices. In case of
% matrices the pairwise distance will be calculated between columns of the
% matrix.

% The input type can be anything, a z-score vector, a probability 
% distribution or something else. 
% The input will be checked by individual distance function if required.

% Further addition of distance measure should take into account the
% capability to handle matrix instead of vectors.

function [Distance] = ComputeDistance(q,a,DistanceType)

% Check for dimension mismatch in inputs

if(sum(size(p) == size(q) | size(q) == 1 | size(p) == 1) < max(ndims(p),ndims(q)))
    fprintf('Warning: Please check the dimensions of input. Non-singleton dimensions of the two inputs must match each other.');
end

% Calculate actual distance

switch DistanceType
    
    case 'L1'
        Distance = sum(abs(bsxfun(@minus,q,a)));
        
    case 'L2' 
        Distance = sum(bsxfun(@minus,q,a).^2);
        
    case 'Delta'
        Distance = mean(abs(bsxfun(@minus,q,a)));
        
    case 'ChiSquare'
        Distance = Chi(q,a);
        
    case 'KLD'
        Distance = KLDiv(q,a,'b');

end