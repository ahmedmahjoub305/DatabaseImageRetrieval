function I = getCNN(filename)

net = alexnet;
net.Layers;



inputSize = net.Layers(1).InputSize ; % <227 x 227 x 3>


layer = 'fc7';
im = imread(filename); % X is <384x256x3>
im = imresize(im,[inputSize(1) inputSize(2)]); % Resize the picture for alexnet
features = activations(net,im,layer,'OutputAs','channels');

% get feature from the last fully connected layer of CNN
features_vec=squeeze(features); % <4096x1>
% This vector is good for representing image

I = features_vec;