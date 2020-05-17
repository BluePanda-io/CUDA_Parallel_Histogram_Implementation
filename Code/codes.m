%===============Define Matrix==========
m=2000000;

J=zeros(m,1);

for i=1:m
	J(i)=round(rand(1,1)*255);
end
%J
%===============Define Matrix END==========


%===============Start Cuda Code and ThreadBlocks==========
threadsPerBlock = [32];%[16 16];

k = parallel.gpu.CUDAKernel( 'sampleAddKernel.ptx','sampleAddKernel.cu'); % k periexi tin pliroforia tou kernel


%numberOfBlocks  = ceil( [m] ./ threadsPerBlock ); % (m,n) Size of the Image


k.ThreadBlockSize = threadsPerBlock; % Orizo ta Thread Blocks mesa sto cuda code 
k.GridSize        = 1;% numberOfBlocks;

%===============Start Cuda Code and ThreadBlocks END==========


A = int32(gpuArray(J));
B = int32(zeros(size(J), 'gpuArray'));
tic
B = gather( feval(k, A, B, m) ); % B -> einai to Histogram
m
toc
%B(1:255)


Num=254;
Sum=0;
for i=1:m
	if J(i)==Num
		Sum=Sum+1;
	end
end
%Sum
