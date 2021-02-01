function featVec = getColourHistHSV(imageFile)

im = imread(imageFile);
im = imresize(im,0.25);
im = rgb2hsv(im); % value 0 to 1
im = double(im);
imH = im(:,:,1);
imS = im(:,:,2);
imV = im(:,:,3);
  
[H_i , imQ_H ] = doQuanMatrix( imH , 8 , 0, 1.01) ; 
[S_i , imQ_S ] = doQuanMatrix( imS  , 8 , 0 , 1.01);
[V_i , imQ_V ] = doQuanMatrix( imV  , 4 ,0 , 1.01 ); 

% Fill up the 

featVec= [];
    
    % Fill up histogram for the Hue bins
   H_i = H_i + 1; % since matlab index start from 1
   Hist_Hue = zeros(1,8);
   % go through each element in the Hue plane
   for k= 1: length( H_i(:) )
      value_index = H_i(k);  
      Hist_Hue(value_index) =  Hist_Hue(value_index) + 1; % increment count
   end

   % Fill up histogram for the Saturation bins
   S_i = S_i + 1; % since matlab index start from 1
   Hist_Sat = zeros(1,8);
   % go through each element in the Saturation plane
   for k= 1: length( S_i(:) )
      value_index = S_i(k);  
      Hist_Sat(value_index) =  Hist_Sat(value_index) + 1; % increment count
   end
   
    % Fill up histogram for the Value bins
   V_i = V_i + 1; % since matlab index start from 1
   Hist_Val = zeros(1,4);
   % go through each element in the Saturation plane
   for k= 1: length( V_i(:) )
      value_index = V_i(k);  
      Hist_Val(value_index) =  Hist_Val(value_index) + 1; % increment count
   end
   
   % concatenate the histogram for hue, saturation and value plane
   featVec= [ Hist_Hue , Hist_Sat , Hist_Val ];
   
   % normalize the histogram
   featVec = featVec ./ sum(featVec(:)) ;
    
end