function featVec = getColourHistRGB(imageFile)

im = imread(imageFile);
im = imresize(im,0.25);
im = double(im);

imR = im(:,:,1);
imG = im(:,:,2);
imB = im(:,:,3);
  
[R_i , imQ_R ] = doQuanMatrix( imR , 8 , 0, 256) ; % set fmax slightly above the max
[G_i , imQ_G ] = doQuanMatrix( imG  , 8 , 0 , 256);
[B_i , imQ_B ] = doQuanMatrix( imB  , 4 ,0 , 256 ); 

featVec= [];
numPixel = length( R_i(:) );

    % Fill up histogram for the Hue bins
   R_i = R_i + 1; % since matlab index start from 1
   Hist_Red = zeros(1,8);
   % go through each element in the Hue plane
   for k= 1: numPixel 
      value_index = R_i(k);  
      Hist_Red(value_index) =  Hist_Red(value_index) + 1; % increment count
   end

   % Fill up histogram for the Saturation bins
   G_i = G_i + 1; % since matlab index start from 1
   Hist_Green = zeros(1,8);
   % go through each element in the Saturation plane
   for k= 1: numPixel 
      value_index = G_i(k);  
      Hist_Green(value_index) =  Hist_Green(value_index) + 1; % increment count
   end
   
    % Fill up histogram for the Value bins
   B_i = B_i + 1; % since matlab index start from 1
   Hist_Blue = zeros(1,4);
   % go through each element in the Saturation plane
   for k= 1: numPixel 
      value_index = B_i(k);  
      Hist_Blue(value_index) =  Hist_Blue(value_index) + 1; % increment count
   end
   
   % concatenate the histogram for hue, saturation and value plane
   featVec= [ Hist_Red , Hist_Green , Hist_Blue ];
   
   % normalize the histogram
   featVec = featVec ./ sum(featVec(:)) ;
    
end