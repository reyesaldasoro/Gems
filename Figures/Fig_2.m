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
averages_lab=rgb2lab(averages/255);


%%


sizeF = 12;
figure(1)
h1=subplot(131);
h11=scatter3(averages(1:end,1),averages(1:end,2),averages(1:end,3),15,[averages(1:end,:)]/255,'filled');

axis tight
view(121,64)
xlabel('Red','fontsize',sizeF)
ylabel('Green','fontsize',sizeF)
zlabel('Blue','fontsize',sizeF)



h2=subplot(132);
h22=scatter3(averages_hsv(1:end,1),averages_hsv(1:end,2),averages_hsv(1:end,3),25,averages(1:end,:)/255,'filled');
view(-171,64)

xlabel('Hue','fontsize',sizeF)
ylabel('Saturation','fontsize',sizeF)
zlabel('Value','fontsize',sizeF)

h3=subplot(133);
%h33=polarscatter(2*pi*averages_hsv(1:end,1),averages_hsv(1:end,2)+0.02,25,averages(1:end,:)/255,'filled');
% rticks([1])
% rticklabels({'Saturation'})
% h3.ThetaTick=0;
% h3.ThetaTickLabel=({'Hue'});
h33=scatter3(averages_lab(1:end,1),averages_lab(1:end,2),averages_lab(1:end,3),15,[averages(1:end,:)]/255,'filled');
xlabel('L','fontsize',sizeF)
ylabel('a*','fontsize',sizeF)
zlabel('b*','fontsize',sizeF)
axis tight
%%
h1.Title.String='(a)';
h2.Title.String='(b)';
h3.Title.String='(c)';
h1.Title.FontName

h1.Title.FontSize=28;
h2.Title.FontSize=28;
h3.Title.FontSize=28;
h1.Title.FontName='Times';
h1.Title.FontWeight='normal';
h2.Title.FontName='Times';
h2.Title.FontWeight='normal';
h3.Title.FontName='Times';
h3.Title.FontWeight='normal';



h1.Position=[0.05 0.15 0.26 0.70];
h2.Position=[0.37 0.15 0.26 0.70];
h3.Position=[0.71 0.15 0.26 0.70];
h1.View = [ 192.0424   54.6757 ];
h2.View = [ 192.0424   54.6757 ];
h3.View = [ 192.0424   54.6757 ];
%h1.View = [ -192.0424   74.6757 ];

filename = 'Fig_2.png';