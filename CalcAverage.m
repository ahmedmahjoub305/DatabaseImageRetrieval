clc; clear all; close all;

working_path = 'D:\Mahjoub Stuff\University Education\Degree studies\Year 3\Trimester 2\MM Technology & application\Assignment\dataset';

cd(working_path);

addpath(pwd);

load('database_cbir.mat','database');

numIm = length(database) ;

K = 10;

categoryrange=100;

for m=901:1000

count=0;

imfile = database(m).imageName ;

fprintf('\n\n The query image = %s :', imfile );

%HistQ = getColourHistHSV(imfile);

%HistQ = database(m).featHSV ;

%HistQ = getColourHistRGB(imfile);

%HistQ = database(m).featRGB ;

HistQ = getCNN(imfile);

HistQ = database(m).featCNN ;

for i=1:numIm

%HistD=database(i).featHSV;

%HistD=database(i).featRGB;

HistD=database(i).featCNN;

EDwithQ = sqrt(sum((HistD-HistQ).^2));

database(i).ED = EDwithQ;

end

Result=[database.ED];

[value idx] = sort(Result);

id_list = idx(1:K);

for j=2:10

id=id_list(j);

label=database(id).label;

j=j-1;

store(j)=label;

if store(j)==database(m).label

count=count+1;

end

j=j+1;

end

precision(m)=count/(K-1);

end

AvgPcs=((sum(precision))/categoryrange)*100

%in percentage