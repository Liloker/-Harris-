

% Define images to process
imageFileNames1 = {
    '.\L\07081550_01.jpg',...
    '.\L\07081550_09.jpg',...
    '.\L\07081551_03.jpg',...
    '.\L\07081551_09.jpg',...
    '.\L\07081551_11.jpg',...
    '.\L\07081551_13.jpg',...
    '.\L\07081552_01.jpg',...
    '.\L\07081553_09.jpg',...
    '.\L\07081554_01.jpg',...
    '.\L\07081554_03.jpg',...
    };
imageFileNames2 = {
    '.\R\07081550_02.jpg',...
    '.\R\07081550_10.jpg',...
    '.\R\07081551_04.jpg',...
    '.\R\07081551_10.jpg',...
    '.\R\07081551_12.jpg',...
    '.\R\07081551_14.jpg',...
    '.\R\07081552_02.jpg',...
    '.\R\07081553_10.jpg',...
    '.\R\07081554_02.jpg',...
    '.\R\07081554_04.jpg',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames1, imageFileNames2);

% Generate world coordinates of the checkerboard keypoints
squareSize = 15;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Read one of the images from the first stereo pair
I1 = imread(imageFileNames1{1});
[mrows, ncols, ~] = size(I1);

% Calibrate the camera
[stereoParams, pairsUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', true, 'EstimateTangentialDistortion', true, ...
    'NumRadialDistortionCoefficients', 3, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% View reprojection errors
h1=figure; showReprojectionErrors(stereoParams);

% Visualize pattern locations
h2=figure; showExtrinsics(stereoParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, stereoParams);

% You can use the calibration data to rectify stereo images.
I2 = imread(imageFileNames2{1});
[J1, J2] = rectifyStereoImages(I1, I2, stereoParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('StereoCalibrationAndSceneReconstructionExample')
% showdemo('DepthEstimationFromStereoVideoExample')
