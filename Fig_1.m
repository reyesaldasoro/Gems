% im=lapisLazuli_3;
% im=amber_9;
clear all 
close all

%%

dir0=dir('train');
averages=[];
names={};
count_names=1;
template=[];
for count_1=3:size(dir0,1)
    dir1 = dir(strcat('train',filesep,dir0(count_1).name));
    for count_2=3:size(dir1,1)
        names{count_names,1}=dir1(count_2).name;

        im = imread(strcat('train',filesep,dir0(count_1).name,filesep,dir1(count_2).name));
        template(:,:,:,count_names) = imresize(im,[128 128]);
        [rows,cols,levs]=size(im);
        background_r = mean(mean(im(1:5,:,1)));
        background_g = mean( mean(im(1:5,:,2)));
        background_b = mean( mean(im(1:5,:,3)));
        
        im2=double(reshape(im,[rows*cols,3]));
        
        
        im3 = im2(( abs(im2(:,1)-background_r)+abs(im2(:,2)-background_g)+abs(im2(:,3)-background_g))>15,:);
        averages=[averages; mean(im3)];
                count_names=count_names+1;
    end
end
averages_hsv=rgb2hsv(averages/255);
[rank_hue,index_hue] = sort(averages_hsv(:,1));
%%
h4=figure(4);
clf
h141=subplot(141);
montage(template(:,:,:,index_hue(1:100))/255)
h142=subplot(142);
montage(template(:,:,:,index_hue(101:200))/255)
h143=subplot(143);
montage(template(:,:,:,index_hue(201:300))/255)
h144=subplot(144);
montage(template(:,:,:,index_hue(301:400))/255)
%
h141.Position=[0.01 0.01 0.23 0.95];
h142.Position=[0.26 0.01 0.23 0.95];
h143.Position=[0.51 0.01 0.23 0.95];
h144.Position=[0.76 0.01 0.23 0.95];
filename = 'Fig_1.png';
%%
h5=figure(5);
clf
h151=subplot(151);
montage(template(:,:,:,index_hue(2:101))/255)
h152=subplot(152);
montage(template(:,:,:,index_hue(102:201))/255)
h153=subplot(153);
montage(template(:,:,:,index_hue(202:301))/255)
h154=subplot(154);
montage(template(:,:,:,index_hue(302:401))/255)
h155=subplot(155);
montage(template(:,:,:,index_hue(402:501))/255)


h151.Position=[0.005 0.01 0.19 0.95];
h152.Position=[0.205 0.01 0.19 0.95];
h153.Position=[0.405 0.01 0.19 0.95];
h154.Position=[0.605 0.01 0.19 0.95];
h155.Position=[0.805 0.01 0.19 0.95];

filename = 'Fig_1b.png';

