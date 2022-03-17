% % % coords:ͼ��ǵ����꼯�ϣ�Ϊ�˷������ʹ�ù�һ���������ƥ�䣩
% % function coords=Harris(I)
%     [m,n]=size(I);
%     %imshow(I);
%     %===================================
%     % Step 1:������ؾ���M
%     %===================================
%     tmp=zeros(m+2,n+2);
%     tmp(2:m+1,2:n+1)=I; % ����
%     Ix=zeros(m+2,n+2);% x�����ݶ�
%     Iy=zeros(m+2,n+2);% y�����ݶ�
%     Ix(:,2:n)=tmp(:,3:n+1)-tmp(:,1:n-1);
%     Iy(2:m,:)=tmp(3:m+1,:)-tmp(1:m-1,:);
%     Ix2=Ix(2:m+1,2:n+1).^2;
%     Iy2=Iy(2:m+1,2:n+1).^2;
%     Ixy=Ix(2:m+1,2:n+1).*Iy(2:m+1,2:n+1);
%     h=fspecial('gaussian',[7 7],2);
%     Ix2=filter2(h,Ix2);
%     Iy2=filter2(h,Iy2);
%     Ixy=filter2(h,Ixy);
%     %===================================
%     % Step 2:����Harris�ǵ���Ӧ
%     %===================================
%     k=0.05; % k��ȡ0.04-0.06
%     Rmax=0;
%     R=zeros(m,n);
%     for i=1:m
%         for j=1:n
%             M=[Ix2(i,j) Ixy(i,j);Ixy(i,j) Iy2(i,j)];
%             R(i,j)=det(M)-k*(trace(M))^2;     
%             if R(i,j)>Rmax
%                 Rmax=R(i,j);
%             end
%         end
%     end
%     %===================================
%     % Step 3:Ѱ��Harris�ǵ�
%     %===================================
%     tmp(2:m+1,2:n+1)=R;
%     res=zeros(m+2,n+2);
%     res(2:m+1,2:n+1)=I;
%     coords=[];
%     for i=2:m+1
%         for j=2:n+1
%             % ��3*3�����ڷǼ���ֵ����
%             if tmp(i,j)>0.01*Rmax &&...
%                tmp(i,j)>tmp(i-1,j-1) && tmp(i,j)>tmp(i-1,j) && tmp(i,j)>tmp(i-1,j+1) &&...
%                tmp(i,j)>tmp(i,j-1) && tmp(i,j)>tmp(i,j+1) &&...
%                tmp(i,j)>tmp(i+1,j-1) && tmp(i,j)>tmp(i+1,j) && tmp(i,j)>tmp(i+1,j+1)
%                     res(i,j)=255; 
%                     coords=[coords,[i-1;j-1]];
%             end    
%         end
%     end
%     disp('----------------')
%     coords;
%     figure,imshow(mat2gray(res(2:m+1,2:n+1)));
%end

%%
% close all;
% clear all;
% clc;
function coords=harris(pic)
    picpath=['',pic,'.jpg'];
    img=imread(picpath);
    imshow(img);
    img = rgb2gray(img);
    img =double(img);
    [m n]=size(img);

    tmp=zeros(m+2,n+2);
    tmp(2:m+1,2:n+1)=img;
    Ix=zeros(m+2,n+2);
    Iy=zeros(m+2,n+2);

    E=zeros(m+2,n+2);

    Ix(:,2:n)=tmp(:,3:n+1)-tmp(:,1:n-1);
    Iy(2:m,:)=tmp(3:m+1,:)-tmp(1:m-1,:);

    Ix2=Ix(2:m+1,2:n+1).^2;
    Iy2=Iy(2:m+1,2:n+1).^2;
    Ixy=Ix(2:m+1,2:n+1).*Iy(2:m+1,2:n+1);

    h=fspecial('gaussian',[7 7],2);
    Ix2=filter2(h,Ix2);
    Iy2=filter2(h,Iy2);
    Ixy=filter2(h,Ixy);

    Rmax=0;
    R=zeros(m,n);
    for i=1:m
        for j=1:n
            M=[Ix2(i,j) Ixy(i,j);Ixy(i,j) Iy2(i,j)];
            R(i,j)=det(M)-0.06*(trace(M))^2;

            if R(i,j)>Rmax
                Rmax=R(i,j);
            end
        end
    end
    re=zeros(m+2,n+2);

    tmp(2:m+1,2:n+1)=R;
    img_re=zeros(m+2,n+2);
    img_re(2:m+1,2:n+1)=img;
    coords=[];
    for i=2:m+1
        for j=2:n+1

            if tmp(i,j)>0.02*Rmax &&...
               tmp(i,j)>tmp(i-1,j-1) && tmp(i,j)>tmp(i-1,j) && tmp(i,j)>tmp(i-1,j+1) &&...
               tmp(i,j)>tmp(i,j-1) && tmp(i,j)>tmp(i,j+1) &&...
               tmp(i,j)>tmp(i+1,j-1) && tmp(i,j)>tmp(i+1,j) && tmp(i,j)>tmp(i+1,j+1)
                    img_re(i,j)=255; 
                    coords=[coords;i-1,j-1];%i�������꣬j�Ǻ�����
            end   
        end
    end
    coords

    %figure;
    %%imagesc(img_re)
    %imshow(mat2gray(img_re(2:m+1,2:n+1)))
    imshow(picpath)%Ҫ������
    hold on;plot(coords(:,2),coords(:,1),'g+')
    hold on;
end




