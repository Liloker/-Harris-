%function HarrisMatch(image1, image2)
function pipei(pic1,pic2)

tic;
 %  I1 = rgb2gray(imread('PentagonLight.jpg'));

%I2 = imresize(imrotate(I1,0), 1.4);


% I1 = imread('L0001.jpg');
% I2 = imread('R0001.jpg');
    picpath1=['',pic1,'.jpg'];
    I1=imread(picpath1);
    picpath2=['',pic2,'.jpg'];
    I2=imread(picpath2);
    %I2 = imresize(imrotate(I1,30), 1);


    if (ndims(I1)==3) 
       I1 = rgb2gray(I1);
    end
     if (ndims(I2)==3) 
       I2 = rgb2gray(I2);
     end


    % points1 = detectHarrisFeatures(I1);
    % points2 = detectHarrisFeatures(I2);
    points1 = Harrissuanfa(pic1);
    points2 = Harrissuanfa(pic2);

    [f1, vpts1] = extractFeatures(I1, points1);
    [f2, vpts2] = extractFeatures(I2, points2);

    index_pairs = matchFeatures(f1, f2) ;
    matched_pts1 = vpts1(index_pairs(:, 1),:);
    matched_pts2 = vpts2(index_pairs(:, 2),:);

    figure; showMatchedFeatures(I1,I2,matched_pts1,matched_pts2,'montage');
    legend('matched points 1','matched points 2');
    toc;
end