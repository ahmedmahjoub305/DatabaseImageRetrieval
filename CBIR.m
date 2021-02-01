
% The purpose of this program is to do image retrieval from the created
% database , image folder inside working path/
clc; clear all; close all;


working_path = 'D:\Mahjoub Stuff\University Education\Degree studies\Year 3\Trimester 2\MM Technology & application\Assignment\dataset';
cd(working_path);
addpath('.\images');

load('database_cbir.mat','database');% loading the database mat file


%prompt the user to enter the query image to be retrieved
prompt = '\n\n\n\n\nEnter image file name(must end with .jpg)>>  ';
 x = input(prompt,'s') ;

imfile = ['.\images\',x];

imshow(imfile )
title('Query image');

% get feature vector from selected query image using HSV or RGB or CNN
%HistQ = getColourHistHSV(imfile);
%HistQ = getColourHistRGB(imfile);
HistQ = getCNN(imfile);


% This is done by comparing the feature vector of the query image and the feature vector of all the image in the database
K = 9;% Retrieve the top 9 ,
numIm = length(database)  ; % this give the number of images in database

for i=1:numIm


% get feature vector of image i from database. you can use anyone of the 3 methods.    

%v2 = database(i).featHSV; 
%v2 = database(i).featRGB;  
v2 = database(i).featCNN;  
% compare image i with the query image
dist(i) = get_euclidian_dist(HistQ,v2) ;

end

%Sort the distance by the smallest dissimilarity
% your code
[sorted_dist , idx] = sort(dist);


im_id = idx(2);   % for 2nd most similar use idx(3)

                   %To exclude the query image we should not use idx(1)
imfile = database(im_id).imageName ;
imQ = imread(imfile);



figure(2), imshow(imfile) , title('Most Similar Image to Query (Exclude the query image)')

%sort the from the smallest dissimilarity to the 10th smallest
% id_list = [idx(1) idx(2) .....idx(10)] ;
ci = 0; nr = 10;
id_list = idx(1:10) ;
figure(3);
for j=1:10
    if abs(id_list(j) - id_list(1)) < 100
        ci = ci+1;
    end
    id = id_list(j) ;
    imfile = database(id_list(j)).imageName ;
    label = database(id).label;
    str = sprintf('%d',label);  str =[ '  Label = ' str] ;
    subplot(4,3,j) , imshow(imfile) , title(str) ;
    %sorted_dist(id_list(j))
end

%this will calculate the precision of the labels once the dissimilarity is
%computed and sorted. ci is the number of matcing labels. nr is the total
%image diplayed
precision = ci/nr