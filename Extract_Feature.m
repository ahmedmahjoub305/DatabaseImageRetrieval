
% The purpose of this program is to assign feature vector to each record
clc; clear all; close all;
% Please check that you can see the folder \images in the file browser of Octave or Matlab

working_path = 'D:\Mahjoub Stuff\University Education\Degree studies\Year 3\Trimester 2\MM Technology & application\Assignment\dataset';
image_directory = [working_path,'\images\'] ;

cd(working_path);
addpath(pwd);
addpath(image_directory);

%% Examine the database by loading the mat file

load('database_cbir.mat','database');

% in matlab 137 sec , 1 image takes 0.137 sec
% in octave 1 image takes 0.5 sec 
tic
for i = 1:length(database)

    imFile = database(i).imageName ;
    disp(imFile);
    database(i).featRGB = getColourHistRGB(imFile);
    database(i).featHSV = getColourHistHSV(imFile);
    database(i).featCNN = getCNN(imFile);
    if mod(i,10)== 0
     fprintf('\n Extracting feature for image %i ',i);
    end
    
end
toc
save('database_cbir.mat', 'database');

clear all;
load('database_cbir.mat', 'database');
 imFile = database(101).imageName ;
 imshow(imFile);