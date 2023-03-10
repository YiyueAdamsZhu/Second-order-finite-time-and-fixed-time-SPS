% function imgOut = imgRecover(imgIn, blkSize, numSample)
% Recover the input image from a small size samples
%
% INPUT:
%   image: input image
%   
%   numSample: the number of  samples in each block
%
% OUTPUT:
%   reconst_image: recovered image
%
% 
tic;


image=imgRead('lena.bmp');
K=16;
numSample = 150;%One could set it to be smaller than no_blocks_row.

no_blocks_row = size(image,1)/K;
no_blocks_col = size(image,2)/K;

no_row = repmat(K,[1 no_blocks_row]);%creating the row dim for mat2cell

no_col = repmat(K,[1 no_blocks_col]);%creating the col dim for mat2cell

blocks = mat2cell(image,no_row,no_col);

dummy = zeros(size(image,1),size(image,2));
ghat = mat2cell(dummy,no_row,no_col);

blocks_vec = reshape(blocks,size(blocks,1)*size(blocks,2),1);

ghat_vec = reshape(blocks,size(ghat,1)*size(ghat,2),1);

for k = 1:length(blocks_vec)
%     Divide into different blocks
block = blocks_vec{k};
disp('Computing DCT')
T=transform_per_block(block,K);
C=reshape(block,size(block,1)*size(block,2),1);

%%%%%%%% NUMBER OF SAMPLES  %%%%%%%%

random_numbers = randperm(size(block,1)*size(block,2),numSample);%Let each block becomes a vector

B=C(random_numbers);
A=T(random_numbers,:);%compression

%%%%%%%%  CROSS-VALIDATION %%%%%%%%%%

m=floor(numSample/6);
disp('Initiating Cross Validation...')

[kk]=crossValidation(A,B,m);%To find the optimal sparsity(Self-trained)


%%%%%%%%%%%%%%% Self-trained Second-order finite time SPS %%%%%%%%%%%%%%%%%%%

disp('Initiating Self-trained Second-order finite time SPS')
P=A'/(A*A')*A;
q1=A'/(A*A')*B;
q2=[q1;zeros(n,1);zeros(n,1)];
[t5,x1]=ode113(@(t,y)qq2(y,P,n,t,0.5,kk,0.5,1,1),0:0.1:100,q2);% For Self-trained second-order fixed system, it should be t5,x1]=ode113(@(t,y)q5(y,P,n,t,0.5,1.5,kk,0.5,1.5,1,1),0:0.1:100,q2);
DCT=x1(end,1:n)';

%%%%%%% RECONSTRUCTING THE BLOCK %%%%%%%

ghat = T * DCT;
gghat = reshape(ghat,K,K);
ghat_vec{k} = gghat;
disp('***Finished***')
end

%%reshaping vector to matrix block arrangement
ghat_cell = reshape(ghat_vec,no_blocks_row,no_blocks_col);

%%converting block cells to image matrix
reconst_image = cell2mat(ghat_cell);
imgOut = reconst_image;
figure;imgShow(reconst_image);
ps=psnr(reconst_image,image,255)
fprintf('PSNR is %d \n',ps)
ss=ssim(reconst_image,image)
fprintf('SSIM is %d \n',ss)

toc;
% end
