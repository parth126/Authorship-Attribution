%% The function takes a direct index produced by terrier as input and gives
%% a sparse inverted matlab readable index as an output

% InFile and OutFile refer to the input file and outputfile (including the
% entire path)

function td = direct2td(InFile,OutFile,varargin)

if(nargin > 3)
    fprintf('Too many arguments');
elseif(nargin < 2)
    fprintf('Too few arguements');
else
    
l = csvread(InFile); 

% Determine the size of input matrix (missing values converted to zero)

[r, c] = size(l);

% The first column indicates document id starting from 0 as assigned by 
% terrier. Modify the id to start from 1

l(:,1) = l(:,1) +1;
x = l(:,1);
x = x + 1;

% X_overall and y_overall refer to doc id and term id in the final sparse
% matrix, val_overall refers to the occurence of term y_overall in doc
% x_overall

y_overall = []; 
x_overall = [];
val_overall = [];


for i  = 1 : r
    
    % Read term id form the even columns starting from 2
    y = l(i,2:2:c);
    % Read val from odd columns starting from 3 (Column 1 is doc id)
    val =  l(i,3:2:c);
    
    % Ignore terms having zero occurences.
    y = y(val~=0);
    val = val(val~=0);
    % Change term id to start from 1 instead of 0
    y = y + 1;
    
    % Accumulate the term id, doc id and val for all non-zero values. 
    y_overall = [y_overall y];
    x_overall = [x_overall i*ones(1,length(val))];
    val_overall = [val_overall val];
        
end

% Use the term id, doc id and val vectors to make a sparse term-doc matrix
td = sparse(x_overall,y_overall,val_overall);

% Write out the matrix to a .mat file. Optionally write it to a csv file
% 1 = .mat, 2 = .csv

% Setting a default OutFile Type as .mat

if(nargin == 3)
    Type = varagin(1);
else 
    Type = 1;
end

% Checking for the OutFile Type and saving accordingly

if(Type == 2)
    csvwrite(OutFile,td);
elseif(Type == 1)
    save(OutFile, td);
else
    fprintf('Invalid Output file Type: Saving as TD.mat instead in the local directory');
    save('TD.mat',td);
end    
end
end
