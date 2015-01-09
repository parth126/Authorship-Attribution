% This function takes in term frequency values and returns smoothed
% estimated probability

% In case the type of smoothing is not specified lidstone smoothing with 
% smoothing parameter Lambda = 0.1 is used

% Each type of smoothing with its default arguments is provided as a case
% in the switch statement. Currently the function ignores any extra
% agruments passed to it and uses only the first 'N' arguments passed to
% it. 'N' depends on the type of smoothing.

function [p_smoothed] = Smooth(tf,varargin)

if(nargin ==0)
    fprintf('Provide atleast one argument');
elseif(nargin == 1)
    SmoothType = 'lidstone';
else
    SmoothType = varargin(1);
end


switch SmoothType

    % Lidstone smoothing. n = 2. First argument is 'lidstone' and second is
    % the value of smoothing parameter Lambda

    case 'lidstone'
        if(nargin > 2) 
            Lambda = varagin(2);
        else
            Lambda = 0.1; 
        end
        if(nargin > 3)
            fprintf('Too many arguments provided. Ingnoring the extra arguments');
        end 
        V = length(tf);
        n = sum(tf);
        p_smoothed = (tf+Lambda)/(n + Lambda*V);

    % Dirichlet smoothing. n = 3. First argument is 'dirichlet'. 
    % The second argument is the matrix containing the backgroud model. Has to
    % be of the same size as the distribution 'tf'
    % Third argument is the smoothing parameter Mu
        
    case 'dirichlet'
        if(nargin < 3)
            fprintf('No Background model provided. Returning the original distribution');
        end
        
        pB = varagin(2);
        
        if(nargin > 3) 
            Mu = varagin(3);
        else
            Mu = 1000*sqrt(10);
        end
        if(nargin > 4)
            fprintf('Too many arguments provided. Ingnoring the extra arguments');
        end 
        
        n = sum(tf);
        p_smoothed = (tf/(Mu + n)) + (Mu/(Mu + n))*pB;
        
    % The undefined smoothing technique returns the original distribution without
    % any modification.
    otherwise
        fprintf('This type of smoothing is not yet defined in this function. Returning the original distribution');
        p_smoothed = tf;
end