function [Q_i , Q_f  ] = doQuanMatrix(f , L , fmin,fmax) 
% Input
% f : analog signal value
% L : number of uniform quantization levels
% fmin: minimum value of f
% fmax: maximum value of f ,  %f cannot touch fmax

% Output
% Q_i: Quantization index for f
% Q_f: Quantized discrete signal value (reconstructed value)
  
% Fill in the blank ??
 
% calculate step size
Qs = (fmax - fmin) / L ;
Q_i =    floor( (f - fmin)  ./ Qs  );
Q_f = (Q_i .* Qs) + (Qs/2) + fmin ;  % follow slide 32 chapter 2_1 audio


% Your code that calculate and return the value f , Q_i , Q_f 
 end
