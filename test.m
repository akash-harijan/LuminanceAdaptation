
clear all;
clc;

x = 0.3127;
y = 0.3290;
z = 1-(x+y);

R = [0.6864 0.3110];
G = [0.2169 0.7235];
B = [0.1498 0.0546];

X= x/y;
Y= y/y;
Z = z/y;

rgbs1 = [0 0 0; 32 0 0; 64 0 0; 128 0 0; 255 0 0 ;1023 0 0 ];
rgbs2 = [0 0 0; 0 32 0; 0 64 0; 0 128 0; 0 255 0 ;0 1023 0 ];
rgbs3 = [0 0 0; 0 0 32; 0 0 64; 0 0 128; 0 0 255 ;0 0 1023 ];
rgbs4 = [0 0 0; 32 32 32; 64 32 32; 128 128 128; 255 255 255 ;1023 1023 1023 ];

catrgb = cat(1, rgbs1, rgbs2, rgbs3, rgbs4);


labs = rgb2lab(catrgb, WhitePoint=[X Y Z]);

catall = cat(2, catrgb, labs);

writematrix(catall,'test.xlsx');


%% Draw Stimulus Only




%%









%% RGB2Lab with Ali
% reference: High Dyanmic range imaging by eric reinhard page no 35 color
% spaces to see the formual of matrix.

clear all;
clc;

addpath('D:\Softwares\ColourEngineeringToolbox\colour');

x = 0.3127;
y = 0.3290;
z = 1-(x+y);

R = [0.6864 0.3110];
G = [0.2169 0.7235];
B = [0.1498 0.0546];

X= x/y;
Y= y/y;
Z = z/y;

% 
% XYZ = [R(1)/R(2) R(2)/R(2) (1-sum(R))/R(2)
% G(1)/G(2) G(2)/G(2) (1-sum(G))/G(2);
% B(1)/R(2) B(2)/B(2) (1-sum(B))/B(2);
% ];



xyz = [R(1) R(2) (1-sum(R));
G(1) G(2) (1-sum(G));
B(1) B(2) (1-sum(B));
];


wp = [X Y Z];

xyz = xyz';

s = xyz\wp';

newXYZ = zeros(3,3);

newXYZ(:, 1) = xyz(:,1)*s(1);
newXYZ(:, 2) = xyz(:,2)*s(2);
newXYZ(:, 3) = xyz(:,3)*s(3);

rgbs1 = [0 0 0; 32 0 0; 64 0 0; 128 0 0; 255 0 0 ;1023 0 0 ];
rgbs2 = [ 0 32 0; 0 64 0; 0 128 0; 0 255 0 ;0 1023 0 ];
rgbs3 = [0 0 32; 0 0 64; 0 0 128; 0 0 255 ;0 0 1023 ];
rgbs4 = [32 32 32; 64 64 64; 128 128 128; 255 255 255 ;1023 1023 1023 ];

catrgb = cat(1, rgbs1, rgbs2, rgbs3, rgbs4)/1023;

% 
convXYZ = newXYZ*catrgb';
convXYZ = convXYZ';

lab = xyz2lab(convXYZ, wp);

catall = cat(2, catrgb*1023, convXYZ);
catall = cat(2, catall, lab);

% 
writematrix(catall,'test2.xlsx');


%% 

scatter3(lab(:,2), lab(:,3), lab(:,1))
hold on
scatter3(lab(1:6,2), lab(1:6,3), lab(1:6,1), 'r')
scatter3(lab(7:11,2), lab(7:11,3), lab(7:11,1), 'g')
scatter3(lab(12:16,2), lab(12:16,3), lab(12:16,1), 'b')
scatter3(64.31283869, 51.01090523, 80, 'm')
hold off

		


%%
% lab = [90	102.1902583/2	95.49258781/2 ];


lab = [80	64.31283869	51.01090523];
xyz = lab2xyz(lab, wp);

rgb = newXYZ\xyz';
disp(rgb);


patch = ones(256,256,3);
patch(:,:,1) = rgb(1);
patch(:,:,2) = rgb(2);
patch(:,:,3) = rgb(3);

imshow(patch);








% luma = 100;
% while true
%     
%     disp(luma);
%     luma = luma + 100;
% 
%     pause
%         
% end


% rgb = [1023 0 0];
% ycbcr = rgb2ycbcr(rgb);
% % disp(ycbcr(1))
% 
% min = 16/255;
% max = 235/255;
% 
% disp(ycbcr(1));
% Y = (ycbcr(1))/255;
% disp(Y);

% set(win, 'WindowKeyPressFcn', @keyPressCallback);
% 
% function keyPressCallback(~, eventdata)
% 
%     keyPressed = eventdata.Key;
%     if strcmpi(keyPressed, 'rightarrow')
%         luma = luma + 100;
%     elseif strcmpi(keyPressed, 'leftarrow')
%         luma = luma - 100;
% 
%     elseif strcmpi(keyPressed, 'escape')
%         break
%     end
% 
% end