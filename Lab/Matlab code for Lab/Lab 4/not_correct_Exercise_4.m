edit commdoc_gray 
edit bertooltemplate 
 
function [ber, numBits] = my_commdoc_bertool(EbNo, maxNumErrs, maxNumBits) 

% --- Set up parameters. �C 
% --- INSERT YOUR CODE HERE. 

% Setup 
% Define parameters.

M = 16; % Size of signal constellation 
k = log2(M); % Number of bits per symbol 
n = 1000; % Number of bits to process 
nsamp = 1; % Oversampling rate 

% --- Proceed with simulation. 
% --- Be sure to update totErr and numBits. 
% --- INSERT YOUR CODE HERE. 

%% Update totErr and numBits. 
totErr = totErr + number_of_errors; 
numBits = numBits + n; 

% EbNo = 10; % In dB % COMMENT OUT FOR BERTOOL 

Bertool 









 