% left=double(imread('b002.jpg'));
% right=double(imread('b003.jpg'));  %前辈图
clear
clc
% left=double(imread('.\L\07081550_01.jpg'));
% right=double(imread('.\R\07081550_02.jpg'));
left=double(imread('IMG_20220125_202622.jpg'));
right=double(imread('IMG_20220125_202631.jpg'));
[m, n, t]=size(left);%t三通道
w=3;     
depth=5;    
imgn=zeros(m,n);
tic;
for i=1+w:m-w
    i
    for j=1+w+depth:n-w
        tmp=[];
        lwin=left(i-w:i+w,j-w:j+w);
        for k=0:-1:-depth       
            rwin=right(i-w:i+w,j-w+k:j+w+k);
            diff=lwin-rwin;
            tmp=[tmp sum(abs(diff(:)))]; %SAD对模块求视差
        end
        [junk, imgn(i,j)]=min(tmp); 
    end
end
toc;
f=6914.16170386395; %内参焦距mm
baseline=172;%基线，双目距离mm
deep=baseline.*f./(imgn+0.001);
deep255=(deep./max(deep,[],'all').*255);
figure;
subplot(1,3,2);imshow(imgn,[])
subplot(1,3,1);imshow('IMG_20220125_202622.jpg')
subplot(1,3,3);imshow('IMG_20220125_202631.jpg')
figure;
imshow(deep255)