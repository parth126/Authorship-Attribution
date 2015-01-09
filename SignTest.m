% The function compares two inputs using the two sided sign test

% The function returns 2 if the two input arguments are significantly
% different with alpha value of 1%

% It returns 1 if the two input arguments are significantly different 
% with alpha value of 5% but not with alpha value of 1%

% It returns zero otherwise

function [IsSignificant] = SignTest(p,q)

n = sum(p~=q);

% z-value for significance at alpha = 5%
z1 = 1.96;

% z-value for significance at alpha = 1%
z2 = 2.57;

tPlus = sum(p<q);

% t-value for significance level at Alpha = 5%
t1 = 0.5*(n-z1*sqrt(n));

% t-value for significance level at Alpha = 1%
t2 = 0.5*(n-z2*sqrt(n));

if(tPlus < t1 || tPlus > (n - t1))
    IsSignificant = 0;
elseif (tPlus < t2 || tPlus > (n - t2))
    IsSignificant = 1;
else
    IsSignificant = 2;
end

